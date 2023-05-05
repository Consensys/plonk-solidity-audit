# Plonk with Commit API solidity verifier

This repository contains an implementation of the [plonk](https://eprint.iacr.org/2019/953.pdf) verifier with the addition of a custom gate to handle Fiat Shamir in circuit. It follows the [gnark](https://github.com/ConsenSys/gnark/tree/develop/backend/plonk/bn254) implementation of the plonk verifier (in verify.go in the previous link) for BN254.


## Useful Links

* [Original plonk paper, p.30](https://eprint.iacr.org/2019/953.pdf) 🏁
* [Go code](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L43)

## Example

```bash
go generate ./internal/ 
```
Generates the solidity files in `contracts`, corresponding to the circuit defined in `/internal/main.go` (the circuit doesn't matter). The logic of the code is the same for all circuits, but the constants corresponding to the verification key in `contracts/Verifier.sol` will change from one circuit to another. The proof is hardcoded in `contracts/TestVerifier.sol` for testing only.

```bash
make all
```
Clean `/abi` and `/gopkg` and compiles the contracts in `/contracts`.

```bash
go run main.go
```
Create a simulated evm backend using geth, and call `test_verifier()` in `TestVerifier.sol`. An event is emitted that captures the result. The console should output `true`.

In `TestVerifier.sol`, if any part of the proof of the public inputs is changed, the verification should fail.

## Scope

The files in the scope of the audit are
* contracts/Utils.sol
* contracts/Verifier.sol

All the remaing filed except the two above are out of scope.

## Intended Functionnality

`Verifier.sol` follows the gnark's implementation [here](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L43).

## Code guide

### Naming convention

* All the constants starting with `vk_` are related to the verification key.

* All the constants starting with `proof_`are related to the proof, and correspond to offsets on the `bytes memory proof`.
ex: `add(proof, proof_l_at_zeta)` is a pointer to the part of the proof corresponding the claimed value of the committed polnyomial `l` at `zeta`.

* All the variables and constants having the suffix `_x` or `_y` correspond to coordinates of points on `Bn254(Fp)`, with an exception of `g2_srs_≤1,2>_<x,y>_<0,1>` which correspond to points on `Bn254(Fp^2)`. Ex: the variables a:=`g2_srs_0_x_0`and b:=`g2_srs_0_x_1` correspond to the element a*u+b in Fp^2=Fp(u) (following solidity convention).

* The variables and constants starting with `state_` correspond to variables that are used all along the proof verification process. Those variables live in the memory slot starting from the free pointer at `mload(0x40)` (in the scope of the `Verify` function) and ending at `state_last_mem`. The slot  `state_check_var` was used for debugging only.

### Custom gate

Our plonk gates look like this `QₗL + QᵣR + QₘLR + QₒO + Qₖ + ∑ᵢQcp_{i∈ I}Pi_{i}`. In the regular plonk (from the [paper](https://eprint.iacr.org/2019/953.pdf) ) the last term (`∑ᵢQcp_{i∈ I}Pi_{i}`) does not appear.

The differences of our verification algorithm from the original paper are:
* the computation of the public inputs
* the computation of the linearised polynomial
Both are described in the next section.

### Mapping solidity <-> go

* `derive_gamma_beta_alpha_zeta` : corresponds to l.48 to l.80 of [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L92).

* `compute_pi` : corresponds to l.92 to l.135 of [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L92). We actually compute 
`∑_{i<n} pi_{i}Lᵢ{ζ}`, with `Lᵢ(ζ) = ωⁱ/n(ζⁿ-1)/(ζ-ωⁱ)` in a first step.  Then we add to this sum `∑ᵢL_{i∈ I}Hash(Pi_{i})`. `I` here is a set of indices (obtained with `load_vk_commitments_indices_commit_api`) corresponding to the position of new public inputs derived from hashing commitments contained in `add(proof, (mul(openings_selector_commits,0x20)))`. The hash function that is used is described [here](https://tools.ietf.org/html/draft-irtf-cfrg-hash-to-curve-06#section-5.2), with the output size hardcoded to 1 and the string hardcoded to "BSB22-Plonk". The hash function is in `contracts/Utils.sol` (the go counterpart is in [gnark-crypto](https://github.com/ConsenSys/gnark-crypto/blob/master/ecc/bn254/fr/element.go#L744)).