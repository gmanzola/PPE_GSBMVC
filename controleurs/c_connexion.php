<?php
if(!isset($_REQUEST['action'])){
	$_REQUEST['action'] = 'demandeConnexion';
}
$action = $_REQUEST['action'];
switch($action){
	case 'demandeConnexion':{
		include("vues/v_connexion.php");
		break;
	}
	case 'valideConnexion': {
        $login = $_REQUEST['login'];
        $mdp = $_REQUEST['mdp'];
        $visiteur = $pdo->getInfosVisiteur($login, $mdp);
        if (!is_array($visiteur)) {
            ajouterErreur("Login ou mot de passe incorrect");
            include("vues/v_erreurs.php");
            include("vues/v_connexion.php");
        } else {
            $id = $visiteur['id'];
            $nom = $visiteur['nom'];
            $prenom = $visiteur['prenom'];
            connecter($id, $nom, $prenom);
            $group_id = $visiteur['typeCompte'];
            $group_type = $visiteur['type'];
            connecter($id, $nom, $prenom, $group_id, $group_type);
            if ($group_id == 2) {
                // Rediriger l'utilisateur après la connexion
                header("Location: index.php?uc=validerFrais&action=validerFrais");
                include("vues/v_sommaireComptable.php");
            } else {
                // Rediriger l'utilisateur après la connexion
                header("Location: index.php?uc=gererFrais&action=saisirFrais");
                // include("vues/v_sommaire.php");
                include("vues/v_sommaire.php");
            }
        }
        break;
    }
	default :{
		include("vues/v_connexion.php");
		break;
	}
}
?>