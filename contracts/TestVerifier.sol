
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

    function encode_proof(Proof memory proof) internal view
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

    function get_proof_point_not_on_curve() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        // p+1 -> the point (proof.proof_l_com_x, proof.proof_l_com_y) is not on the curve, the verifier reverts
        proof.proof_l_com_x = 21888242871839275222246405745257275088696311157297823662689037894645226208584;
        
        proof.proof_l_com_y = 14373488234957724764344760955782092206281747612862482303134244354989639370884;
        proof.proof_r_com_x = 15019204286168080222589308996597642969448260982313241563417259304812981074045;
        proof.proof_r_com_y = 13724703666785271502791928177722116891337562589693335092059029147452750464326;
        proof.proof_o_com_x = 17484262407453062951537430013018636290447875045661410647205228676915782058965;
        proof.proof_o_com_y = 330924119505773375223469483769606197197675946097271469346117783311684304987;
        proof.proof_h_0_x = 9473645315125720788278074029982266803588908495759612419829428062072795046395;
        proof.proof_h_0_y = 9332970166268460637868871507202259897029572420357265121126501094898416053899;
        proof.proof_h_1_x = 3393672924631225615371092195972834461069399276837607485557398424786173841180;
        proof.proof_h_1_y = 4697989303826661567904203301590969053669616285025636498648442474293259080816;
        proof.proof_h_2_x = 8615705168462032981608119201483983610495020400009605129386241208463668481908;
        proof.proof_h_2_y = 11085279349815794906529466994387207999939415064122679696541205131631801242923;
        proof.proof_l_at_zeta = 1838059057067000754131354848209777062511841536935131891448523049529277161713;
        proof.proof_r_at_zeta = 9535266025949161658106529988464859057371192137055998081173736094658550687883;
        proof.proof_o_at_zeta = 672111165913010993107624557339647819542147539362818258683588445749381141333;
        proof.proof_s1_at_zeta = 11244180607727431539390605202691690564096651191491684894429422712976853139198;
        proof.proof_s2_at_zeta = 6980059779040307226951183239095055838655580976557105345282152751971921770819;
        proof.proof_grand_product_commitment_x = 16677289531213099609028142959323340008727094417066208122922807650287325204746;
        proof.proof_grand_product_commitment_y = 14499347861633981116705874726851976197215599205690020840168588919890893606362;
        proof.proof_grand_product_at_zeta_omega = 18611704765416421368879321394058395705718909890812850252504516186581122045324;
        proof.proof_quotient_polynomial_at_zeta = 14645199041202515304420109380808520018409147218760974389503415944300786045752;
        proof.proof_linearised_polynomial_at_zeta = 10469101801798093890705858579698880296429132414491279378984803654904335198341;
        proof.proof_batch_opening_at_zeta_x = 5013046084122801173017469256490508555329330566341150736893995046413863719092;
        proof.proof_batch_opening_at_zeta_y = 9719742085368749847131553586925871423802432929490773367755044850420523114701;
        proof.proof_opening_at_zeta_omega_x = 3341028828823900704399700135205537259924126256909381687312962085795670783594;
		proof.proof_opening_at_zeta_omega_y = 2844458166344273392012948641350060480121909016321165176011762873605216465892;
        proof.proof_openings_selector_commit_api_at_zeta = 7836662350687001305237166501731032403209734722483797259232581211847392906536   ;
        proof.proof_selector_commit_api_commitment_x = 12990308091809733452952388044659991032531993503423342333727157855403645752344;
        proof.proof_selector_commit_api_commitment_y = 10409947968920761665035069788688189403030457520023049332703359160510853097203;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_proof_scalar_bigger_than_r() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 4059671592559303126579237874351179462033056622740151295824841653839749954953;
        proof.proof_l_com_y = 14373488234957724764344760955782092206281747612862482303134244354989639370884;
        proof.proof_r_com_x = 15019204286168080222589308996597642969448260982313241563417259304812981074045;
        proof.proof_r_com_y = 13724703666785271502791928177722116891337562589693335092059029147452750464326;
        proof.proof_o_com_x = 17484262407453062951537430013018636290447875045661410647205228676915782058965;
        proof.proof_o_com_y = 330924119505773375223469483769606197197675946097271469346117783311684304987;
        proof.proof_h_0_x = 9473645315125720788278074029982266803588908495759612419829428062072795046395;
        proof.proof_h_0_y = 9332970166268460637868871507202259897029572420357265121126501094898416053899;
        proof.proof_h_1_x = 3393672924631225615371092195972834461069399276837607485557398424786173841180;
        proof.proof_h_1_y = 4697989303826661567904203301590969053669616285025636498648442474293259080816;
        proof.proof_h_2_x = 8615705168462032981608119201483983610495020400009605129386241208463668481908;
        proof.proof_h_2_y = 11085279349815794906529466994387207999939415064122679696541205131631801242923;
        
        
        // r+1: the scalar exceeds r, the contract reverts
        proof.proof_l_at_zeta = 21888242871839275222246405745257275088548364400416034343698204186575808495618;
        
        proof.proof_r_at_zeta = 9535266025949161658106529988464859057371192137055998081173736094658550687883;
        proof.proof_o_at_zeta = 672111165913010993107624557339647819542147539362818258683588445749381141333;
        proof.proof_s1_at_zeta = 11244180607727431539390605202691690564096651191491684894429422712976853139198;
        proof.proof_s2_at_zeta = 6980059779040307226951183239095055838655580976557105345282152751971921770819;
        proof.proof_grand_product_commitment_x = 16677289531213099609028142959323340008727094417066208122922807650287325204746;
        proof.proof_grand_product_commitment_y = 14499347861633981116705874726851976197215599205690020840168588919890893606362;
        proof.proof_grand_product_at_zeta_omega = 18611704765416421368879321394058395705718909890812850252504516186581122045324;
        proof.proof_quotient_polynomial_at_zeta = 14645199041202515304420109380808520018409147218760974389503415944300786045752;
        proof.proof_linearised_polynomial_at_zeta = 10469101801798093890705858579698880296429132414491279378984803654904335198341;
        proof.proof_batch_opening_at_zeta_x = 5013046084122801173017469256490508555329330566341150736893995046413863719092;
        proof.proof_batch_opening_at_zeta_y = 9719742085368749847131553586925871423802432929490773367755044850420523114701;
        proof.proof_opening_at_zeta_omega_x = 3341028828823900704399700135205537259924126256909381687312962085795670783594;
		proof.proof_opening_at_zeta_omega_y = 2844458166344273392012948641350060480121909016321165176011762873605216465892;
        proof.proof_openings_selector_commit_api_at_zeta = 7836662350687001305237166501731032403209734722483797259232581211847392906536;
        proof.proof_selector_commit_api_commitment_x = 12990308091809733452952388044659991032531993503423342333727157855403645752344;
        proof.proof_selector_commit_api_commitment_y = 10409947968920761665035069788688189403030457520023049332703359160510853097203;

        bytes memory res = encode_proof(proof);
        return res;
    }

    // proof.proof_l_com_x,y is on the curve, but does not correspond to the data in the proof
    function get_proof_wrong_point() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        // this point is on the curve, but doesn't belong to the proof
        proof.proof_l_com_x = 1;
        proof.proof_l_com_y = 2;

        proof.proof_r_com_x = 15019204286168080222589308996597642969448260982313241563417259304812981074045;
        proof.proof_r_com_y = 13724703666785271502791928177722116891337562589693335092059029147452750464326;
        proof.proof_o_com_x = 17484262407453062951537430013018636290447875045661410647205228676915782058965;
        proof.proof_o_com_y = 330924119505773375223469483769606197197675946097271469346117783311684304987;
        proof.proof_h_0_x = 9473645315125720788278074029982266803588908495759612419829428062072795046395;
        proof.proof_h_0_y = 9332970166268460637868871507202259897029572420357265121126501094898416053899;
        proof.proof_h_1_x = 3393672924631225615371092195972834461069399276837607485557398424786173841180;
        proof.proof_h_1_y = 4697989303826661567904203301590969053669616285025636498648442474293259080816;
        proof.proof_h_2_x = 8615705168462032981608119201483983610495020400009605129386241208463668481908;
        proof.proof_h_2_y = 11085279349815794906529466994387207999939415064122679696541205131631801242923;
        proof.proof_l_at_zeta = 1838059057067000754131354848209777062511841536935131891448523049529277161713;
        proof.proof_r_at_zeta = 9535266025949161658106529988464859057371192137055998081173736094658550687883;
        proof.proof_o_at_zeta = 672111165913010993107624557339647819542147539362818258683588445749381141333;
        proof.proof_s1_at_zeta = 11244180607727431539390605202691690564096651191491684894429422712976853139198;
        proof.proof_s2_at_zeta = 6980059779040307226951183239095055838655580976557105345282152751971921770819;
        proof.proof_grand_product_commitment_x = 16677289531213099609028142959323340008727094417066208122922807650287325204746;
        proof.proof_grand_product_commitment_y = 14499347861633981116705874726851976197215599205690020840168588919890893606362;
        proof.proof_grand_product_at_zeta_omega = 18611704765416421368879321394058395705718909890812850252504516186581122045324;
        proof.proof_quotient_polynomial_at_zeta = 14645199041202515304420109380808520018409147218760974389503415944300786045752;
        proof.proof_linearised_polynomial_at_zeta = 10469101801798093890705858579698880296429132414491279378984803654904335198341;
        proof.proof_batch_opening_at_zeta_x = 5013046084122801173017469256490508555329330566341150736893995046413863719092;
        proof.proof_batch_opening_at_zeta_y = 9719742085368749847131553586925871423802432929490773367755044850420523114701;
        proof.proof_opening_at_zeta_omega_x = 3341028828823900704399700135205537259924126256909381687312962085795670783594;
		proof.proof_opening_at_zeta_omega_y = 2844458166344273392012948641350060480121909016321165176011762873605216465892;
        proof.proof_openings_selector_commit_api_at_zeta = 7836662350687001305237166501731032403209734722483797259232581211847392906536   ;
        proof.proof_selector_commit_api_commitment_x = 12990308091809733452952388044659991032531993503423342333727157855403645752344;
        proof.proof_selector_commit_api_commitment_y = 10409947968920761665035069788688189403030457520023049332703359160510853097203;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_correct_proof() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 4059671592559303126579237874351179462033056622740151295824841653839749954953;
        proof.proof_l_com_y = 14373488234957724764344760955782092206281747612862482303134244354989639370884;
        proof.proof_r_com_x = 15019204286168080222589308996597642969448260982313241563417259304812981074045;
        proof.proof_r_com_y = 13724703666785271502791928177722116891337562589693335092059029147452750464326;
        proof.proof_o_com_x = 17484262407453062951537430013018636290447875045661410647205228676915782058965;
        proof.proof_o_com_y = 330924119505773375223469483769606197197675946097271469346117783311684304987;
        proof.proof_h_0_x = 9473645315125720788278074029982266803588908495759612419829428062072795046395;
        proof.proof_h_0_y = 9332970166268460637868871507202259897029572420357265121126501094898416053899;
        proof.proof_h_1_x = 3393672924631225615371092195972834461069399276837607485557398424786173841180;
        proof.proof_h_1_y = 4697989303826661567904203301590969053669616285025636498648442474293259080816;
        proof.proof_h_2_x = 8615705168462032981608119201483983610495020400009605129386241208463668481908;
        proof.proof_h_2_y = 11085279349815794906529466994387207999939415064122679696541205131631801242923;
        proof.proof_l_at_zeta = 1838059057067000754131354848209777062511841536935131891448523049529277161713;
        proof.proof_r_at_zeta = 9535266025949161658106529988464859057371192137055998081173736094658550687883;
        proof.proof_o_at_zeta = 672111165913010993107624557339647819542147539362818258683588445749381141333;
        proof.proof_s1_at_zeta = 11244180607727431539390605202691690564096651191491684894429422712976853139198;
        proof.proof_s2_at_zeta = 6980059779040307226951183239095055838655580976557105345282152751971921770819;
        proof.proof_grand_product_commitment_x = 16677289531213099609028142959323340008727094417066208122922807650287325204746;
        proof.proof_grand_product_commitment_y = 14499347861633981116705874726851976197215599205690020840168588919890893606362;
        proof.proof_grand_product_at_zeta_omega = 18611704765416421368879321394058395705718909890812850252504516186581122045324;
        proof.proof_quotient_polynomial_at_zeta = 14645199041202515304420109380808520018409147218760974389503415944300786045752;
        proof.proof_linearised_polynomial_at_zeta = 10469101801798093890705858579698880296429132414491279378984803654904335198341;
        proof.proof_batch_opening_at_zeta_x = 5013046084122801173017469256490508555329330566341150736893995046413863719092;
        proof.proof_batch_opening_at_zeta_y = 9719742085368749847131553586925871423802432929490773367755044850420523114701;
        proof.proof_opening_at_zeta_omega_x = 3341028828823900704399700135205537259924126256909381687312962085795670783594;
		proof.proof_opening_at_zeta_omega_y = 2844458166344273392012948641350060480121909016321165176011762873605216465892;
        //proof.proof_openings_selector_commit_api_at_zeta = 7836662350687001305237166501731032403209734722483797259232581211847392906536   ;
        proof.proof_openings_selector_commit_api_at_zeta = 0;
        proof.proof_selector_commit_api_commitment_x = 12990308091809733452952388044659991032531993503423342333727157855403645752344;
        proof.proof_selector_commit_api_commitment_y = 10409947968920761665035069788688189403030457520023049332703359160510853097203;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function test_verifier_go(bytes memory proof, uint256[] memory public_inputs) public {
        bool check_proof = PlonkVerifier.Verify(proof, public_inputs);
        require(check_proof, "verification failed!");
    }

    function test_verifier_correct_proof() public {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        

        bytes memory proof = get_correct_proof();

        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_point_not_on_curve() public {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        

        bytes memory proof = get_proof_point_not_on_curve();
        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_scalar_bigger_than_r() public {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        

        bytes memory proof = get_proof_scalar_bigger_than_r();
        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_wrong_point() public {

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        

        bytes memory proof = get_proof_wrong_point();
        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

    function test_verifier_proof_wrong_public_input() public {
        
        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        
        pi[0] = pi[0] + 1;
        

        bytes memory proof = get_correct_proof();
        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
    }

}
