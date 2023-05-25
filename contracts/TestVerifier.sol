

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

        proof.proof_l_com_x = 2026604862884590888448501242470869894074283973191230543687430698390340459069;
        proof.proof_l_com_y = 16601436950993743070197463800704255767742623924186294197536649661166716751887;
        proof.proof_r_com_x = 10948052446140647678525493908058902547436089103405444582275117491949001170599;
        proof.proof_r_com_y = 2777873295940223428239785510457829210776728062848426669633113855729748487739;
        proof.proof_o_com_x = 9693542937433182726729966185290079912128530900343204300522315382744734456997;
        proof.proof_o_com_y = 20156651114946968614364693379448147602870623115186208819514930869377168112247;
        proof.proof_h_0_x = 17136573904191316721057948140440057809897407659894902042668741910194749157960;
        proof.proof_h_0_y = 667986675132499499280487299244106753326014045537409130426146465945455887002;
        proof.proof_h_1_x = 1888519138630535512947981328068975275126559450531843802159272176688943134160;
        proof.proof_h_1_y = 7637049679875970435614347443110075536252000217611549849327226048095657580727;
        proof.proof_h_2_x = 16141076202894015266108739804616290855737785054085451405857074025172297701964;
        proof.proof_h_2_y = 1078973072862524906028908738035171513068649220774996882763810972040285383044;
        proof.proof_l_at_zeta = 10614180656911125164810932147415121172414771768650495346532487575528275102260;
        proof.proof_r_at_zeta = 3214524139093225417372218605579631061871661639529280770648300326559204262399;
        proof.proof_o_at_zeta = 14488539819788972710107254732266604032940060493057359350208281479804716147689;
        proof.proof_s1_at_zeta = 2565288214210241558937244151361318659499167312577541891361062393835073335105;
        proof.proof_s2_at_zeta = 11713829499579638444993768416603852684750829782420482076174737525458458721479;
        proof.proof_grand_product_commitment_x = 1399243527749449567040763102147003034969487798859001219261868493016655759147;
        proof.proof_grand_product_commitment_y = 13405979689839287276016396429218235339125655961964162217449122263965430841590;
        proof.proof_grand_product_at_zeta_omega = 10430278250016023466725912812238697898248502240091367577723189185720292613329;
        proof.proof_quotient_polynomial_at_zeta = 10797083342609692330261894151057077650861320284377360334372392059049122162787;
        proof.proof_linearised_polynomial_at_zeta = 1792979393248432610774804584543800274486777627684772264142217566446613500305;
        proof.proof_batch_opening_at_zeta_x = 6689344653444001171365367686286373642563513693959894903492896480496548887740;
        proof.proof_batch_opening_at_zeta_y = 10662296753647645260493013255010511723166816700474602193791000978701957224456;
        proof.proof_opening_at_zeta_omega_x = 13052483494426704491380990647792566288291110687155559824113481037336993493987;
		proof.proof_opening_at_zeta_omega_y = 21475404509887385857030058828746350509645710722184954596610521311999916970710;
      
        
        proof.proof_openings_selector_0_commit_api_at_zeta = 20560549419112272218115332033310328524137681869454336426949393416627591841636;
        

        
        proof.proof_selector_0_commit_api_commitment_x = 13439722657418377413077189158370090459567992269962831913678461786415202381553;
        proof.proof_selector_0_commit_api_commitment_y = 11752424583686540764379846754188252224884393619803307407396223765067821856085;
        

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

        uint256[] memory pi = new uint256[](3);
        
        pi[0] = 6;
        
        pi[1] = 7;
        
        pi[2] = 8;
        

        bytes memory proof = get_proof();

        bool check_proof = PlonkVerifier.Verify(proof, pi);
        emit PrintBool(check_proof);
        // require(check_proof, "verification failed!");
    }

}
