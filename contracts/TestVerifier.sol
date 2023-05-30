

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
        
        
        uint256 proof_openings_selector_0_commit_api_at_zeta;
        

        
        uint256 proof_selector_0_commit_api_commitment_x;
        uint256 proof_selector_0_commit_api_commitment_y;
        
    }

    function get_proof() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 7360369969831890620680712010951703229737603240467922614431639435482807937082;
        proof.proof_l_com_y = 6188453326980605621537290562276878484332951312896551054162385631971856040301;
        proof.proof_r_com_x = 254383070997786648840348733328933157360849352428468930006207956435716195067;
        proof.proof_r_com_y = 2661944866463707348829683774328790420513719970044566166760585488389362033425;
        proof.proof_o_com_x = 21401859410091006487758257681334930094951465685929499126089854325944975209462;
        proof.proof_o_com_y = 19223008612540499824646847857621455950351768185426693587652518957116865255633;
        proof.proof_h_0_x = 12457214786099765119325519619759632579738224642267339116628192879021985381674;
        proof.proof_h_0_y = 21020779996098994669458886991350619112216361027594848317559461373519649399177;
        proof.proof_h_1_x = 19938950349785314356529039317116753839125996630196954445508463904769777161761;
        proof.proof_h_1_y = 8317787238025179509248218307412184396672228511485349819888599526908547861059;
        proof.proof_h_2_x = 15455213097079212896886734213142405971602181835157046412135859260739768362072;
        proof.proof_h_2_y = 19687184180863468504726597835366610886485307237451758072615599913033981692347;
        proof.proof_l_at_zeta = 21095723738372808897238992751151275532381866417276857116335639802409211329820;
        proof.proof_r_at_zeta = 19159818110719534089352450695221676485427293952845970001378578476340288336392;
        proof.proof_o_at_zeta = 2119759189552272204394492310492589508537763865431027416594405212294559056486;
        proof.proof_s1_at_zeta = 419181899662975115438693842208714769668562467498510572458201411244452467407;
        proof.proof_s2_at_zeta = 6200211981753559279644271065100645171975005630647832630276806405971931551216;
        proof.proof_grand_product_commitment_x = 10955131501132353921369600411581996544872846492256635890195699427252262370109;
        proof.proof_grand_product_commitment_y = 19119863461758291878600347585450920923611225931309500582903410136433880541623;
        proof.proof_grand_product_at_zeta_omega = 4622764397256349979121141420193315923896775781187151606824033899809063879461;
        proof.proof_quotient_polynomial_at_zeta = 2082071090719767401415547954845222100518669587123753102047852225833838403696;
        proof.proof_linearised_polynomial_at_zeta = 2369317907706624287875311897501860991742744549871242078376395299444909430303;
        proof.proof_batch_opening_at_zeta_x = 3491092778937586367457745223643564535637181420752945921143744351981101842608;
        proof.proof_batch_opening_at_zeta_y = 8811764971770236754406230245347417895769036184074035699866599530938168265823;
        proof.proof_opening_at_zeta_omega_x = 15487828072442854092414200060137256894196033578758586715024120353179012814604;
		proof.proof_opening_at_zeta_omega_y = 13949081900081890484128331379519641673297864420314157489602893481625892110962;
      
        
        proof.proof_openings_selector_0_commit_api_at_zeta = 0;
        

        
        proof.proof_selector_0_commit_api_commitment_x = 19164748900406680026492297867232873546804251908978762705578425275450049131106;
        proof.proof_selector_0_commit_api_commitment_y = 10281030600364209870538003912204707768883012160661417998985399254029374072808;
        

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
            proof.proof_opening_at_zeta_omega_y
        );

        
        res = abi.encodePacked(res,proof.proof_openings_selector_0_commit_api_at_zeta);
        

        
        res = abi.encodePacked(res,
            proof.proof_selector_0_commit_api_commitment_x,
            proof.proof_selector_0_commit_api_commitment_y
        );
        

        return res;
    }

    function test_verifier_go(bytes memory proof, uint256[] memory public_inputs) public {
        bool check_proof = PlonkVerifier.Verify(proof, public_inputs);
        require(check_proof, "verification failed!");
    }

    function test_verifier() public {

        uint256[] memory pi = new uint256[](10);
        
        pi[0] = 10;
        
        pi[1] = 11;
        
        pi[2] = 12;
        
        pi[3] = 13;
        
        pi[4] = 14;
        
        pi[5] = 15;
        
        pi[6] = 16;
        
        pi[7] = 17;
        
        pi[8] = 18;
        
        pi[9] = 19;
        

        bytes memory proof = get_proof();

        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
        require(check_proof, "verification failed!");
    }

}
