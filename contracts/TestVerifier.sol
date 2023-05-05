

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

        proof.proof_l_com_x = 19003161998861374855563676182615332061442334797618493032719603757315961973277;
        proof.proof_l_com_y = 16248404166704970512069338570616433360280172776708367281569388244030175037440;
        proof.proof_r_com_x = 17626614429768479853422004543147545445107207068759790648222546602693680015584;
        proof.proof_r_com_y = 7493902020341040353535521697157113236148651275587769677000828328377704608404;
        proof.proof_o_com_x = 11132599101845173631996903014380567322764793250564879447063983552237932231411;
        proof.proof_o_com_y = 10858501013257822290729640440615148982216001230954866798121504604662127685126;
        proof.proof_h_0_x = 4646564801674756813267822405163003947060891947455680077378700324769262126121;
        proof.proof_h_0_y = 1485076944019528720925933652926055221371704796887509035694544960179347738058;
        proof.proof_h_1_x = 1150732371513186296554190673117838411360753191549494204451683685148383574769;
        proof.proof_h_1_y = 9126943741154945158025852030806662781250944579893296628855304487652774028175;
        proof.proof_h_2_x = 5021655992970926308867193912961695438132496789439681064026440700189894311299;
        proof.proof_h_2_y = 15250917487315141086330408483145229882908077509620966104021646731964667893759;
        proof.proof_l_at_zeta = 12820025912691661860959730022732102839166542711959428629861271565414295777689;
        proof.proof_r_at_zeta = 7455840535665133073022037811458574973647496080544039416713466006598366644336;
        proof.proof_o_at_zeta = 3463817460053289102386520239197828782468044366893373178171548831331746681765;
        proof.proof_s1_at_zeta = 17340733028291547971378067627566869673743836389669674343298335727582154264781;
        proof.proof_s2_at_zeta = 7571273059044816109309597455359080441399914485077574543431558486365420898278;
        proof.proof_grand_product_commitment_x = 17244366333435255484537028870976105086585639874231899372145655100440231523346;
        proof.proof_grand_product_commitment_y = 20847669614745444269330819113244849337145447234513123288051276866406144677853;
        proof.proof_grand_product_at_zeta_omega = 3106663423209655187804189598709958253201326223279749341130113161772632905058;
        proof.proof_quotient_polynomial_at_zeta = 4614258180105476593526718268488703404534312105438022272048059566965772908683;
        proof.proof_linearised_polynomial_at_zeta = 11934414599276814900194057321299557197515388105560673391930181675695984608340;
        proof.proof_batch_opening_at_zeta_x = 9267521173477126160005152978482974393498879999326053485830458645775569387394;
        proof.proof_batch_opening_at_zeta_y = 14597095945396274616833960219529763184297408928903419978788997911313604108827;
        proof.proof_opening_at_zeta_omega_x = 19174561451647369877070446618020119094240927416153678333078335921774956425408;
		proof.proof_opening_at_zeta_omega_y = 7923204936847690985496578846588083609363687265541335506826872053747540552266;
        proof.proof_openings_selector_commit_api_at_zeta = 11657954384624377219109356363209584145932259233792223999333730680873821301719   ;
        proof.proof_selector_commit_api_commitment_x = 12533031255857349925187117443094346808328455327016445101340547972059815947559;
        proof.proof_selector_commit_api_commitment_y = 13345946124829385543326556713273200198741456326682432645059462227559987358494;

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
