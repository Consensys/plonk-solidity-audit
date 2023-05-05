

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

        proof.proof_l_com_x = 2324353457450791858551519946194947167028181926283083998609594347900580227934;
        proof.proof_l_com_y = 15249654463707855202791448841352451543225561065248400551602839463667157623281;
        proof.proof_r_com_x = 18247982467899258589201619600825405372271975826840066182029506868871379431975;
        proof.proof_r_com_y = 18809355919913278396208585730264443259794364275381547053242142687834904003285;
        proof.proof_o_com_x = 2272148276047571728667976123309151044729280582007709641073547527370227598565;
        proof.proof_o_com_y = 6731083399309718165401453293629764188317986616311130394187965418003416579336;
        proof.proof_h_0_x = 19581774450176863431926661208069721488464604371862890479437638458459979302793;
        proof.proof_h_0_y = 7286522126655649396982293582769629769677199920009088616929412893041540397578;
        proof.proof_h_1_x = 13318537194536516753151047131179515918292730797998275611767695012577028737776;
        proof.proof_h_1_y = 2878714196721859943376417017455858843749135096009378990152838429315832114161;
        proof.proof_h_2_x = 19686847860166638729602400026720147695743201279371113415907392109617588246891;
        proof.proof_h_2_y = 1719119601052204263132932181663980980883689033681078414635108881532130639625;
        proof.proof_l_at_zeta = 3086366978193534323073130285428378521130135951667347587178874778293691069612;
        proof.proof_r_at_zeta = 21577960761012417286097673119559032953225381821575356637517536454987204460919;
        proof.proof_o_at_zeta = 13377756008579319826711375233379400011743410825505941219832578260280098699724;
        proof.proof_s1_at_zeta = 17657818699832064173219499904179825538554572078089393061118999584315745582945;
        proof.proof_s2_at_zeta = 2596323029486784031257679309500279692157716699518234653527866420739366478717;
        proof.proof_grand_product_commitment_x = 11559043031693338050281771059545386045828227757030516509825163642517570947712;
        proof.proof_grand_product_commitment_y = 15437970961089475491619226676378110433305134842401711870265511167326124886819;
        proof.proof_grand_product_at_zeta_omega = 905396818984834200932268381034834397762281006438686065564966181991015190878;
        proof.proof_quotient_polynomial_at_zeta = 14234544230654253443062597090006715288223202499882346208402832727578405619949;
        proof.proof_linearised_polynomial_at_zeta = 10799883935403178240444793257300001034099630003100860073203790977490991874007;
        proof.proof_batch_opening_at_zeta_x = 19752098609272939018737695627117996372342771513840298949975678256532547491471;
        proof.proof_batch_opening_at_zeta_y = 6519024731626580325839217356121574328775007693879730180354740138587826271408;
        proof.proof_opening_at_zeta_omega_x = 12103584005902307436056923198066638493296879197973573053758508205425115157551;
		proof.proof_opening_at_zeta_omega_y = 18445926113056633034412624342604117845329488665012456504263490718526044422445;
        proof.proof_openings_selector_commit_api_at_zeta = 15987488498989852709714023711561899697205477952240084489476703946199307013365   ;
        proof.proof_selector_commit_api_commitment_x = 7786040744708777784766467011469893342747565298104443533175197037298362100276;
        proof.proof_selector_commit_api_commitment_y = 10830372753097723868168402736712140681853060789031745709139067251880481523497;

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
