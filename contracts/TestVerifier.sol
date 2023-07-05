

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
        
        uint256 proof_openings_selector_1_commit_api_at_zeta;
        

        
        uint256 proof_selector_0_commit_api_commitment_x;
        uint256 proof_selector_0_commit_api_commitment_y;
        
        uint256 proof_selector_1_commit_api_commitment_x;
        uint256 proof_selector_1_commit_api_commitment_y;
        
    }

    function get_proof() internal view
    returns (bytes memory)
    {

        Proof memory proof;

        proof.proof_l_com_x = 16095674878305572718206456498201559434562230232912304490245785827108902980001;
        proof.proof_l_com_y = 16251509961208692312309924841209101924174535809513025850755598489764630528928;
        proof.proof_r_com_x = 7889338651218339526738548233883609676136053918439746277076083977630240415833;
        proof.proof_r_com_y = 19416111605297390113156237293166044199007754975037077825116529221022738357623;
        proof.proof_o_com_x = 2164983580691097205348179736351341725558646508053772381704037457692026428611;
        proof.proof_o_com_y = 15510167687434867370222533725263019069335981197091845170299119917851646142941;
        proof.proof_h_0_x = 15608294439183456709686781820916549428783152557108860126584121580997146795028;
        proof.proof_h_0_y = 13394676613741733431532471380795476743166084625006183011066198465843866263189;
        proof.proof_h_1_x = 5069965105003155516934656333211711400113620726934141589533642813986662679785;
        proof.proof_h_1_y = 11515666606710731489637898663976791001075917105928780574172335088655173511771;
        proof.proof_h_2_x = 3288718101969412364132900179902250841270127367795043002600893295928730977806;
        proof.proof_h_2_y = 17019382713002627028043163646311977531915582680074779913998189958154051491894;
        proof.proof_l_at_zeta = 1806146368669130587861681272811424217326878305353995719374568822833820903727;
        proof.proof_r_at_zeta = 20758456449267372881969956604149027762763322973233252643835865839788583007616;
        proof.proof_o_at_zeta = 8817881361529712085767579027058892343792622269566378420773259149448561110194;
        proof.proof_s1_at_zeta = 17539299760441554756805516489476267262982333330130944911463237251505511925203;
        proof.proof_s2_at_zeta = 6558174206118567231960944845069521276333234944465064611555185256035158092315;
        proof.proof_grand_product_commitment_x = 2937342448942685794177706574172825722395389340347698132965422609240386932790;
        proof.proof_grand_product_commitment_y = 18160155607617267708382957598139788374919691893051186482902614158429004888334;
        proof.proof_grand_product_at_zeta_omega = 448997161523628179189069018069791811143454903917407098207413874411127655544;
        proof.proof_quotient_polynomial_at_zeta = 3715059320191388934789453229575246780431936945656921539168724296354673444331;
        proof.proof_linearised_polynomial_at_zeta = 7774652617109344122858635833241488155584625721837052983204619359633576733205;
        proof.proof_batch_opening_at_zeta_x = 17035550094915319565992355332868163774549239013623057697756146167029347528819;
        proof.proof_batch_opening_at_zeta_y = 7854251994262829593232335565613448137412360656097094947950195449364525113371;
        proof.proof_opening_at_zeta_omega_x = 3847579218737897957802924487181337411783796645343058266177384685399620909946;
		proof.proof_opening_at_zeta_omega_y = 4172256991545630990657847362908817454980909221340405874396381871164125734716;
      
        
        proof.proof_openings_selector_0_commit_api_at_zeta = 20329383651626652611857974012892794152928374676860494111851568939608606692468;
        
        proof.proof_openings_selector_1_commit_api_at_zeta = 17278466972152181153309677060949545468898830377909557690784396298164173750774;
        

        
        proof.proof_selector_0_commit_api_commitment_x = 10466436572257674083999219300173076992814496181287769248393047630411355244466;
        proof.proof_selector_0_commit_api_commitment_y = 5271491286492820215136539008086190076560482421892385995169449318581112698694;
        
        proof.proof_selector_1_commit_api_commitment_x = 2218613089858750873459414604545434698492389085829151798664965297742008030629;
        proof.proof_selector_1_commit_api_commitment_y = 13403718032441531137256997779214119461009529182662952483179472301786697783546;
        

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
        
        res = abi.encodePacked(res,proof.proof_openings_selector_1_commit_api_at_zeta);
        

        
        res = abi.encodePacked(res,
            proof.proof_selector_0_commit_api_commitment_x,
            proof.proof_selector_0_commit_api_commitment_y
        );
        
        res = abi.encodePacked(res,
            proof.proof_selector_1_commit_api_commitment_x,
            proof.proof_selector_1_commit_api_commitment_y
        );
        

        return res;
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
