

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

        proof.proof_l_com_x = 3335670694928783712499618400757512372900025650578615681187276791031092787489;
        proof.proof_l_com_y = 15861673793055829889553190871508661286544178626962521541470291050843734049937;
        proof.proof_r_com_x = 16566481836267352181130565300922268418894421430304577244450996087404155364945;
        proof.proof_r_com_y = 10705508228517933255286705845340501807518633417549991248331970629216524935143;
        proof.proof_o_com_x = 7937964404255487875342572750783139904656991531607921137552615166333983470887;
        proof.proof_o_com_y = 609699827261605104863526978346190654975075592731377210651596700684074577414;
        proof.proof_h_0_x = 4433320856784670285754888547997418554265089599508641269652295714853715160229;
        proof.proof_h_0_y = 15517595859929952791544959769167389437642337436037711431944760089697921491030;
        proof.proof_h_1_x = 5916920032919781903133563330471562927698979137360593119617934222299231384570;
        proof.proof_h_1_y = 8781022561226066426287516711249311815324767075176435486921092999978860315995;
        proof.proof_h_2_x = 8452989298615326334279120494166107309185719219435221145099604154188116218293;
        proof.proof_h_2_y = 12249051244211331564231874557692381318847299580951760492283993532870112582642;
        proof.proof_l_at_zeta = 6462285515846635457166882341687351925982765096579326873882974720800674904246;
        proof.proof_r_at_zeta = 19961887418221168434775454180658762619902767594031787665904514900189701793656;
        proof.proof_o_at_zeta = 8595226716442081036039302134173462533011752711746061622686966290101456831987;
        proof.proof_s1_at_zeta = 5417764896119438318720504651531427343838341139496856292673359866031844653742;
        proof.proof_s2_at_zeta = 6744245229864012127783135748042283227659889149584839047587520243769133665337;
        proof.proof_grand_product_commitment_x = 280152973019252716268128409092312561110686778125448630899578465716306404410;
        proof.proof_grand_product_commitment_y = 19286996652397897003949725718915040962239136021141783635644338181501424214374;
        proof.proof_grand_product_at_zeta_omega = 5934996946295663137361917889541004997129611150506197280667702250665872550292;
        proof.proof_quotient_polynomial_at_zeta = 15268344683591758335412796573599676331315160029527496332401422562317594128272;
        proof.proof_linearised_polynomial_at_zeta = 6140382142561191371735132600420159023682206345868549587234107134010544733255;
        proof.proof_batch_opening_at_zeta_x = 5249611276891523046926304515446551102650181526957059240310428253248688573377;
        proof.proof_batch_opening_at_zeta_y = 2819777688993382353944741747349712388192933688679871232337908570747364248953;
        proof.proof_opening_at_zeta_omega_x = 1245550505997126654165690423216136526134198775244964464671006815017152966335;
		proof.proof_opening_at_zeta_omega_y = 14957108229268128931907826707418204343492377476165959715199625455244447603399;
        proof.proof_openings_selector_commit_api_at_zeta = 14161130772990593063822241982314617994911490109280513405927417779717833421635   ;
        proof.proof_selector_commit_api_commitment_x = 7787045743597066260600562409439995291295376379239862392558549255667487715558;
        proof.proof_selector_commit_api_commitment_y = 18021319928096778673504530982965294145776690549711142232039781886405893633336;

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
