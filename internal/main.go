package main

import (
	"fmt"
	"os"

	"github.com/consensys/gnark-crypto/ecc"
	"github.com/consensys/gnark-crypto/ecc/bn254/fr"
	"github.com/consensys/gnark/backend/plonk"
	bn254plonk "github.com/consensys/gnark/backend/plonk/bn254"
	"github.com/consensys/gnark/frontend"
	"github.com/consensys/gnark/frontend/cs/scs"
	fiatshamir "github.com/consensys/gnark/std/fiat-shamir"
	"github.com/consensys/gnark/std/hash/mimc"
	"github.com/consensys/gnark/test"
	"github.com/consensys/plonk-solidity/tmpl"
)

func checkError(err error) {
	if err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
}

// ------------------------------------------
// school book Fiat Shamir
type SbFiatShamir struct {
	X [10]frontend.Variable
	Y [10]frontend.Variable `gnark:",public"`
}

// The circuit generates a sequence of values from its private inputs X.
// Namely it adds 1 to every private inputs, the resulting set of values is stored
// in vals. The goal of the circuit is to ensure
// that the values in vals appear exactly once in the list of the given public values.
// For instance if Y = [3,4,5,6,7,8,9,10,11,12] then the circuit ensures that vals contains
// exactly one of each value in Y.
// To do that, we check the following identity:
// Π_{i<10}(Yᵢ-x) ==? Π_{i<10}(Xᵢ-x) where x is derived using Fiat Shamir with hash.
func (c *SbFiatShamir) Define(api frontend.API) error {

	// 1 - generate the values vals (here we add 1 to the private inputs to
	// simulate a real operation but it could be anything)
	vals := make([]frontend.Variable, 10)
	for i := 0; i < len(c.X); i++ {
		vals[i] = api.Add(c.X[i], 1)
	}

	// 2 - generate the challenge using Fiat Shamir + mimc
	h, err := mimc.NewMiMC(api)
	if err != nil {
		return err
	}
	tsSnark := fiatshamir.NewTranscript(api, &h, "x")
	if err := tsSnark.Bind("x", vals[:]); err != nil {
		return err
	}
	if err := tsSnark.Bind("x", c.Y[:]); err != nil {
		return err
	}
	x, err := tsSnark.ComputeChallenge("x")
	if err != nil {
		return err
	}

	// 3 - compute both products Π_{i<10}(Yᵢ-x) and Π_{i<10}(Xᵢ-x)
	var rhs, lhs, tmp frontend.Variable
	rhs = 1
	lhs = 1
	for i := 0; i < len(vals); i++ {

		tmp = api.Sub(x, vals[i])
		lhs = api.Mul(lhs, tmp)

		tmp = api.Sub(x, c.Y[i])
		rhs = api.Mul(rhs, tmp)
	}

	api.AssertIsEqual(rhs, lhs)

	return nil
}

func getVkProofSbFiatShamir() (bn254plonk.Proof, bn254plonk.VerifyingKey, []fr.Element) {

	var circuit SbFiatShamir
	ccs, err := frontend.Compile(ecc.BN254.ScalarField(), scs.NewBuilder, &circuit)
	checkError(err)

	var witness SbFiatShamir
	for i := 0; i < len(witness.X); i++ {
		witness.X[i] = i + 9 // the circuit adds 1 to the X's, and checks that the X's appear exactly once in Y
		witness.Y[i] = i + 10
	}
	witnessFull, err := frontend.NewWitness(&witness, ecc.BN254.ScalarField())
	checkError(err)
	witnessPublic, err := witnessFull.Public()
	checkError(err)

	srs, err := test.NewKZGSRS(ccs)
	checkError(err)

	pk, vk, err := plonk.Setup(ccs, srs)
	checkError(err)

	proof, err := plonk.Prove(ccs, pk, witnessFull)
	checkError(err)

	err = plonk.Verify(proof, vk, witnessPublic)
	checkError(err)

	tvk := vk.(*bn254plonk.VerifyingKey)
	tproof := proof.(*bn254plonk.Proof)

	ipi := witnessPublic.Vector()
	pi := ipi.(fr.Vector)

	return *tproof, *tvk, pi
}

// ------------------------------------------
// Fiat Shamir using commitment
type ComFiatShamir struct {
	X [10]frontend.Variable
	Y [10]frontend.Variable `gnark:",public"`
}

