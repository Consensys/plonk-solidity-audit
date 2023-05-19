package tmpl

const solidityTestVerifier = `
// SPDX-License-Identifier: Apache-2.0
// Copyright 2023 ConsenSys Software Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

pragma solidity ^0.8.19;
    
import {PlonkVerifier} from './Verifier.sol';


contract TestVerifier is PlonkVerifier {
    event PrintBool(bool a);

    struct Proof {
        uint256 proof_l_com_x;
        uint256 proof_l_com_y;
        uint256 proof_r_com_x;
        uint256 proof_r_com_y;
        uint256 proof_o_com_x;
        uint256 proof_o_com_y;

        // h = h_0 + x^{n+2}h_1 + x^{2(n+2)}h_2
        uint256 proof_h_0_x;
        uint256 proof_h_0_y;
        uint256 proof_h_1_x;
        uint256 proof_h_1_y;
        uint256 proof_h_2_x;
        uint256 proof_h_2_y;

        // wire values at zeta
        uint256 proof_l_at_zeta;
        uint256 proof_r_at_zeta;
        uint256 proof_o_at_zeta;

        //uint256[STATE_WIDTH-1] permutation_polynomials_at_zeta; // Sσ1(zeta),Sσ2(zeta)
        uint256 proof_s1_at_zeta; // Sσ1(zeta)
        uint256 proof_s2_at_zeta; // Sσ2(zeta)

        //Bn254.G1Point grand_product_commitment;                 // [z(x)]
        uint256 proof_grand_product_commitment_x;
        uint256 proof_grand_product_commitment_y;

        uint256 proof_grand_product_at_zeta_omega;                    // z(w*zeta)
        uint256 proof_quotient_polynomial_at_zeta;                    // t(zeta)
        uint256 proof_linearised_polynomial_at_zeta;               // r(zeta)

        // Folded proof for the opening of H, linearised poly, l, r, o, s_1, s_2, qcp
        uint256 proof_batch_opening_at_zeta_x;            // [Wzeta]
        uint256 proof_batch_opening_at_zeta_y;

        //Bn254.G1Point opening_at_zeta_omega_proof;      // [Wzeta*omega]
        uint256 proof_opening_at_zeta_omega_x;
        uint256 proof_opening_at_zeta_omega_y;
        
        uint256 proof_openings_selector_commit_api_at_zeta;
        uint256 proof_selector_commit_api_commitment_x;
        uint256 proof_selector_commit_api_commitment_y;
    }

    function encode_proof(Proof memory proof) internal pure
    returns (bytes memory) {

        bytes memory res;
        res = abi.encodePacked(
            proof.proof_l_com_x,
            proof.proof_l_com_y,
            proof.proof_r_com_x,
            proof.proof_r_com_y,
            proof.proof_o_com_x,
            proof.proof_o_com_y,
            proof.proof_h_0_x,
            proof.proof_h_0_y,
            proof.proof_h_1_x,
            proof.proof_h_1_y,
            proof.proof_h_2_x,
            proof.proof_h_2_y
        );
        res = abi.encodePacked(
            res,
            proof.proof_l_at_zeta,
            proof.proof_r_at_zeta,
            proof.proof_o_at_zeta
        );
        res = abi.encodePacked(
            res,
            proof.proof_s1_at_zeta,
            proof.proof_s2_at_zeta,
            proof.proof_grand_product_commitment_x,
            proof.proof_grand_product_commitment_y,
            proof.proof_grand_product_at_zeta_omega,
            proof.proof_quotient_polynomial_at_zeta,
            proof.proof_linearised_polynomial_at_zeta
        );
        res = abi.encodePacked(
            res,
            proof.proof_batch_opening_at_zeta_x,
            proof.proof_batch_opening_at_zeta_y,
            proof.proof_opening_at_zeta_omega_x,
            proof.proof_opening_at_zeta_omega_y,
            proof.proof_openings_selector_commit_api_at_zeta,
            proof.proof_selector_commit_api_commitment_x,
            proof.proof_selector_commit_api_commitment_y
        );

        return res;

    }

    function get_proof_point_not_on_curve() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        // p+1 -> the point (proof.proof_l_com_x, proof.proof_l_com_y) is not on the curve, the verifier reverts
        proof.proof_l_com_x = 21888242871839275222246405745257275088696311157297823662689037894645226208584;
        
        proof.proof_l_com_y = {{ (fpptr (index .LRO 0).Y ).String }};
        proof.proof_r_com_x = {{ (fpptr (index .LRO 1).X ).String }};
        proof.proof_r_com_y = {{ (fpptr (index .LRO 1).Y ).String }};
        proof.proof_o_com_x = {{ (fpptr (index .LRO 2).X ).String }};
        proof.proof_o_com_y = {{ (fpptr (index .LRO 2).Y ).String }};
        proof.proof_h_0_x = {{ (fpptr (index .H 0).X).String }};
        proof.proof_h_0_y = {{ (fpptr (index .H 0).Y).String }};
        proof.proof_h_1_x = {{ (fpptr (index .H 1).X).String }};
        proof.proof_h_1_y = {{ (fpptr (index .H 1).Y).String }};
        proof.proof_h_2_x = {{ (fpptr (index .H 2).X).String }};
        proof.proof_h_2_y = {{ (fpptr (index .H 2).Y).String }};
        proof.proof_l_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 2)).String }};
        proof.proof_r_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 3)).String }};
        proof.proof_o_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 4)).String }};
        proof.proof_s1_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 5)).String }};
        proof.proof_s2_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 6)).String }};
        proof.proof_grand_product_commitment_x = {{ (fpptr .Z.X).String }};
        proof.proof_grand_product_commitment_y = {{ (fpptr .Z.Y).String }};
        proof.proof_grand_product_at_zeta_omega = {{ (frptr .ZShiftedOpening.ClaimedValue).String }};
        proof.proof_quotient_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 0)).String }};
        proof.proof_linearised_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 1)).String }};
        proof.proof_batch_opening_at_zeta_x = {{ (fpptr .BatchedProof.H.X).String }};
        proof.proof_batch_opening_at_zeta_y = {{ (fpptr .BatchedProof.H.Y).String }};
        proof.proof_opening_at_zeta_omega_x = {{ (fpptr .ZShiftedOpening.H.X).String }};
		proof.proof_opening_at_zeta_omega_y = {{ (fpptr .ZShiftedOpening.H.Y).String }};
        proof.proof_openings_selector_commit_api_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 7)).String }}   ;
        proof.proof_selector_commit_api_commitment_x = {{ (fpptr .PI2.X).String }};
        proof.proof_selector_commit_api_commitment_y = {{ (fpptr .PI2.Y).String }};

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_proof_scalar_bigger_than_r() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = {{ (fpptr (index .LRO 0).X ).String }};
        proof.proof_l_com_y = {{ (fpptr (index .LRO 0).Y ).String }};
        proof.proof_r_com_x = {{ (fpptr (index .LRO 1).X ).String }};
        proof.proof_r_com_y = {{ (fpptr (index .LRO 1).Y ).String }};
        proof.proof_o_com_x = {{ (fpptr (index .LRO 2).X ).String }};
        proof.proof_o_com_y = {{ (fpptr (index .LRO 2).Y ).String }};
        proof.proof_h_0_x = {{ (fpptr (index .H 0).X).String }};
        proof.proof_h_0_y = {{ (fpptr (index .H 0).Y).String }};
        proof.proof_h_1_x = {{ (fpptr (index .H 1).X).String }};
        proof.proof_h_1_y = {{ (fpptr (index .H 1).Y).String }};
        proof.proof_h_2_x = {{ (fpptr (index .H 2).X).String }};
        proof.proof_h_2_y = {{ (fpptr (index .H 2).Y).String }};
        
        
        // r+1: the scalar exceeds r, the contract reverts
        proof.proof_l_at_zeta = 21888242871839275222246405745257275088548364400416034343698204186575808495618;
        
        proof.proof_r_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 3)).String }};
        proof.proof_o_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 4)).String }};
        proof.proof_s1_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 5)).String }};
        proof.proof_s2_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 6)).String }};
        proof.proof_grand_product_commitment_x = {{ (fpptr .Z.X).String }};
        proof.proof_grand_product_commitment_y = {{ (fpptr .Z.Y).String }};
        proof.proof_grand_product_at_zeta_omega = {{ (frptr .ZShiftedOpening.ClaimedValue).String }};
        proof.proof_quotient_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 0)).String }};
        proof.proof_linearised_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 1)).String }};
        proof.proof_batch_opening_at_zeta_x = {{ (fpptr .BatchedProof.H.X).String }};
        proof.proof_batch_opening_at_zeta_y = {{ (fpptr .BatchedProof.H.Y).String }};
        proof.proof_opening_at_zeta_omega_x = {{ (fpptr .ZShiftedOpening.H.X).String }};
		proof.proof_opening_at_zeta_omega_y = {{ (fpptr .ZShiftedOpening.H.Y).String }};
        proof.proof_openings_selector_commit_api_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 7)).String }};
        proof.proof_selector_commit_api_commitment_x = {{ (fpptr .PI2.X).String }};
        proof.proof_selector_commit_api_commitment_y = {{ (fpptr .PI2.Y).String }};

        bytes memory res = encode_proof(proof);
        return res;
    }

    // proof.proof_l_com_x,y is on the curve, but does not correspond to the data in the proof
    function get_proof_wrong_point() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        // this point is on the curve, but doesn't belong to the proof
        proof.proof_l_com_x = 1;
        proof.proof_l_com_y = 2;

        proof.proof_r_com_x = {{ (fpptr (index .LRO 1).X ).String }};
        proof.proof_r_com_y = {{ (fpptr (index .LRO 1).Y ).String }};
        proof.proof_o_com_x = {{ (fpptr (index .LRO 2).X ).String }};
        proof.proof_o_com_y = {{ (fpptr (index .LRO 2).Y ).String }};
        proof.proof_h_0_x = {{ (fpptr (index .H 0).X).String }};
        proof.proof_h_0_y = {{ (fpptr (index .H 0).Y).String }};
        proof.proof_h_1_x = {{ (fpptr (index .H 1).X).String }};
        proof.proof_h_1_y = {{ (fpptr (index .H 1).Y).String }};
        proof.proof_h_2_x = {{ (fpptr (index .H 2).X).String }};
        proof.proof_h_2_y = {{ (fpptr (index .H 2).Y).String }};
        proof.proof_l_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 2)).String }};
        proof.proof_r_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 3)).String }};
        proof.proof_o_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 4)).String }};
        proof.proof_s1_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 5)).String }};
        proof.proof_s2_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 6)).String }};
        proof.proof_grand_product_commitment_x = {{ (fpptr .Z.X).String }};
        proof.proof_grand_product_commitment_y = {{ (fpptr .Z.Y).String }};
        proof.proof_grand_product_at_zeta_omega = {{ (frptr .ZShiftedOpening.ClaimedValue).String }};
        proof.proof_quotient_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 0)).String }};
        proof.proof_linearised_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 1)).String }};
        proof.proof_batch_opening_at_zeta_x = {{ (fpptr .BatchedProof.H.X).String }};
        proof.proof_batch_opening_at_zeta_y = {{ (fpptr .BatchedProof.H.Y).String }};
        proof.proof_opening_at_zeta_omega_x = {{ (fpptr .ZShiftedOpening.H.X).String }};
		proof.proof_opening_at_zeta_omega_y = {{ (fpptr .ZShiftedOpening.H.Y).String }};
        proof.proof_openings_selector_commit_api_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 7)).String }}   ;
        proof.proof_selector_commit_api_commitment_x = {{ (fpptr .PI2.X).String }};
        proof.proof_selector_commit_api_commitment_y = {{ (fpptr .PI2.Y).String }};

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_correct_proof() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = {{ (fpptr (index .LRO 0).X ).String }};
        proof.proof_l_com_y = {{ (fpptr (index .LRO 0).Y ).String }};
        proof.proof_r_com_x = {{ (fpptr (index .LRO 1).X ).String }};
        proof.proof_r_com_y = {{ (fpptr (index .LRO 1).Y ).String }};
        proof.proof_o_com_x = {{ (fpptr (index .LRO 2).X ).String }};
        proof.proof_o_com_y = {{ (fpptr (index .LRO 2).Y ).String }};
        proof.proof_h_0_x = {{ (fpptr (index .H 0).X).String }};
        proof.proof_h_0_y = {{ (fpptr (index .H 0).Y).String }};
        proof.proof_h_1_x = {{ (fpptr (index .H 1).X).String }};
        proof.proof_h_1_y = {{ (fpptr (index .H 1).Y).String }};
        proof.proof_h_2_x = {{ (fpptr (index .H 2).X).String }};
        proof.proof_h_2_y = {{ (fpptr (index .H 2).Y).String }};
        proof.proof_l_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 2)).String }};
        proof.proof_r_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 3)).String }};
        proof.proof_o_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 4)).String }};
        proof.proof_s1_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 5)).String }};
        proof.proof_s2_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 6)).String }};
        proof.proof_grand_product_commitment_x = {{ (fpptr .Z.X).String }};
        proof.proof_grand_product_commitment_y = {{ (fpptr .Z.Y).String }};
        proof.proof_grand_product_at_zeta_omega = {{ (frptr .ZShiftedOpening.ClaimedValue).String }};
        proof.proof_quotient_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 0)).String }};
        proof.proof_linearised_polynomial_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 1)).String }};
        proof.proof_batch_opening_at_zeta_x = {{ (fpptr .BatchedProof.H.X).String }};
        proof.proof_batch_opening_at_zeta_y = {{ (fpptr .BatchedProof.H.Y).String }};
        proof.proof_opening_at_zeta_omega_x = {{ (fpptr .ZShiftedOpening.H.X).String }};
		proof.proof_opening_at_zeta_omega_y = {{ (fpptr .ZShiftedOpening.H.Y).String }};
        proof.proof_openings_selector_commit_api_at_zeta = {{ (frptr (index .BatchedProof.ClaimedValues 7)).String }}   ;
        proof.proof_selector_commit_api_commitment_x = {{ (fpptr .PI2.X).String }};
        proof.proof_selector_commit_api_commitment_y = {{ (fpptr .PI2.Y).String }};

        bytes memory res = encode_proof(proof);
        return res;
    }

    function test_verifier_go(bytes memory proof, uint256[] memory public_inputs) external view {
        bool check_proof = this.Verify(proof, public_inputs);
        require(check_proof, "verification failed!");
    }

    function test_verifier_correct_proof() external {

        uint256[] memory pi = new uint256[]({{ len .Pi }});
        {{ range $index, $element :=  .Pi }}
        pi[{{ $index }}] = {{ (frptr $element).String }};
        {{ end }}

        bytes memory proof = get_correct_proof();

        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_point_not_on_curve() external {

        uint256[] memory pi = new uint256[]({{ len .Pi }});
        {{ range $index, $element :=  .Pi }}
        pi[{{ $index }}] = {{ (frptr $element).String }};
        {{ end }}
        

        bytes memory proof = get_proof_point_not_on_curve();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_scalar_bigger_than_r() external {

        uint256[] memory pi = new uint256[]({{ len .Pi }});
        {{ range $index, $element :=  .Pi }}
        pi[{{ $index }}] = {{ (frptr $element).String }};
        {{ end }}
        

        bytes memory proof = get_proof_scalar_bigger_than_r();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_wrong_point() external {

        uint256[] memory pi = new uint256[]({{ len .Pi }});
        {{ range $index, $element :=  .Pi }}
        pi[{{ $index }}] = {{ (frptr $element).String }};
        {{ end }}
        

        bytes memory proof = get_proof_wrong_point();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_wrong_external_input() external {
        
        uint256[] memory pi = new uint256[]({{ len .Pi }});
        {{ range $index, $element :=  .Pi }}
        pi[{{ $index }}] = {{ (frptr $element).String }};
        {{ end }}
        pi[0] = pi[0] + 1;
        

        bytes memory proof = get_correct_proof();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

}
`
