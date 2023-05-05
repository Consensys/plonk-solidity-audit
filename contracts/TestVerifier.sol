

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

        proof.proof_l_com_x = 20085749010394620151410179777226987329228117734795405454950301815130248277553;
        proof.proof_l_com_y = 342301518178377233818040297538994281454091300235477480184553134998700344583;
        proof.proof_r_com_x = 1020945385542746681575050632268333323408596413428622097362125967388719869758;
        proof.proof_r_com_y = 15514239396476126985156536469701967482194300279730884576605121616046384782819;
        proof.proof_o_com_x = 17200931209559555781383343692490625344233565212672417480250994362221321637950;
        proof.proof_o_com_y = 14181852678057824095052593343660090477555127320466274400830123336584501612919;
        proof.proof_h_0_x = 17913736838538860263572146746271323932492391452348145598008881690257011465080;
        proof.proof_h_0_y = 19139259948440696450525743768774401366824979364637086644118299856289248002075;
        proof.proof_h_1_x = 17461477900731951712476890919662740163987778899097119508143884920894962708625;
        proof.proof_h_1_y = 20439256696792891134888616694317787758649162322981518488713122039774776296577;
        proof.proof_h_2_x = 21888227812628196096258901527256461571697610514046101173079080366178316627391;
        proof.proof_h_2_y = 11607562133375400663014130876654631557653142419916157480972925435006268009217;
        proof.proof_l_at_zeta = 1848489479112483540180206415054619172594321774658121714907537346834112348850;
        proof.proof_r_at_zeta = 13875420579929814024169687440489376927772064600584999159265691266779852977457;
        proof.proof_o_at_zeta = 14500159892207211978970933555500056754660235267211017657427000908614375405415;
        proof.proof_s1_at_zeta = 14337093106455483083364165056414042402009990917590689540332255943222265094530;
        proof.proof_s2_at_zeta = 15114585537970547667588677757061182261940341376925644349328387119236503922050;
        proof.proof_grand_product_commitment_x = 17283473607937913968724748981854744857178965255639002852590965768958656293280;
        proof.proof_grand_product_commitment_y = 12635990355646703924834093597892344460065789881257771656880351775436397929883;
        proof.proof_grand_product_at_zeta_omega = 17773186997579386619547487091533938655257849332797832742197813563230754072422;
        proof.proof_quotient_polynomial_at_zeta = 17959396524884204300751733900243104484904494499382720820027404657445997947458;
        proof.proof_linearised_polynomial_at_zeta = 2704579857949456542050685519635143680021105971717584575681142986498496279150;
        proof.proof_batch_opening_at_zeta_x = 980647329910032188947682782284788364339753882876310809504428866778949717308;
        proof.proof_batch_opening_at_zeta_y = 14534413580634386613980673651773109405691258029645860160629965296371017452688;
        proof.proof_opening_at_zeta_omega_x = 10628209260099785236274977524897179587910009869964502424172030490569361999790;
		proof.proof_opening_at_zeta_omega_y = 10032257858784666953716370223468682287689782691426306246003132297992701234340;
        proof.proof_openings_selector_commit_api_at_zeta = 21801583007862785106175200213562382293318633298893075762571110786685786925261   ;
        proof.proof_selector_commit_api_commitment_x = 18104307414833019549805448676087309999017080508562967044918084485211311824141;
        proof.proof_selector_commit_api_commitment_y = 18178658364070133250714937008149762797169330158020798943266754009678760581807;

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
