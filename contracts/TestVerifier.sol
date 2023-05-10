
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
        
        proof.proof_l_com_y = 6914889363678855183287897313661007460293979818090451034030397391369508909788;
        proof.proof_r_com_x = 7487470040756192861026780211792199753220437969340520580868841973390587625519;
        proof.proof_r_com_y = 17092647259790528374969854900066147761871693194274615345958183807890147157484;
        proof.proof_o_com_x = 542083610349007548270574041295253196975333050137719694055022070690003887965;
        proof.proof_o_com_y = 9054012901737121300134445372779028614032744711822697064392513387301264724127;
        proof.proof_h_0_x = 4041523913022219802609278430323348132499172371418973073533606313646316361801;
        proof.proof_h_0_y = 1486429788390040565627704847152393159824546694034559945686101076478938139641;
        proof.proof_h_1_x = 21823663881386836911158970958236515638283724887823086121272611491091706036562;
        proof.proof_h_1_y = 10901650492764339930859091279743113682845067202035217483946395277985925168846;
        proof.proof_h_2_x = 6853008062198470296385308808426983924415540576013185657331910002387603000607;
        proof.proof_h_2_y = 16808689847305765210952848917970465846421389826711330786757179626419174289358;
        proof.proof_l_at_zeta = 13793712493619145304911800626577638186993949966787490958981276346375202122798;
        proof.proof_r_at_zeta = 3798628668862917029315245482167064382265046603486340953735072280997611877225;
        proof.proof_o_at_zeta = 52040706269713133771190870453134335271931737302346965748152998426797591642;
        proof.proof_s1_at_zeta = 14649316953335741048284259169191568041670623420123246620069098483384897295662;
        proof.proof_s2_at_zeta = 19435191385069598119408030534658120575168822573578746635060191578753939604974;
        proof.proof_grand_product_commitment_x = 1356738326933873097527106578020111866322241560458559869053147731362415714760;
        proof.proof_grand_product_commitment_y = 1783562225791610043390473994801926027372175523103760832806569420971483528747;
        proof.proof_grand_product_at_zeta_omega = 3066712630156313433749003375299028285974199361965921834286892453230497510871;
        proof.proof_quotient_polynomial_at_zeta = 5251928283953824360690339869309888327461649742103542335393646881038750656361;
        proof.proof_linearised_polynomial_at_zeta = 10914725780582493213615625187928577497944796138366299986646777956695040056930;
        proof.proof_batch_opening_at_zeta_x = 20194005575864398308368347952959322722065627595103549782374123977160540624585;
        proof.proof_batch_opening_at_zeta_y = 13935456762332579546956818223486488948491789368414171108641156834433511546385;
        proof.proof_opening_at_zeta_omega_x = 10485845633203190474271956827169591932587352396996150294325331799826655097298;
		proof.proof_opening_at_zeta_omega_y = 802820785041386402331513161894483738971579958483167105460072363116506099988;
        proof.proof_openings_selector_commit_api_at_zeta = 3111887534567342565256357873909576245967183560961942776323614613022292919578   ;
        proof.proof_selector_commit_api_commitment_x = 14722304158977528561348657498093718743684119606583281725583324032412401860287;
        proof.proof_selector_commit_api_commitment_y = 18790748801825208190206889494031318758644993285882356707293058947114584273835;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_proof_scalar_bigger_than_r() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 13967802083281528384817324773970197749324284777303173130180986724516880534084;
        proof.proof_l_com_y = 6914889363678855183287897313661007460293979818090451034030397391369508909788;
        proof.proof_r_com_x = 7487470040756192861026780211792199753220437969340520580868841973390587625519;
        proof.proof_r_com_y = 17092647259790528374969854900066147761871693194274615345958183807890147157484;
        proof.proof_o_com_x = 542083610349007548270574041295253196975333050137719694055022070690003887965;
        proof.proof_o_com_y = 9054012901737121300134445372779028614032744711822697064392513387301264724127;
        proof.proof_h_0_x = 4041523913022219802609278430323348132499172371418973073533606313646316361801;
        proof.proof_h_0_y = 1486429788390040565627704847152393159824546694034559945686101076478938139641;
        proof.proof_h_1_x = 21823663881386836911158970958236515638283724887823086121272611491091706036562;
        proof.proof_h_1_y = 10901650492764339930859091279743113682845067202035217483946395277985925168846;
        proof.proof_h_2_x = 6853008062198470296385308808426983924415540576013185657331910002387603000607;
        proof.proof_h_2_y = 16808689847305765210952848917970465846421389826711330786757179626419174289358;
        
        
        // r+1: the scalar exceeds r, the contract reverts
        proof.proof_l_at_zeta = 21888242871839275222246405745257275088548364400416034343698204186575808495618;
        
        proof.proof_r_at_zeta = 3798628668862917029315245482167064382265046603486340953735072280997611877225;
        proof.proof_o_at_zeta = 52040706269713133771190870453134335271931737302346965748152998426797591642;
        proof.proof_s1_at_zeta = 14649316953335741048284259169191568041670623420123246620069098483384897295662;
        proof.proof_s2_at_zeta = 19435191385069598119408030534658120575168822573578746635060191578753939604974;
        proof.proof_grand_product_commitment_x = 1356738326933873097527106578020111866322241560458559869053147731362415714760;
        proof.proof_grand_product_commitment_y = 1783562225791610043390473994801926027372175523103760832806569420971483528747;
        proof.proof_grand_product_at_zeta_omega = 3066712630156313433749003375299028285974199361965921834286892453230497510871;
        proof.proof_quotient_polynomial_at_zeta = 5251928283953824360690339869309888327461649742103542335393646881038750656361;
        proof.proof_linearised_polynomial_at_zeta = 10914725780582493213615625187928577497944796138366299986646777956695040056930;
        proof.proof_batch_opening_at_zeta_x = 20194005575864398308368347952959322722065627595103549782374123977160540624585;
        proof.proof_batch_opening_at_zeta_y = 13935456762332579546956818223486488948491789368414171108641156834433511546385;
        proof.proof_opening_at_zeta_omega_x = 10485845633203190474271956827169591932587352396996150294325331799826655097298;
		proof.proof_opening_at_zeta_omega_y = 802820785041386402331513161894483738971579958483167105460072363116506099988;
        proof.proof_openings_selector_commit_api_at_zeta = 3111887534567342565256357873909576245967183560961942776323614613022292919578;
        proof.proof_selector_commit_api_commitment_x = 14722304158977528561348657498093718743684119606583281725583324032412401860287;
        proof.proof_selector_commit_api_commitment_y = 18790748801825208190206889494031318758644993285882356707293058947114584273835;

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

        proof.proof_r_com_x = 7487470040756192861026780211792199753220437969340520580868841973390587625519;
        proof.proof_r_com_y = 17092647259790528374969854900066147761871693194274615345958183807890147157484;
        proof.proof_o_com_x = 542083610349007548270574041295253196975333050137719694055022070690003887965;
        proof.proof_o_com_y = 9054012901737121300134445372779028614032744711822697064392513387301264724127;
        proof.proof_h_0_x = 4041523913022219802609278430323348132499172371418973073533606313646316361801;
        proof.proof_h_0_y = 1486429788390040565627704847152393159824546694034559945686101076478938139641;
        proof.proof_h_1_x = 21823663881386836911158970958236515638283724887823086121272611491091706036562;
        proof.proof_h_1_y = 10901650492764339930859091279743113682845067202035217483946395277985925168846;
        proof.proof_h_2_x = 6853008062198470296385308808426983924415540576013185657331910002387603000607;
        proof.proof_h_2_y = 16808689847305765210952848917970465846421389826711330786757179626419174289358;
        proof.proof_l_at_zeta = 13793712493619145304911800626577638186993949966787490958981276346375202122798;
        proof.proof_r_at_zeta = 3798628668862917029315245482167064382265046603486340953735072280997611877225;
        proof.proof_o_at_zeta = 52040706269713133771190870453134335271931737302346965748152998426797591642;
        proof.proof_s1_at_zeta = 14649316953335741048284259169191568041670623420123246620069098483384897295662;
        proof.proof_s2_at_zeta = 19435191385069598119408030534658120575168822573578746635060191578753939604974;
        proof.proof_grand_product_commitment_x = 1356738326933873097527106578020111866322241560458559869053147731362415714760;
        proof.proof_grand_product_commitment_y = 1783562225791610043390473994801926027372175523103760832806569420971483528747;
        proof.proof_grand_product_at_zeta_omega = 3066712630156313433749003375299028285974199361965921834286892453230497510871;
        proof.proof_quotient_polynomial_at_zeta = 5251928283953824360690339869309888327461649742103542335393646881038750656361;
        proof.proof_linearised_polynomial_at_zeta = 10914725780582493213615625187928577497944796138366299986646777956695040056930;
        proof.proof_batch_opening_at_zeta_x = 20194005575864398308368347952959322722065627595103549782374123977160540624585;
        proof.proof_batch_opening_at_zeta_y = 13935456762332579546956818223486488948491789368414171108641156834433511546385;
        proof.proof_opening_at_zeta_omega_x = 10485845633203190474271956827169591932587352396996150294325331799826655097298;
		proof.proof_opening_at_zeta_omega_y = 802820785041386402331513161894483738971579958483167105460072363116506099988;
        proof.proof_openings_selector_commit_api_at_zeta = 3111887534567342565256357873909576245967183560961942776323614613022292919578   ;
        proof.proof_selector_commit_api_commitment_x = 14722304158977528561348657498093718743684119606583281725583324032412401860287;
        proof.proof_selector_commit_api_commitment_y = 18790748801825208190206889494031318758644993285882356707293058947114584273835;

        bytes memory res = encode_proof(proof);
        return res;
    }

    function get_correct_proof() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 13967802083281528384817324773970197749324284777303173130180986724516880534084;
        proof.proof_l_com_y = 6914889363678855183287897313661007460293979818090451034030397391369508909788;
        proof.proof_r_com_x = 7487470040756192861026780211792199753220437969340520580868841973390587625519;
        proof.proof_r_com_y = 17092647259790528374969854900066147761871693194274615345958183807890147157484;
        proof.proof_o_com_x = 542083610349007548270574041295253196975333050137719694055022070690003887965;
        proof.proof_o_com_y = 9054012901737121300134445372779028614032744711822697064392513387301264724127;
        proof.proof_h_0_x = 4041523913022219802609278430323348132499172371418973073533606313646316361801;
        proof.proof_h_0_y = 1486429788390040565627704847152393159824546694034559945686101076478938139641;
        proof.proof_h_1_x = 21823663881386836911158970958236515638283724887823086121272611491091706036562;
        proof.proof_h_1_y = 10901650492764339930859091279743113682845067202035217483946395277985925168846;
        proof.proof_h_2_x = 6853008062198470296385308808426983924415540576013185657331910002387603000607;
        proof.proof_h_2_y = 16808689847305765210952848917970465846421389826711330786757179626419174289358;
        proof.proof_l_at_zeta = 13793712493619145304911800626577638186993949966787490958981276346375202122798;
        proof.proof_r_at_zeta = 3798628668862917029315245482167064382265046603486340953735072280997611877225;
        proof.proof_o_at_zeta = 52040706269713133771190870453134335271931737302346965748152998426797591642;
        proof.proof_s1_at_zeta = 14649316953335741048284259169191568041670623420123246620069098483384897295662;
        proof.proof_s2_at_zeta = 19435191385069598119408030534658120575168822573578746635060191578753939604974;
        proof.proof_grand_product_commitment_x = 1356738326933873097527106578020111866322241560458559869053147731362415714760;
        proof.proof_grand_product_commitment_y = 1783562225791610043390473994801926027372175523103760832806569420971483528747;
        proof.proof_grand_product_at_zeta_omega = 3066712630156313433749003375299028285974199361965921834286892453230497510871;
        proof.proof_quotient_polynomial_at_zeta = 5251928283953824360690339869309888327461649742103542335393646881038750656361;
        proof.proof_linearised_polynomial_at_zeta = 10914725780582493213615625187928577497944796138366299986646777956695040056930;
        proof.proof_batch_opening_at_zeta_x = 20194005575864398308368347952959322722065627595103549782374123977160540624585;
        proof.proof_batch_opening_at_zeta_y = 13935456762332579546956818223486488948491789368414171108641156834433511546385;
        proof.proof_opening_at_zeta_omega_x = 10485845633203190474271956827169591932587352396996150294325331799826655097298;
		proof.proof_opening_at_zeta_omega_y = 802820785041386402331513161894483738971579958483167105460072363116506099988;
        proof.proof_openings_selector_commit_api_at_zeta = 3111887534567342565256357873909576245967183560961942776323614613022292919578   ;
        proof.proof_selector_commit_api_commitment_x = 14722304158977528561348657498093718743684119606583281725583324032412401860287;
        proof.proof_selector_commit_api_commitment_y = 18790748801825208190206889494031318758644993285882356707293058947114584273835;

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
