# Plonk with Commit API solidity verifier

This repository contains an implementation of the [plonk](https://eprint.iacr.org/2019/953.pdf) verifier with the addition of a custom gate to handle Fiat Shamir in circuit. It follows the [gnark](https://github.com/ConsenSys/gnark/tree/develop/backend/plonk/bn254) implementation of the plonk verifier (in verify.go in the previous link) for BN254.


## Useful Links

* [Original plonk paper, p.30](https://eprint.iacr.org/2019/953.pdf) 🏁
* [Go code](https://github.com/ConsenSys/gnark/blob/develop/backend/plonk/bn254/verify.go#L43)

### Example

```bash
go generate ./internal/ 
```
Generates the solidity files in `contracts`, corresponding to the circuit defined in `/internal/main.go` (the circuit doesn't matter). The logic of the code is the same for all circuits, but the constants corresponding to the verification key in `contracts/Verifier.sol` will change from one circuit to another. The proof is hardcoded in `contracts/TestVerifier.sol` for testing only.

```bash
make all
```
Clean `/abi' and `/gopkg` and compiles the contracts in `/contracts`.

```bash
go run main.go
```
Create a simulated evm backend using geth, and call `test_verifier()` in `TestVerifier.sol`. An event is emitted that captures the result. The console should output `true`.

In `TestVerifier.sol`, if any part of the proof of the public inputs is changed, the verification should fail.