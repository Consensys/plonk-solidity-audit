
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

        proof.proof_l_com_x = 5810894301782093184325900221225915662323104680506585846003347921914225830770;
        proof.proof_l_com_y = 13213171645786107577112345909816072907072746313059025944850681167502603858822;
        proof.proof_r_com_x = 1551359344070115324277892854252934247138655965064256351807470130883718041308;
        proof.proof_r_com_y = 16509721677062050500811183873153241699179957471297673291499002160946455706309;
        proof.proof_o_com_x = 4892854439851145382244524993404099998375086141640243522204715464923853547579;
        proof.proof_o_com_y = 9267424672654412856873174408185185841571071871840712467143784132107088636667;
        proof.proof_h_0_x = 21653270923173760013311940920872008559577718258525226588352381726187556710273;
        proof.proof_h_0_y = 3912353244453536933583059974938065470888070601619216354385947705994108828564;
        proof.proof_h_1_x = 21303011837430752486068513632721073444411517444589009203893311407409193423297;
        proof.proof_h_1_y = 536250927349607893290565348381722194560439663016002256982554254331230233485;
        proof.proof_h_2_x = 8618820478039769580370847143660878911376763695588624755141654016651120925105;
        proof.proof_h_2_y = 15412228626525307691878775137213713906639944871280214182776851621074848588680;
        proof.proof_l_at_zeta = 17392699648171995792001533413990733265988817805972735548068224779109868739389;
        proof.proof_r_at_zeta = 1019812166662401456061634862293480032665049933547001448104533793769935757099;
        proof.proof_o_at_zeta = 2179732837572443483912125743482440644231440672082714185014383193825041327552;
        proof.proof_s1_at_zeta = 4472918741441831565654782053029452582643010150863738125454426054927522350723;
        proof.proof_s2_at_zeta = 10875166712911032476521539197813583600996810297349104946870898839556311086246;
        proof.proof_grand_product_commitment_x = 14086023220076329851699560518855326739025453256179133175106767493302308129899;
        proof.proof_grand_product_commitment_y = 5679558265064113646671081874896776923361828213747748820870981011679548438201;
        proof.proof_grand_product_at_zeta_omega = 2891299846414152200141549032245085688927820939506063512410633622791942808927;
        proof.proof_quotient_polynomial_at_zeta = 20519848762286463657553271962470844594593632392649282758548110232600282176463;
        proof.proof_linearised_polynomial_at_zeta = 6442227523024881679875223392177862474578144560165853291345117812114351812760;
        proof.proof_batch_opening_at_zeta_x = 20295773787680166156198639724065732364776615456053088632210778331363708862445;
        proof.proof_batch_opening_at_zeta_y = 5780922217569522393979614194481343529544186583877013480196615467236248799551;
        proof.proof_opening_at_zeta_omega_x = 14044613016174047855624496928426921635066389493786905326174871927690154361985;
		proof.proof_opening_at_zeta_omega_y = 3937921886660142957539185082741853787722875117539877954529479101133240409492;
        proof.proof_openings_selector_commit_api_at_zeta = 3188357263636108657260104545445611131264698332286711173032048893347085800942   ;
        proof.proof_selector_commit_api_commitment_x = 2099916700597273953233064494991910861755567985418070798171067854498732313106;
        proof.proof_selector_commit_api_commitment_y = 7515224069924857339804802334736831062166132667163661314240453355006853295248;

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
