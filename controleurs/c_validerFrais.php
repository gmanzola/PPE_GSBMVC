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
            include("vues/v_listeMoisComptable.php");
            break;
        }
        
    case 'choisirVisiteur': {
            $choixMois = $_POST['choixMois'];
            $_SESSION['choixMois'] = $choixMois;
            $lesVisiteurs = $pdo->getLesVisiteursAValider($choixMois);
            include("vues/v_listevisiteur.php");
            break;
        }
    case 'fiche': {
        
            $idVisiteur = $_SESSION['choixVisiteur'];
            $_SESSION['idVisiteur'] = $idVisiteur;
            
            $choixMois = $_SESSION['choixMois'];
            $_SESSION['choixMois'] = $choixMois;
            
            $lesVisiteurs = $pdo->getLesVisiteursAValider($choixMois);
            include("vues/v_listevisiteur.php");
            $visiteur = $pdo->getLeVisiteur($idVisiteur);
            $nom = $visiteur['nom'];
            $prenom = $visiteur['prenom'];
            
            
            $lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idVisiteur, $choixMois);
            $lesFraisForfait = $pdo->getLesFraisForfait($idVisiteur, $choixMois);
            $lesInfosFicheFrais = $pdo->getLesInfosFicheFrais($idVisiteur, $choixMois);
            $numAnnee = substr($choixMois, 0, 4);
            $numMois = substr($choixMois, 4, 2);
            $libetat = $lesInfosFicheFrais['libetat'];
            $montantvalide = $lesInfosFicheFrais['montantvalide'];
            $nbjustificatifs = $lesInfosFicheFrais['nbjustificatifs'];
            $datemodif = $lesInfosFicheFrais['datemodif'];
            $datemodif = dateAnglaisVersFrancais($datemodif);
            include("vues/v_listefiche.php");
            break;
        }
    case 'modification': {
        
            $choixMois = $_SESSION['choixMois'];
            $idVisiteur = $_SESSION['choixVisiteur']; 
            $lesFrais = $_REQUEST['lesFrais'];
            $pdo->majFraisForfait($idVisiteur, $choixMois, $lesFrais);
            include('vues/v_modif.php');
            //header('Location: index.php?uc=validerfichefrais&action=fiche');

    }       
            break;
        
    case 'refus': {
            $id = $_REQUEST['id'];
            $pdo->refuserFraisHorsForfait($id);
            include('vues/v_refus.php');
            //header('Location: index.php?uc=validerfichefrais&action=fiche');
    }
            break;
        
    case 'reporter': {
            $id = $_REQUEST['id'];
            $idVisiteur = $_SESSION['choixVisiteur'];
            $moisSuivant = getMoisNext($numAnnee, substr($_SESSION['choixMois'], 4, 2)); // appel de la fonction qui ajoute 1 au mois
            
            $pdo->creeNouvellesLignesFrais($idVisiteur, $moisSuivant);
            $pdo->ReportFraisHorsForfait($moisSuivant, $idVisiteur, $id);
            include('vues/v_report.php');
            //header('Location: index.php?uc=validerfichefrais&action=fiche');
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