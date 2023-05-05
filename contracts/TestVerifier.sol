

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

        proof.proof_l_com_x = 19963045241968711932868426258428497782017492075474602875408365506530311576271;
        proof.proof_l_com_y = 16172445908569628257451631706991997706583419982713970793120921303566838862707;
        proof.proof_r_com_x = 13960802548423895511856515417708747176530111059038030516696158854163389784495;
        proof.proof_r_com_y = 5089234258613906846917422041120821416611099721131648658276522769683912113149;
        proof.proof_o_com_x = 10742742950732072007440051372440960483785769280335174890832639022617491964541;
        proof.proof_o_com_y = 12215763047608963717859932300580704389209467238404728776983290743054712379071;
        proof.proof_h_0_x = 19302610575282082134981500511886085946646274514215988547691817316268296023713;
        proof.proof_h_0_y = 20211859236671294634982252759704603786656057699283606255060037727067430491574;
        proof.proof_h_1_x = 17446796421533469943125910659080401111594921737490350284697218339194318914494;
        proof.proof_h_1_y = 21462694781612503007333076766923451016129538197208234953203965382342061083507;
        proof.proof_h_2_x = 16470764317306092891834531763297061971587094593857782257498652197822178843493;
        proof.proof_h_2_y = 10118635516922663566256673939797570140346769788829551157041762432239266844521;
        proof.proof_l_at_zeta = 15193388499110564704011686131547048174604188707132233494851335854303914503645;
        proof.proof_r_at_zeta = 13080362825255267012436200252320232288031595168524858968839736358115026169298;
        proof.proof_o_at_zeta = 4279401250763144818655052967389260004616629252248890339850145176787376168161;
        proof.proof_s1_at_zeta = 8796488839266080523082851295358759449562302557040713978546057129141859607946;
        proof.proof_s2_at_zeta = 542481827845433531999704056785648748218257961860866735187583485673686351877;
        proof.proof_grand_product_commitment_x = 21886873707910498861171471810627992101793384674036266710751086942491780478887;
        proof.proof_grand_product_commitment_y = 1533968806373121425760556315241551347630005390709181821221115392512436258280;
        proof.proof_grand_product_at_zeta_omega = 9930385208688302533576342639873825178454413715481595925311949721855088308827;
        proof.proof_quotient_polynomial_at_zeta = 5080141567098498542148224658081969308129664504159084208003101612935145846798;
        proof.proof_linearised_polynomial_at_zeta = 16265877974503200258801149854981107986466814717121797643329167921152758393582;
        proof.proof_batch_opening_at_zeta_x = 11797268414157693984774100428733957905305970571047103031402017200555300446281;
        proof.proof_batch_opening_at_zeta_y = 7737530859656421113238682226840570930509736271639207805597891468048016373750;
        proof.proof_opening_at_zeta_omega_x = 12344285007361437292694595079778339790797509848843547871136670336031554616041;
		proof.proof_opening_at_zeta_omega_y = 5737673118308801076310491494683093838047875626127315850888518063044033911765;
        proof.proof_openings_selector_commit_api_at_zeta = 6407401118523840942509308032327713836099114493063532260901295498267171152650   ;
        proof.proof_selector_commit_api_commitment_x = 11101896581033928661655043935394682707325664168977734369613735832387015401778;
        proof.proof_selector_commit_api_commitment_y = 21741256785664817438983157338509304096028488335219408287150630601212165733181;

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
