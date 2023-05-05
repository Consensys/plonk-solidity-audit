

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

        proof.proof_l_com_x = 15314576364041824615880691095141758016267740896931261920172039390330542418787;
        proof.proof_l_com_y = 5305217419721938393850053464765645855550102557502527524240083218785900961817;
        proof.proof_r_com_x = 16001621491119070360748425124904136457912549193376868800082156668132309265313;
        proof.proof_r_com_y = 9920735724474651844336269731621653246607248966713607551299918373978501675962;
        proof.proof_o_com_x = 1027759416471565161690950552817935989947355822546083147077686460751090917261;
        proof.proof_o_com_y = 12942602241920173329134489538021379067726164081555249104051316426902626796686;
        proof.proof_h_0_x = 16784050255607245366621807764427983569625232786601858370279318523435260045051;
        proof.proof_h_0_y = 20687995167085177166468278155050977818492476844373285301534870521399743326352;
        proof.proof_h_1_x = 3201602305322748152719177733912233618136511717025991738153103140877209894193;
        proof.proof_h_1_y = 13148079099372817847213357250211917535163309821340037908181826637640609912457;
        proof.proof_h_2_x = 10355706395631202016356356176088925443275384363766281626170830032931293356987;
        proof.proof_h_2_y = 3643868611312563296210123964250030069557897620788346584700249044456169204442;
        proof.proof_l_at_zeta = 30871130293389125996311876247903236993775252887433396892910513634772009006;
        proof.proof_r_at_zeta = 21725161557351618486973659404237893422988448934309898843085021696419321790054;
        proof.proof_o_at_zeta = 9757749604672985059699258702673899416611033593066516281662123147211928327308;
        proof.proof_s1_at_zeta = 8198789527005918761527859247621349285364744569786586911824294502997519179313;
        proof.proof_s2_at_zeta = 781975518376630929985394460908067249584218730351184481577101408083462639302;
        proof.proof_grand_product_commitment_x = 6317043595098055234630277053074674898961746369538310939681775877594177882998;
        proof.proof_grand_product_commitment_y = 17491057647529626539793738801685940397507759881740760956994781448527045113920;
        proof.proof_grand_product_at_zeta_omega = 6518695010135602873773293371573552571892536643400119567011462919250418868814;
        proof.proof_quotient_polynomial_at_zeta = 5728371117357568660233654447978545250608597580104120544148916159861432118457;
        proof.proof_linearised_polynomial_at_zeta = 21612084939864036637439814395124680381348915358464431492519932227933950412901;
        proof.proof_batch_opening_at_zeta_x = 6613982093242271458150583498716569725323456830286293427338952390581352411227;
        proof.proof_batch_opening_at_zeta_y = 3125616850787125484794526618842840701478579790919481429741447463149844963327;
        proof.proof_opening_at_zeta_omega_x = 21882394079560196662727062484942770009843779945249551194293044137846224774578;
		proof.proof_opening_at_zeta_omega_y = 18532271946609786083114909416438287920096362305898960631110377131568606511383;
        proof.proof_openings_selector_commit_api_at_zeta = 12441916635397443259918639176760651368542114156538097678971610393458091188019   ;
        proof.proof_selector_commit_api_commitment_x = 1490835892827752056726076718496792087146768505763332417442859059432744372957;
        proof.proof_selector_commit_api_commitment_y = 13703475425010545395871243080566088905928916092209898279693295834517577755313;

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