// The circuit generates a sequence of values from its private inputs X.
// Namely it adds 1 to every private inputs, the resulting set of values is stored
// in vals. The goal of the circuit is to ensure
// that the values in vals appear exactly once in the list of the given public values.
// For instance if Y = [3,4,5,6,7,8,9,10,11,12] then the circuit ensures that vals contains
// exactly one of each value in Y.
// To do that, we check the following identity:
// Π_{i<10}(Yᵢ-x) ==? Π_{i<10}(Xᵢ-x) where x is derived using Fiat Shamir with hash.
func (c *ComFiatShamir) Define(api frontend.API) error {

	// 1 - generate the values vals (here we add 1 to the private inputs to
	// simulate a real operation but it could be anything)
	vals := make([]frontend.Variable, 10)
	for i := 0; i < len(c.X); i++ {
		vals[i] = api.Add(c.X[i], 1)
	}

	// 2 - generate the challenge using Commit api
	committer, ok := api.(frontend.Committer)
	if !ok {
		return fmt.Errorf("type %T doesn't impl the Committer interface", api)
	}
	args := make([]frontend.Variable, len(c.X)+len(vals))
	copy(args, vals[:])
	copy(args[len(vals):], c.Y[:])
	x, err := committer.Commit(args)
	if err != nil {
		return err
	}

	// 3 - compute both products Π_{i<10}(Yᵢ-x) and Π_{i<10}(Xᵢ-x)
	var rhs, lhs, tmp frontend.Variable
	rhs = 1
	lhs = 1
	for i := 0; i < len(vals); i++ {

		tmp = api.Sub(x, vals[i])
		lhs = api.Mul(lhs, tmp)

		tmp = api.Sub(x, c.Y[i])
		rhs = api.Mul(rhs, tmp)
	}

	api.AssertIsEqual(rhs, lhs)

	return nil
}

func getVkProofComFiatShamir() (bn254plonk.Proof, bn254plonk.VerifyingKey, []fr.Element) {

	var circuit ComFiatShamir
	ccs, err := frontend.Compile(ecc.BN254.ScalarField(), scs.NewBuilder, &circuit)
	checkError(err)

	var witness ComFiatShamir
	for i := 0; i < len(witness.X); i++ {
		witness.X[i] = i + 9 // the circuit adds 1 to the X's, and checks that the X's appear exactly once in Y
		witness.Y[i] = i + 10
	}
	witnessFull, err := frontend.NewWitness(&witness, ecc.BN254.ScalarField())
	checkError(err)
	witnessPublic, err := witnessFull.Public()
	checkError(err)

	srs, err := test.NewKZGSRS(ccs)
	checkError(err)

	pk, vk, err := plonk.Setup(ccs, srs)
	checkError(err)

	proof, err := plonk.Prove(ccs, pk, witnessFull)
	checkError(err)

	err = plonk.Verify(proof, vk, witnessPublic)
	checkError(err)

	tvk := vk.(*bn254plonk.VerifyingKey)
	tproof := proof.(*bn254plonk.Proof)

	ipi := witnessPublic.Vector()
	pi := ipi.(fr.Vector)

	return *tproof, *tvk, pi
}

// ------------------------------------------
// multiple commitments

type multipleCommitmentCircuit struct {
	X frontend.Variable
	Y frontend.Variable `gnark:",public"`
}

func (c *multipleCommitmentCircuit) Define(api frontend.API) error {

	a := api.Mul(c.X, c.X, c.X)

	committer, ok := api.(frontend.Committer)
	if !ok {
		return fmt.Errorf("type %T doesn't impl the Committer interface", api)
	}

	b, err := committer.Commit(a)
	if err != nil {
		return err
	}

	d, err := committer.Commit(b)
	if err != nil {
		return err
	}

	e, err := committer.Commit(a, b, d)
	if err != nil {
		return err
	}

	api.AssertIsDifferent(e, c.Y)

	return nil
}

func getVkProofmultipleCommitmentCircuit() (bn254plonk.Proof, bn254plonk.VerifyingKey, []fr.Element) {

	var circuit multipleCommitmentCircuit
	ccs, err := frontend.Compile(ecc.BN254.ScalarField(), scs.NewBuilder, &circuit)
	checkError(err)

	var witness multipleCommitmentCircuit
	witness.X = 2
	witness.Y = 3
	witnessFull, err := frontend.NewWitness(&witness, ecc.BN254.ScalarField())
	checkError(err)
	witnessPublic, err := witnessFull.Public()
	checkError(err)

	srs, err := test.NewKZGSRS(ccs)
	checkError(err)

	pk, vk, err := plonk.Setup(ccs, srs)
	checkError(err)

	proof, err := plonk.Prove(ccs, pk, witnessFull)
	checkError(err)

	err = plonk.Verify(proof, vk, witnessPublic)
	checkError(err)

	tvk := vk.(*bn254plonk.VerifyingKey)
	tproof := proof.(*bn254plonk.Proof)

	ipi := witnessPublic.Vector()
	pi := ipi.(fr.Vector)

	return *tproof, *tvk, pi
}

//go:generate go run main.go
func main() {

	proof, vk, pi := getVkProofComFiatShamir()
	// proof, vk, pi := getVkProofSbFiatShamir()

	err := tmpl.GenerateVerifier(vk, proof, pi, "../contracts")
	checkError(err)

}
