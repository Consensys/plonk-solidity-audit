
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
        
        proof.proof_l_com_y = 9594082766851788293224429217927280855067804963720375625641053322529391085937;
        proof.proof_r_com_x = 11751393882197587453367061883029613574054292681257758365139088912414373652636;
        proof.proof_r_com_y = 19120189085541302315955717908033404841760472821182151814614584210306214529343;
        proof.proof_o_com_x = 7221230371819722291316872182829443607635748027387348067608253891061063652562;
        proof.proof_o_com_y = 11079417629928767264156894342810084192403010251585239009895186914595389593213;
        proof.proof_h_0_x = 17489026203157166651425157199859910837083604431116004661181185474211824365956;
        proof.proof_h_0_y = 21802947338337730941042344427580013835438122777898200517628734312133759362221;
        proof.proof_h_1_x = 16714522220647336319088289227729856868989653284294194351400574693851802892445;
        proof.proof_h_1_y = 11226847356565274353114400595107992302081453858617086112724666554954475496270;
        proof.proof_h_2_x = 13447108487355453029435432599765643105282678633446124501240223136678759205346;
        proof.proof_h_2_y = 14635529963350141975562113298285479191770546733114701726505952288605794263683;
        proof.proof_l_at_zeta = 14981949455848581440351306768383274234658187585218720123637357751010056983628;
        proof.proof_r_at_zeta = 193083142840193507366433042657784144716600087713330609815218652599803660270;
        proof.proof_o_at_zeta = 10695565368637494388776493630405971843338615897876113200945525478957081604446;
        proof.proof_s1_at_zeta = 19433152785740303143096782572490322799255176038415944894983960987190705707566;
        proof.proof_s2_at_zeta = 11634003034387522537658180597875676738232128855917383827291605339343519742581;
        proof.proof_grand_product_commitment_x = 3849618507417157752781543115765729620051883293721770632535186858955524909141;
        proof.proof_grand_product_commitment_y = 12570752389585965632440408271339637648907161313149329407346502220755554078882;
        proof.proof_grand_product_at_zeta_omega = 5592800445762367975693680318747481778184205106220449706427550464959866434982;
        proof.proof_quotient_polynomial_at_zeta = 14151271352756327158765022864019258031550697683935990979653397269957472668692;
        proof.proof_linearised_polynomial_at_zeta = 10699274423213228966584866078200066463524514983440400894371190167248933065654;
        proof.proof_batch_opening_at_zeta_x = 20615670257139961371194338378206177436324398357095524354293395867809061037214;
        proof.proof_batch_opening_at_zeta_y = 10525779676398714107477454903125435214786454307881750421922449413194676787230;
        proof.proof_opening_at_zeta_omega_x = 1108097622171944171150557279285654588777343111948830796417499623973896965804;
		proof.proof_opening_at_zeta_omega_y = 15685358048000705925737893824875253213650218050969597479171152663607922611587;
        proof.proof_openings_selector_commit_api_at_zeta = 11167772736384223704232062281764796721402138170580933266644366974216120242443   ;
        proof.proof_selector_commit_api_commitment_x = 11958623521546216034083564961144081879202019686227824918266403899483241300552;
        proof.proof_selector_commit_api_commitment_y = 5435003939571491789058406143326718591677769489309768660571088498970735885990;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_proof_scalar_bigger_than_r() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 1221522295221747337733441533822077852665101058033195378306421105633430459610;
        proof.proof_l_com_y = 9594082766851788293224429217927280855067804963720375625641053322529391085937;
        proof.proof_r_com_x = 11751393882197587453367061883029613574054292681257758365139088912414373652636;
        proof.proof_r_com_y = 19120189085541302315955717908033404841760472821182151814614584210306214529343;
        proof.proof_o_com_x = 7221230371819722291316872182829443607635748027387348067608253891061063652562;
        proof.proof_o_com_y = 11079417629928767264156894342810084192403010251585239009895186914595389593213;
        proof.proof_h_0_x = 17489026203157166651425157199859910837083604431116004661181185474211824365956;
        proof.proof_h_0_y = 21802947338337730941042344427580013835438122777898200517628734312133759362221;
        proof.proof_h_1_x = 16714522220647336319088289227729856868989653284294194351400574693851802892445;
        proof.proof_h_1_y = 11226847356565274353114400595107992302081453858617086112724666554954475496270;
        proof.proof_h_2_x = 13447108487355453029435432599765643105282678633446124501240223136678759205346;
        proof.proof_h_2_y = 14635529963350141975562113298285479191770546733114701726505952288605794263683;
        
        
        // r+1: the scalar exceeds r, the contract reverts
        proof.proof_l_at_zeta = 21888242871839275222246405745257275088548364400416034343698204186575808495618;
        
        proof.proof_r_at_zeta = 193083142840193507366433042657784144716600087713330609815218652599803660270;
        proof.proof_o_at_zeta = 10695565368637494388776493630405971843338615897876113200945525478957081604446;
        proof.proof_s1_at_zeta = 19433152785740303143096782572490322799255176038415944894983960987190705707566;
        proof.proof_s2_at_zeta = 11634003034387522537658180597875676738232128855917383827291605339343519742581;
        proof.proof_grand_product_commitment_x = 3849618507417157752781543115765729620051883293721770632535186858955524909141;
        proof.proof_grand_product_commitment_y = 12570752389585965632440408271339637648907161313149329407346502220755554078882;
        proof.proof_grand_product_at_zeta_omega = 5592800445762367975693680318747481778184205106220449706427550464959866434982;
        proof.proof_quotient_polynomial_at_zeta = 14151271352756327158765022864019258031550697683935990979653397269957472668692;
        proof.proof_linearised_polynomial_at_zeta = 10699274423213228966584866078200066463524514983440400894371190167248933065654;
        proof.proof_batch_opening_at_zeta_x = 20615670257139961371194338378206177436324398357095524354293395867809061037214;
        proof.proof_batch_opening_at_zeta_y = 10525779676398714107477454903125435214786454307881750421922449413194676787230;
        proof.proof_opening_at_zeta_omega_x = 1108097622171944171150557279285654588777343111948830796417499623973896965804;
		proof.proof_opening_at_zeta_omega_y = 15685358048000705925737893824875253213650218050969597479171152663607922611587;
        proof.proof_openings_selector_commit_api_at_zeta = 11167772736384223704232062281764796721402138170580933266644366974216120242443;
        proof.proof_selector_commit_api_commitment_x = 11958623521546216034083564961144081879202019686227824918266403899483241300552;
        proof.proof_selector_commit_api_commitment_y = 5435003939571491789058406143326718591677769489309768660571088498970735885990;

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

        proof.proof_r_com_x = 11751393882197587453367061883029613574054292681257758365139088912414373652636;
        proof.proof_r_com_y = 19120189085541302315955717908033404841760472821182151814614584210306214529343;
        proof.proof_o_com_x = 7221230371819722291316872182829443607635748027387348067608253891061063652562;
        proof.proof_o_com_y = 11079417629928767264156894342810084192403010251585239009895186914595389593213;
        proof.proof_h_0_x = 17489026203157166651425157199859910837083604431116004661181185474211824365956;
        proof.proof_h_0_y = 21802947338337730941042344427580013835438122777898200517628734312133759362221;
        proof.proof_h_1_x = 16714522220647336319088289227729856868989653284294194351400574693851802892445;
        proof.proof_h_1_y = 11226847356565274353114400595107992302081453858617086112724666554954475496270;
        proof.proof_h_2_x = 13447108487355453029435432599765643105282678633446124501240223136678759205346;
        proof.proof_h_2_y = 14635529963350141975562113298285479191770546733114701726505952288605794263683;
        proof.proof_l_at_zeta = 14981949455848581440351306768383274234658187585218720123637357751010056983628;
        proof.proof_r_at_zeta = 193083142840193507366433042657784144716600087713330609815218652599803660270;
        proof.proof_o_at_zeta = 10695565368637494388776493630405971843338615897876113200945525478957081604446;
        proof.proof_s1_at_zeta = 19433152785740303143096782572490322799255176038415944894983960987190705707566;
        proof.proof_s2_at_zeta = 11634003034387522537658180597875676738232128855917383827291605339343519742581;
        proof.proof_grand_product_commitment_x = 3849618507417157752781543115765729620051883293721770632535186858955524909141;
        proof.proof_grand_product_commitment_y = 12570752389585965632440408271339637648907161313149329407346502220755554078882;
        proof.proof_grand_product_at_zeta_omega = 5592800445762367975693680318747481778184205106220449706427550464959866434982;
        proof.proof_quotient_polynomial_at_zeta = 14151271352756327158765022864019258031550697683935990979653397269957472668692;
        proof.proof_linearised_polynomial_at_zeta = 10699274423213228966584866078200066463524514983440400894371190167248933065654;
        proof.proof_batch_opening_at_zeta_x = 20615670257139961371194338378206177436324398357095524354293395867809061037214;
        proof.proof_batch_opening_at_zeta_y = 10525779676398714107477454903125435214786454307881750421922449413194676787230;
        proof.proof_opening_at_zeta_omega_x = 1108097622171944171150557279285654588777343111948830796417499623973896965804;
		proof.proof_opening_at_zeta_omega_y = 15685358048000705925737893824875253213650218050969597479171152663607922611587;
        proof.proof_openings_selector_commit_api_at_zeta = 11167772736384223704232062281764796721402138170580933266644366974216120242443   ;
        proof.proof_selector_commit_api_commitment_x = 11958623521546216034083564961144081879202019686227824918266403899483241300552;
        proof.proof_selector_commit_api_commitment_y = 5435003939571491789058406143326718591677769489309768660571088498970735885990;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_correct_proof() internal pure
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 1221522295221747337733441533822077852665101058033195378306421105633430459610;
        proof.proof_l_com_y = 9594082766851788293224429217927280855067804963720375625641053322529391085937;
        proof.proof_r_com_x = 11751393882197587453367061883029613574054292681257758365139088912414373652636;
        proof.proof_r_com_y = 19120189085541302315955717908033404841760472821182151814614584210306214529343;
        proof.proof_o_com_x = 7221230371819722291316872182829443607635748027387348067608253891061063652562;
        proof.proof_o_com_y = 11079417629928767264156894342810084192403010251585239009895186914595389593213;
        proof.proof_h_0_x = 17489026203157166651425157199859910837083604431116004661181185474211824365956;
        proof.proof_h_0_y = 21802947338337730941042344427580013835438122777898200517628734312133759362221;
        proof.proof_h_1_x = 16714522220647336319088289227729856868989653284294194351400574693851802892445;
        proof.proof_h_1_y = 11226847356565274353114400595107992302081453858617086112724666554954475496270;
        proof.proof_h_2_x = 13447108487355453029435432599765643105282678633446124501240223136678759205346;
        proof.proof_h_2_y = 14635529963350141975562113298285479191770546733114701726505952288605794263683;
        proof.proof_l_at_zeta = 14981949455848581440351306768383274234658187585218720123637357751010056983628;
        proof.proof_r_at_zeta = 193083142840193507366433042657784144716600087713330609815218652599803660270;
        proof.proof_o_at_zeta = 10695565368637494388776493630405971843338615897876113200945525478957081604446;
        proof.proof_s1_at_zeta = 19433152785740303143096782572490322799255176038415944894983960987190705707566;
        proof.proof_s2_at_zeta = 11634003034387522537658180597875676738232128855917383827291605339343519742581;
        proof.proof_grand_product_commitment_x = 3849618507417157752781543115765729620051883293721770632535186858955524909141;
        proof.proof_grand_product_commitment_y = 12570752389585965632440408271339637648907161313149329407346502220755554078882;
        proof.proof_grand_product_at_zeta_omega = 5592800445762367975693680318747481778184205106220449706427550464959866434982;
        proof.proof_quotient_polynomial_at_zeta = 14151271352756327158765022864019258031550697683935990979653397269957472668692;
        proof.proof_linearised_polynomial_at_zeta = 10699274423213228966584866078200066463524514983440400894371190167248933065654;
        proof.proof_batch_opening_at_zeta_x = 20615670257139961371194338378206177436324398357095524354293395867809061037214;
        proof.proof_batch_opening_at_zeta_y = 10525779676398714107477454903125435214786454307881750421922449413194676787230;
        proof.proof_opening_at_zeta_omega_x = 1108097622171944171150557279285654588777343111948830796417499623973896965804;
		proof.proof_opening_at_zeta_omega_y = 15685358048000705925737893824875253213650218050969597479171152663607922611587;
        proof.proof_openings_selector_commit_api_at_zeta = 11167772736384223704232062281764796721402138170580933266644366974216120242443   ;
        proof.proof_selector_commit_api_commitment_x = 11958623521546216034083564961144081879202019686227824918266403899483241300552;
        proof.proof_selector_commit_api_commitment_y = 5435003939571491789058406143326718591677769489309768660571088498970735885990;

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
