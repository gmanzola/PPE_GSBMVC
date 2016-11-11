<?php
// Recuperation variable pour interdire acces au non comptable
$group_id = $_SESSION['group_id'];

if ($group_id == 2) {
    include("vues/v_sommaireComptable.php");
    $mois = getMois(date("d/m/Y"));
    $numAnnee = substr($mois, 0, 4);
    $numMois = substr($mois, 4, 2);
    $action = $_REQUEST['action'];
    switch ($action){
        
        case 'SelectionnerMois': {
                $lesMois = $pdo->getLesMoisAPayer();
                include("vues/v_suiviPaiement.php");
                break;
            }

        case 'choisirVisiteur': {  
                $choixMois = $_POST['choixMois'];
                $_SESSION['choixMois'] = $choixMois;
                $lesVisiteurs = $pdo->getLesVisiteursAPayer($choixMois);
                include("vues/v_listeVisiteurAPayer.php");
                break;
            }
        case 'fiche': {

                $idVisiteur = $_REQUEST['choixVisiteur'];
                $_SESSION['idVisiteur'] = $idVisiteur;
                $choixMois = $_SESSION['choixMois'];

                if (isset($idVisiteur) && isset($choixMois)) {
                    $_SESSION['choixVisiteur'] = $idVisiteur;
                    $_SESSION['choixMois'] = $choixMois;
                    $choixMois = $_SESSION['choixMois'];
                    $idVisiteur = $_SESSION['choixVisiteur'];
                }

                $lesVisiteurs = $pdo->getLesVisiteursAPayer($choixMois);
                include("vues/v_listeVisiteurAPayer.php");
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
                
                include("vues/v_suiviEtatFrais.php");
                break;
            }
            
        case 'mettreEnPaiement' :{
                $idVisiteur = $_SESSION['idVisiteur'];
                $choixMois = $_SESSION['choixMois'];
                $pdo->mettreEnPaiement($idVisiteur,$choixMois);
                include("vues/v_mettreEnPaiement.php");
                break;
        }
            
    }
    }
    else {
    include("vues/accesInterdit.php");
}
?>