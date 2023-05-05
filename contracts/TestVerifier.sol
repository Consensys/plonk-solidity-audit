

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

        proof.proof_l_com_x = 3591768503344669023408089889048613575747434648574045567422311883855336620918;
        proof.proof_l_com_y = 105482166498457699537926252384333933435851375599895956505887614177686566028;
        proof.proof_r_com_x = 13498211396225933962061180393494278577616949868545635033929772206131185049921;
        proof.proof_r_com_y = 9306084717158445641035345887533950514852427313209555247290347331094926825838;
        proof.proof_o_com_x = 18890048670153121845345483681472764150719422528349143927625793874753924199702;
        proof.proof_o_com_y = 10289726384789489227793546788498731278662175822293441733862640611981911879701;
        proof.proof_h_0_x = 1878280718059803715567085214660551004841134077383356670623161221685729701773;
        proof.proof_h_0_y = 6927804968945711040983875583597891162633790046707385557450695405689565799750;
        proof.proof_h_1_x = 18550950630499931116768047497740057939883801705134216140112784415936373577422;
        proof.proof_h_1_y = 4128094463711015995336269209234001991466820584607740443536263380118337261535;
        proof.proof_h_2_x = 12246636368388150886183179265574695359383299440205099326719774859356807036914;
        proof.proof_h_2_y = 21590579904136647646952281759175108384134696032295800017285621614707389803252;
        proof.proof_l_at_zeta = 4946995049834697943367443348091504030054744254201225102051145527290786337617;
        proof.proof_r_at_zeta = 6130757782575404155743859499035913146773375157025373902507973145350011116323;
        proof.proof_o_at_zeta = 12010034556284926517578032943942941890769961532600729486495738802678104321915;
        proof.proof_s1_at_zeta = 3593890521500404231367547965541074536697971829692345891606584382467009015839;
        proof.proof_s2_at_zeta = 14823678948859134554188568430808465170052032160218563191366052566300606518959;
        proof.proof_grand_product_commitment_x = 13017747340519658084970035437176674761878020680600361067312497163830213431213;
        proof.proof_grand_product_commitment_y = 8777456539748390005836270405652424579339908890750450152656245153680868255109;
        proof.proof_grand_product_at_zeta_omega = 18339597403033742963926514424143524363957029546106717241812490267357093961151;
        proof.proof_quotient_polynomial_at_zeta = 4214668400889305783128765383797334601465773430993389487533730621669766034198;
        proof.proof_linearised_polynomial_at_zeta = 17207998024551461146518592524059054056517635509687327604240450765432566490347;
        proof.proof_batch_opening_at_zeta_x = 11369889445224324657685755770310324741488568005142824804061504095440593844146;
        proof.proof_batch_opening_at_zeta_y = 4602195513366362189217293700217542966429811727649640279658707485104143501085;
        proof.proof_opening_at_zeta_omega_x = 13204789039716098414905002740496658381151453676301406045776116027963694537436;
		proof.proof_opening_at_zeta_omega_y = 12711267343239257220804507414626872152838891576315249082977083960367866412586;
        proof.proof_openings_selector_commit_api_at_zeta = 7031896130500832234742292983674048967577762826359629498300717078002279267614   ;
        proof.proof_selector_commit_api_commitment_x = 10385061550251173076098168713303717836710584579644200137071957871359802291335;
        proof.proof_selector_commit_api_commitment_y = 9809981610988273938138507494699574511207026392276854890516830560447285568536;

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
