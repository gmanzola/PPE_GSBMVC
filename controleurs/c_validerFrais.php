<?php
// Recuperation variable pour interdire acces au non comptable
$group_id = $_SESSION['group_id'];

if ($group_id == 2) {
include("vues/v_sommaireComptable.php");
$mois = getMois(date("d/m/Y"));
$numAnnee = substr($mois, 0, 4);
$numMois = substr($mois, 4, 2);
$action = $_REQUEST['action'];
switch ($action) {
    
    case 'SelectionnerMois': {
            $lesMois=$pdo->getLesMoisAvalider();
            // $leMois = isset($_SESSION['lstMois']) ? $_SESSION['lstMois'] : null; // si c'est faux mettre a nul
            include("vues/v_listeMoisComptable.php");
            break;
        }
        
    case 'choisirVisiteur': {
            $choixMois = $_POST['choixMois'];
            $lesVisiteurs = $pdo->getLesVisiteursAValider($choixMois);
            include("vues/v_listevisiteur.php");
            break;
        }
    case 'fiche': {
            $lesVisiteurs = $pdo->getLesVisiteurs();
            $lesClesV = array_keys($lesVisiteurs);
            $visiteurASelectionner = $lesClesV[0];
            $lastSixMonth = getLesSixDerniersMois();
            $idvisiteur = isset($_REQUEST['lstVisiteurs']) ? $_REQUEST['lstVisiteurs'] : null;
            $leMois = isset($_REQUEST['lstMois']) ? $_REQUEST['lstMois'] : null;
            if ($idvisiteur && $leMois) {
                $_SESSION['idvisiteur'] = $idvisiteur;
                $_SESSION['lstMois'] = $leMois;
                $idvisiteur = $_SESSION['idvisiteur'];
                $leMois = $_SESSION['lstMois'];
            }
            $lesMois = $pdo->getLesMoisDisponibles($idvisiteur);
            include("vues/v_listevisiteur.php");
            $lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idvisiteur, $leMois);
            $lesFraisForfait = $pdo->getLesFraisForfait($idvisiteur, $leMois);
            $lesInfosFicheFrais = $pdo->getLesInfosFicheFrais($idvisiteur, $leMois);
            $numAnnee = substr($leMois, 0, 4);
            $numMois = substr($leMois, 4, 2);
            $libetat = $lesInfosFicheFrais['libetat'];
            $montantvalide = $lesInfosFicheFrais['montantvalide'];
            $nbjustificatifs = $lesInfosFicheFrais['nbjustificatifs'];
            $datemodif = $lesInfosFicheFrais['datemodif'];
            $datemodif = dateAnglaisVersFrancais($datemodif);
            include("vues/v_listefiche.php");
            break;
        }
    case 'modification': {
            $leMois = isset($_SESSION['lstMois']) ? $_SESSION['lstMois'] : null;
            $lesFrais = $_REQUEST['lesFrais'];
            $pdo->majFraisForfait($idvisiteur, $leMois, $lesFrais);
            header('Location: index.php?uc=validerFrais&action=choisirVisiteur');

    }       
            break;
        
    case 'supprimer': {
            $id = $_REQUEST['id'];
            $pdo->refuserfrais($id);
            header('Location: index.php?uc=validerFrais&action=fiche');
    }
            break;
        
    case 'reporter': {
            $id = $_REQUEST['id'];
            $MoisPlus = getMoisNext($numAnnee, substr($_SESSION['lstMois'], 4, 2)); // appel de la fonction qui ajoute 1 au mois
            // $ficheExiste = $pdo->estPremierFraisMois($idvisiteur,$MoisPlus); // un visiteur poss�de une fiche de frais pour le mois pass� en argument
            var_dump($MoisPlus);
            var_dump($idvisiteur);
            /* if ($pdo->estPremierFraisMois($idvisiteur, $MoisPlus)) {
              $pdo->getMoisSuivant($numAnnee, $MoisPlus, $id);
              } else { */
            $pdo->creeNouvellesLignesFrais($idvisiteur, $MoisPlus);
            $req = "UPDATE `lignefraisforfait` SET `mois`='" . $MoisPlus . "' WHERE `idvisiteur`='" . $idvisiteur . "' and `idFraisForfait`='" . $id . "'";
            //} 
            //header('Location: index.php?uc=validerFrais&action=fiche');
            break;
        }
}
//            
}
else{
	include("vues/accesInterdit.php");
}
?>
    </body>
</html>