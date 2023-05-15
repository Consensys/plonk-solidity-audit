
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
        
        proof.proof_l_com_y = 6579441406530432438292419349216046690948660614174417097749689710408225060805;
        proof.proof_r_com_x = 5982964847509800311164114451782252223241294697140834828426571738553804778664;
        proof.proof_r_com_y = 15601453538595785804747890259304363857304888521333154344867867478186260715068;
        proof.proof_o_com_x = 18659843365417451496848688115656354847098381359066629562054887271438955464636;
        proof.proof_o_com_y = 20263474626907402038074425589468263212713605438761272526910444278214263618137;
        proof.proof_h_0_x = 9178999611124705878980408320728889234515786314341698123556225897604954373451;
        proof.proof_h_0_y = 9390445213394667516718629162465010382908863323284782583959721963161656065980;
        proof.proof_h_1_x = 10092704270665918703747695417007486354387407338981061220558775545176329768541;
        proof.proof_h_1_y = 4221656739946849382207402040013411382881004019313029670382237833520567055708;
        proof.proof_h_2_x = 4228392196038320981019878029655551448104203508946290132067016706098211252714;
        proof.proof_h_2_y = 7277653125882510922435373825543219744686292379112723026939554563846224046652;
        proof.proof_l_at_zeta = 649137789301031537092013227002315562382418521220879863095510296181605219497;
        proof.proof_r_at_zeta = 21069877012133787606986170851255538040928295984262887264333631268206306868405;
        proof.proof_o_at_zeta = 8242012112767409056992847244484468956920073770466054330649799448809466104340;
        proof.proof_s1_at_zeta = 16301791368572971848530469318687163684065397957522736402235759790663004594638;
        proof.proof_s2_at_zeta = 8597807670331571322894997245727688802499934906948586189226847747752734980146;
        proof.proof_grand_product_commitment_x = 21778897518937411028176135581804478945956266482651771074455496443613042589601;
        proof.proof_grand_product_commitment_y = 7189185739617465345402171974182717658358061507547462534802019640785993393938;
        proof.proof_grand_product_at_zeta_omega = 9359367903486460549806068215298528358792364037369478070919174545395753413574;
        proof.proof_quotient_polynomial_at_zeta = 7281876998002807391859560492895585720530394386162412775624416280265821401849;
        proof.proof_linearised_polynomial_at_zeta = 3336445720271852844964668435462177159617530337248795234679341944501836340708;
        proof.proof_batch_opening_at_zeta_x = 5554802884492899754802521811456421536912976080915352260157417190010224343153;
        proof.proof_batch_opening_at_zeta_y = 14901176021624025898454217699996941454833586430389742005205693448146719285054;
        proof.proof_opening_at_zeta_omega_x = 6226328458483392452830829546796594275142995267893633249786946347388901711667;
		proof.proof_opening_at_zeta_omega_y = 6309152098382469408085710840103997470562571563548938902730899234190740012193;
        proof.proof_openings_selector_commit_api_at_zeta = 18173146514033421094780504763725727379077675133572263877402248546457666773191   ;
        proof.proof_selector_commit_api_commitment_x = 16189441987790760340055570749226807116137587070301813054508257788829863632004;
        proof.proof_selector_commit_api_commitment_y = 7241073996852894213812630939350637662059722867868988759703554692398360953047;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_proof_scalar_bigger_than_r() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 3810668476795560367752726731213094290946889306309739911056423055569510804809;
        proof.proof_l_com_y = 6579441406530432438292419349216046690948660614174417097749689710408225060805;
        proof.proof_r_com_x = 5982964847509800311164114451782252223241294697140834828426571738553804778664;
        proof.proof_r_com_y = 15601453538595785804747890259304363857304888521333154344867867478186260715068;
        proof.proof_o_com_x = 18659843365417451496848688115656354847098381359066629562054887271438955464636;
        proof.proof_o_com_y = 20263474626907402038074425589468263212713605438761272526910444278214263618137;
        proof.proof_h_0_x = 9178999611124705878980408320728889234515786314341698123556225897604954373451;
        proof.proof_h_0_y = 9390445213394667516718629162465010382908863323284782583959721963161656065980;
        proof.proof_h_1_x = 10092704270665918703747695417007486354387407338981061220558775545176329768541;
        proof.proof_h_1_y = 4221656739946849382207402040013411382881004019313029670382237833520567055708;
        proof.proof_h_2_x = 4228392196038320981019878029655551448104203508946290132067016706098211252714;
        proof.proof_h_2_y = 7277653125882510922435373825543219744686292379112723026939554563846224046652;
        
        
        // r+1: the scalar exceeds r, the contract reverts
        proof.proof_l_at_zeta = 21888242871839275222246405745257275088548364400416034343698204186575808495618;
        
        proof.proof_r_at_zeta = 21069877012133787606986170851255538040928295984262887264333631268206306868405;
        proof.proof_o_at_zeta = 8242012112767409056992847244484468956920073770466054330649799448809466104340;
        proof.proof_s1_at_zeta = 16301791368572971848530469318687163684065397957522736402235759790663004594638;
        proof.proof_s2_at_zeta = 8597807670331571322894997245727688802499934906948586189226847747752734980146;
        proof.proof_grand_product_commitment_x = 21778897518937411028176135581804478945956266482651771074455496443613042589601;
        proof.proof_grand_product_commitment_y = 7189185739617465345402171974182717658358061507547462534802019640785993393938;
        proof.proof_grand_product_at_zeta_omega = 9359367903486460549806068215298528358792364037369478070919174545395753413574;
        proof.proof_quotient_polynomial_at_zeta = 7281876998002807391859560492895585720530394386162412775624416280265821401849;
        proof.proof_linearised_polynomial_at_zeta = 3336445720271852844964668435462177159617530337248795234679341944501836340708;
        proof.proof_batch_opening_at_zeta_x = 5554802884492899754802521811456421536912976080915352260157417190010224343153;
        proof.proof_batch_opening_at_zeta_y = 14901176021624025898454217699996941454833586430389742005205693448146719285054;
        proof.proof_opening_at_zeta_omega_x = 6226328458483392452830829546796594275142995267893633249786946347388901711667;
		proof.proof_opening_at_zeta_omega_y = 6309152098382469408085710840103997470562571563548938902730899234190740012193;
        proof.proof_openings_selector_commit_api_at_zeta = 18173146514033421094780504763725727379077675133572263877402248546457666773191;
        proof.proof_selector_commit_api_commitment_x = 16189441987790760340055570749226807116137587070301813054508257788829863632004;
        proof.proof_selector_commit_api_commitment_y = 7241073996852894213812630939350637662059722867868988759703554692398360953047;

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

        proof.proof_r_com_x = 5982964847509800311164114451782252223241294697140834828426571738553804778664;
        proof.proof_r_com_y = 15601453538595785804747890259304363857304888521333154344867867478186260715068;
        proof.proof_o_com_x = 18659843365417451496848688115656354847098381359066629562054887271438955464636;
        proof.proof_o_com_y = 20263474626907402038074425589468263212713605438761272526910444278214263618137;
        proof.proof_h_0_x = 9178999611124705878980408320728889234515786314341698123556225897604954373451;
        proof.proof_h_0_y = 9390445213394667516718629162465010382908863323284782583959721963161656065980;
        proof.proof_h_1_x = 10092704270665918703747695417007486354387407338981061220558775545176329768541;
        proof.proof_h_1_y = 4221656739946849382207402040013411382881004019313029670382237833520567055708;
        proof.proof_h_2_x = 4228392196038320981019878029655551448104203508946290132067016706098211252714;
        proof.proof_h_2_y = 7277653125882510922435373825543219744686292379112723026939554563846224046652;
        proof.proof_l_at_zeta = 649137789301031537092013227002315562382418521220879863095510296181605219497;
        proof.proof_r_at_zeta = 21069877012133787606986170851255538040928295984262887264333631268206306868405;
        proof.proof_o_at_zeta = 8242012112767409056992847244484468956920073770466054330649799448809466104340;
        proof.proof_s1_at_zeta = 16301791368572971848530469318687163684065397957522736402235759790663004594638;
        proof.proof_s2_at_zeta = 8597807670331571322894997245727688802499934906948586189226847747752734980146;
        proof.proof_grand_product_commitment_x = 21778897518937411028176135581804478945956266482651771074455496443613042589601;
        proof.proof_grand_product_commitment_y = 7189185739617465345402171974182717658358061507547462534802019640785993393938;
        proof.proof_grand_product_at_zeta_omega = 9359367903486460549806068215298528358792364037369478070919174545395753413574;
        proof.proof_quotient_polynomial_at_zeta = 7281876998002807391859560492895585720530394386162412775624416280265821401849;
        proof.proof_linearised_polynomial_at_zeta = 3336445720271852844964668435462177159617530337248795234679341944501836340708;
        proof.proof_batch_opening_at_zeta_x = 5554802884492899754802521811456421536912976080915352260157417190010224343153;
        proof.proof_batch_opening_at_zeta_y = 14901176021624025898454217699996941454833586430389742005205693448146719285054;
        proof.proof_opening_at_zeta_omega_x = 6226328458483392452830829546796594275142995267893633249786946347388901711667;
		proof.proof_opening_at_zeta_omega_y = 6309152098382469408085710840103997470562571563548938902730899234190740012193;
        proof.proof_openings_selector_commit_api_at_zeta = 18173146514033421094780504763725727379077675133572263877402248546457666773191   ;
        proof.proof_selector_commit_api_commitment_x = 16189441987790760340055570749226807116137587070301813054508257788829863632004;
        proof.proof_selector_commit_api_commitment_y = 7241073996852894213812630939350637662059722867868988759703554692398360953047;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_correct_proof() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 3810668476795560367752726731213094290946889306309739911056423055569510804809;
        proof.proof_l_com_y = 6579441406530432438292419349216046690948660614174417097749689710408225060805;
        proof.proof_r_com_x = 5982964847509800311164114451782252223241294697140834828426571738553804778664;
        proof.proof_r_com_y = 15601453538595785804747890259304363857304888521333154344867867478186260715068;
        proof.proof_o_com_x = 18659843365417451496848688115656354847098381359066629562054887271438955464636;
        proof.proof_o_com_y = 20263474626907402038074425589468263212713605438761272526910444278214263618137;
        proof.proof_h_0_x = 9178999611124705878980408320728889234515786314341698123556225897604954373451;
        proof.proof_h_0_y = 9390445213394667516718629162465010382908863323284782583959721963161656065980;
        proof.proof_h_1_x = 10092704270665918703747695417007486354387407338981061220558775545176329768541;
        proof.proof_h_1_y = 4221656739946849382207402040013411382881004019313029670382237833520567055708;
        proof.proof_h_2_x = 4228392196038320981019878029655551448104203508946290132067016706098211252714;
        proof.proof_h_2_y = 7277653125882510922435373825543219744686292379112723026939554563846224046652;
        proof.proof_l_at_zeta = 649137789301031537092013227002315562382418521220879863095510296181605219497;
        proof.proof_r_at_zeta = 21069877012133787606986170851255538040928295984262887264333631268206306868405;
        proof.proof_o_at_zeta = 8242012112767409056992847244484468956920073770466054330649799448809466104340;
        proof.proof_s1_at_zeta = 16301791368572971848530469318687163684065397957522736402235759790663004594638;
        proof.proof_s2_at_zeta = 8597807670331571322894997245727688802499934906948586189226847747752734980146;
        proof.proof_grand_product_commitment_x = 21778897518937411028176135581804478945956266482651771074455496443613042589601;
        proof.proof_grand_product_commitment_y = 7189185739617465345402171974182717658358061507547462534802019640785993393938;
        proof.proof_grand_product_at_zeta_omega = 9359367903486460549806068215298528358792364037369478070919174545395753413574;
        proof.proof_quotient_polynomial_at_zeta = 7281876998002807391859560492895585720530394386162412775624416280265821401849;
        proof.proof_linearised_polynomial_at_zeta = 3336445720271852844964668435462177159617530337248795234679341944501836340708;
        proof.proof_batch_opening_at_zeta_x = 5554802884492899754802521811456421536912976080915352260157417190010224343153;
        proof.proof_batch_opening_at_zeta_y = 14901176021624025898454217699996941454833586430389742005205693448146719285054;
        proof.proof_opening_at_zeta_omega_x = 6226328458483392452830829546796594275142995267893633249786946347388901711667;
		proof.proof_opening_at_zeta_omega_y = 6309152098382469408085710840103997470562571563548938902730899234190740012193;
        proof.proof_openings_selector_commit_api_at_zeta = 18173146514033421094780504763725727379077675133572263877402248546457666773191   ;
        proof.proof_selector_commit_api_commitment_x = 16189441987790760340055570749226807116137587070301813054508257788829863632004;
        proof.proof_selector_commit_api_commitment_y = 7241073996852894213812630939350637662059722867868988759703554692398360953047;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function test_verifier_go(bytes memory proof, uint256[] memory public_inputs) external view {
        bool check_proof = this.Verify(proof, public_inputs);
        require(check_proof, "verification failed!");
    }

    function test_verifier_correct_proof() external {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        

        bytes memory proof = get_correct_proof();

        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_point_not_on_curve() external {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        

        bytes memory proof = get_proof_point_not_on_curve();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_scalar_bigger_than_r() external {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        

        bytes memory proof = get_proof_scalar_bigger_than_r();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_wrong_point() external {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        

        bytes memory proof = get_proof_wrong_point();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_wrong_external_input() external {
        
        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        pi[0] = pi[0] + 1;
        

        bytes memory proof = get_correct_proof();
        bool check_proof = this.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

}
