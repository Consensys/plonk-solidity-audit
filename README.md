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

#### Variables

Reference go code:

[REF_CODE_VK](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/setup.go#L55)

[REF_CODE_PROOF](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/prove.go#L46)

Verification key:
```
// correspond to Ql, Qr, Qm, Qo, Qk, Qcp kzg.Digest in REF_CODE_VK
uint256 constant vk_ql_com_x
uint256 constant vk_ql_com_y
uint256 constant vk_qr_com_x
uint256 constant vk_qr_com_y
uint256 constant vk_qm_com_x
uint256 constant vk_qm_com_y
uint256 constant vk_qo_com_x
uint256 constant vk_qo_com_y
uint256 constant vk_qk_com_x
uint256 constant vk_qk_com_y

// corresponds to S[3]kzg.Digest in REF_CODE_VK
uint256 constant vk_s1_com_x
uint256 constant vk_s1_com_y
uint256 constant vk_s2_com_x
uint256 constant vk_s2_com_y
uint256 constant vk_s3_com_x
uint256 constant vk_s3_com_y

// corresponds to Kzg.G2 in REF_CODE_VK
uint256 constant g2_srs_0_x_0
uint256 constant g2_srs_0_x_1
uint256 constant g2_srs_0_y_0
uint256 constant g2_srs_0_y_1
uint256 constant g2_srs_1_x_0
uint256 constant g2_srs_1_x_1
uint256 constant g2_srs_1_y_0
uint256 constant g2_srs_1_y_1

// corresponds to Siz,SizeInv,Generator in REF_CODE_VK
uint256 constant vk_domain_size
uint256 constant vk_inv_domain_size
uint256 constant vk_omega

// corresponds to  Qcp in REF_CODE_VK
uint256 constant vk_selector_commitments_commit_api_0_x
uint256 constant vk_selector_commitments_commit_api_0_y

// loads the slice corresponding to load_vk_commitments_indices_commit_api in REF_CODE_VK
load_vk_commitments_indices_commit_api
```

Proving key (the following are offset to the proof, which is just a stream of bytes):
```
// corresponds to the entries of LRO (in that order) in REF_CODE_PROOF
uint256 constant proof_l_com_x
uint256 constant proof_l_com_y
uint256 constant proof_r_com_x
uint256 constant proof_r_com_y
uint256 constant proof_o_com_x
uint256 constant proof_o_com_y

// corresponds to the entries of H in REF_CODE_PROOF
uint256 constant proof_h_0_x
uint256 constant proof_h_0_y
uint256 constant proof_h_1_x
uint256 constant proof_h_1_y
uint256 constant proof_h_2_x
uint256 constant proof_h_2_y

// corresponds to BatchedProof.ClaimedValues[2:7] in REF_CODE_PROOF
uint256 constant proof_l_at_zeta
uint256 constant proof_r_at_zeta
uint256 constant proof_o_at_zeta
uint256 constant proof_s1_at_zeta
uint256 constant proof_s2_at_zeta

// corresponds to Z in REF_CODE_PROOF
uint256 constant proof_grand_product_commitment_x
uint256 constant proof_grand_product_commitment_y

// corresponds to ZShiftedOpening.ClaimedValue in RED_CODE_PROOF
uint256 constant proof_grand_product_at_zeta_omega

// corresponds to BatchedProof.ClaimedValues[0:2] in REF_CODE_PROOF
uint256 constant proof_quotient_polynomial_at_zeta
uint256 constant proof_linearised_polynomial_at_zeta

// corresponds to BatchedProof.H in REF_CODE_PROOF
uint256 constant proof_batch_opening_at_zeta_x
uint256 constant proof_batch_opening_at_zeta_y 

// corresponds to ZShiftedOpening.H in REF_CODE_PROOF
uint256 constant proof_opening_at_zeta_omega_x
uint256 constant proof_opening_at_zeta_omega_y

```

#### Functions

* `derive_gamma_beta_alpha_zeta` : corresponds to l.48 to l.80 of [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L92).

* `compute_pi` : corresponds to l.92 to l.135 of [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L92). We actually compute 
`∑_{i<n} pi_{i}Lᵢ{ζ}`, with `Lᵢ(ζ) = ωⁱ/n(ζⁿ-1)/(ζ-ωⁱ)` in a first step.  Then we add to this sum `∑ᵢL_{i∈ I}Hash(Pi_{i})`. `I` here is a set of indices (obtained with `load_vk_commitments_indices_commit_api`) corresponding to the position of new public inputs derived from hashing the commitments contained in `add(proof, (mul(openings_selector_commits,0x20)))`. The hash function that is used is described [here](https://tools.ietf.org/html/draft-irtf-cfrg-hash-to-curve-06#section-5.2), with the output size hardcoded to 1 and the string hardcoded to "BSB22-Plonk". The hash function is in `contracts/Utils.sol` (the go counterpart is in [gnark-crypto](https://github.com/ConsenSys/gnark-crypto/blob/master/ecc/bn254/fr/element.go#L744)).

* `compute_alpha_square_lagrange` computes `α²1/n(ζⁿ-1)/(ζ-1)` and stores it in the state (the value is reused several times)

* `verify_quotient_poly_eval_at_zeta` corresponds to l.137 to l.176 [here](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L137). This part checks that the following equation holds:
```
l(ζ)Ql(ζ)+r(ζ)Qr(ζ)+r(ζ)l(ζ)Qm(ζ)+o(ζ)Qo(ζ)+Qk(ζ)+∑ᵢQc_{i}(ζ)Pi_{i}(ζ) + 

α[ Z(νζ)(L(ζ)+βζ+γ)(R(ζ)+uβζ+γ)(O(ζ)+u²βζ+γ)
 - Z(ζ)(L(ζ)+β σ₁(ζ)+γ)(R(ζ)+β σ₂(ζ)+γ)(O(ζ)+β σ₃(ζ)+γ)] +

α²L₀(ζ)(Z(ζ)-1) = (ζⁿ - 1)H(ζ)
```

* `fold_h`folds the commitment to H (cf [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L178))

* `compute_commitment_linearised_polynomial` computes the full commitment of the linearised polynomial digest (cf [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L190))

* `compute_gamma_kzg`, `fold_state`: those functions correspond to the `FoldProof` function of the Kzg package in gnark-crypto (see [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L232)).

* `batch_verify_multi_points` corresponds to [gnark](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L253), where here in solidity the number of proofs to fold is hardcoded to 2. The algo also corresponds to section 3.1 of the [plonk paper](https://eprint.iacr.org/2019/953.pdf).

## Risks

If any of the public inputs (see contracts/TestVerifier.sol) or the proof (see contracts/TestVerifier.sol), the proof should not pass.

## Contact

Thomas Piellard (CEST) @ThomasPiellard on telegram