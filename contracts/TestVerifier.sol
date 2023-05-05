

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

        proof.proof_l_com_x = 7072465852512092206439880350190252349084246716344688380510681935690055909238;
        proof.proof_l_com_y = 13093095386574709116982960274333196383349812212317264366377479398710040851058;
        proof.proof_r_com_x = 8136480040295330185127564754821097273511071956691024702432943363061420070275;
        proof.proof_r_com_y = 16065241794184653042768766983368609983755348998070477540023270265507570697338;
        proof.proof_o_com_x = 19315418907669854790325445344287880591502162116359034448786561440989790272234;
        proof.proof_o_com_y = 5092266096717421315449602865158209315764668017766584691847279789719143033430;
        proof.proof_h_0_x = 8996507476264174563607718417077686117094229450923242409335431189238694578943;
        proof.proof_h_0_y = 19233350000888012334145879129902823555707799872376376888846530519529762908978;
        proof.proof_h_1_x = 2541942556199567144812245939890483602097220035802348503869682330154325626686;
        proof.proof_h_1_y = 2170499786639216514093200108090678142415962025583734040192983693445876448278;
        proof.proof_h_2_x = 5392568030479339474635008482753382259286827315441064382638133594883549554727;
        proof.proof_h_2_y = 616907224359070045504982720721713294359238993254047186624809924418857450898;
        proof.proof_l_at_zeta = 11007914331497096473836795877339947504513339246862806796877299586804474570939;
        proof.proof_r_at_zeta = 20857585444351030294670016085638812257792732482941027058959114586422816199329;
        proof.proof_o_at_zeta = 21315975352272613398515053191772585369437369850419436697083522377589588150578;
        proof.proof_s1_at_zeta = 3833844877027553352915771866949293270765013601173555638416059992946596492822;
        proof.proof_s2_at_zeta = 1130331692524390229955404709053739955475489627482411957838663585436519447394;
        proof.proof_grand_product_commitment_x = 6495459421636517200179885136552916633764209513374789620141151085210128509636;
        proof.proof_grand_product_commitment_y = 6605907436962201772703888732427018916272114137823534478186857454221065719421;
        proof.proof_grand_product_at_zeta_omega = 2103434521341948298199045906869976164307992028190931827651764063478433773142;
        proof.proof_quotient_polynomial_at_zeta = 5734799354764968979777685657313002060158345222296783888827817673508410410588;
        proof.proof_linearised_polynomial_at_zeta = 20057980792519739534434798572257498262382400972902809883724535039750339897954;
        proof.proof_batch_opening_at_zeta_x = 15817054481307264985304695936912483203708430410254846428112657424359110993470;
        proof.proof_batch_opening_at_zeta_y = 14417145045085323478244042202442586187724890450053942777994680129088822046984;
        proof.proof_opening_at_zeta_omega_x = 19580769566747418300448518408841422445621349360927245747758171318719899153267;
		proof.proof_opening_at_zeta_omega_y = 14168833424777863288687532656455424936638686523115466236298556801950272970873;
        proof.proof_openings_selector_commit_api_at_zeta = 5693586392993868137617658121244511150820624621518428643263711334440856904281   ;
        proof.proof_selector_commit_api_commitment_x = 612292448820332592465653929129783193051109686533781955729890856228472167780;
        proof.proof_selector_commit_api_commitment_y = 1438928596921276566834214118411858908618898723405906815047014217100562022330;

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
