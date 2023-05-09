
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

pragma solidity ^0.8.0;
    
import {PlonkVerifier} from './Verifier.sol';


contract TestVerifier {

    using PlonkVerifier for *;

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

    function get_proof() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 1023554402720429913815360235286685542340370070328708348074669346722788017825;
        proof.proof_l_com_y = 9629269980833566229009828863080111129056790852199576535235077589750909464881;
        proof.proof_r_com_x = 4873481320729055103011591457497241750923518710738173427588760302859962728811;
        proof.proof_r_com_y = 10981477115425940300534324261861664659793296373954255584715581806506806851268;
        proof.proof_o_com_x = 10980220044308085830327318842617405778533300647911480797082484168178847427644;
        proof.proof_o_com_y = 13761180847606105462975316463604313118529315820635458395672044392445657192053;
        proof.proof_h_0_x = 18672348117765964966804688726916562857651970068893828939235666377489799941919;
        proof.proof_h_0_y = 5767469193583570625247597811970413784163605065128952994848107740279750516360;
        proof.proof_h_1_x = 2032467589989665633321654406587105848734997810202964170880095648405159114851;
        proof.proof_h_1_y = 11802866035295687667710133611360501380829815536386533028492305817073779360258;
        proof.proof_h_2_x = 3311831512130429427053811792269347935309811825255946383541100482831244169888;
        proof.proof_h_2_y = 21422812222679172680943370943082877030459440173711533410401846714881718466861;
        proof.proof_l_at_zeta = 20857653738819874314108816235661606915477108872112412835818030113280023742285;
        proof.proof_r_at_zeta = 19526483685261732921696268536357564405639947443729866254094171091013982334654;
        proof.proof_o_at_zeta = 610043573450110586183308439562377583436834790544908280226238173987360210373;
        proof.proof_s1_at_zeta = 5273044330110706984998919910088366231319755801136708543389181409199226762745;
        proof.proof_s2_at_zeta = 20726169990287074646862028326629493899856306324137062324801364880398369030250;
        proof.proof_grand_product_commitment_x = 16688753272714560526384344101349624405108450529296130734167403183017940506628;
        proof.proof_grand_product_commitment_y = 13964113078148093782063056713795644708010741620652574377027181616813950047565;
        proof.proof_grand_product_at_zeta_omega = 2224740578001798522660557414536410898493166930968656095587334361618515205654;
        proof.proof_quotient_polynomial_at_zeta = 20924487342796445202158961792634723587253395403714493807235167881250598441261;
        proof.proof_linearised_polynomial_at_zeta = 13835822998836313267577062174021914026020969559654328295048991011121381515760;
        proof.proof_batch_opening_at_zeta_x = 7240218045014940156799692554203747370274921140752886149993622715031631504601;
        proof.proof_batch_opening_at_zeta_y = 14449758670165879365546821284986150246485234151074174191827997601215724839867;
        proof.proof_opening_at_zeta_omega_x = 5973166662717808327092832197294774809654996525803067358288288715209154415839;
		proof.proof_opening_at_zeta_omega_y = 11184667854570348005804687804884668698286038347119102591269674368243838659622;
        proof.proof_openings_selector_commit_api_at_zeta = 19698685389843517053580581414657468784558803793427326766013350031258025828644   ;
        proof.proof_selector_commit_api_commitment_x = 8400108343546856323929332147632081945864383487896013847214362630593985713060;
        proof.proof_selector_commit_api_commitment_y = 5191512234235441440919218437871442280961534820213632630552570284217791642812;

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

    function test_verifier_go(bytes memory proof, uint256[] memory public_inputs) public {
        bool check_proof = PlonkVerifier.Verify(proof, public_inputs);
        require(check_proof, "verification failed!");
    }

    function test_verifier() public {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        

        bytes memory proof = get_proof();

        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
        require(check_proof, "verification failed!");
    }

}
