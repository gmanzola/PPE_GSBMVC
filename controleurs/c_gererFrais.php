<?php

$group_id = $_SESSION['group_id'];

if ($group_id == 1) {
    include("vues/v_sommaire.php");
    $idvisiteur = $_SESSION['idvisiteur'];
    $mois = getMois(date("d/m/Y"));
    $numAnnee = substr($mois, 0, 4);
    $numMois = substr($mois, 4, 2);
    $action = $_REQUEST['action'];
    switch ($action) {
        case 'saisirFrais': {
                if ($pdo->estPremierFraisMois($idvisiteur, $mois)) {
                    $pdo->creeNouvellesLignesFrais($idvisiteur, $mois);
                }
                break;
            }
        case 'validerMajFraisForfait': {
                $lesFrais = $_REQUEST['lesFrais'];
                if (lesQteFraisValides($lesFrais)) {
                    $pdo->majFraisForfait($idvisiteur, $mois, $lesFrais);
                } else {
                    ajouterErreur("Les valeurs des frais doivent être numériques");
                    include("vues/v_erreurs.php");
                }
                break;
            }
        case 'validerCreationFrais': {
                $datefrais = $_REQUEST['datefrais'];
                $libelle = $_REQUEST['libelle'];
                $montant = $_REQUEST['montant'];
                valideInfosFrais($datefrais, $libelle, $montant);
                if (nbErreurs() != 0) {
                    include("vues/v_erreurs.php");
                } else {
                    $pdo->creeNouveauFraisHorsForfait($idvisiteur, $mois, $libelle, $datefrais, $montant);
                }
                break;
            }
        case 'supprimerFrais': {
                $idfrais = $_REQUEST['idfrais'];
                $pdo->supprimerFraisHorsForfait($idfrais);
                break;
            }
    }
    $lesFraisHorsForfait = $pdo->getLesFraisHorsForfait($idvisiteur, $mois);
    $lesFraisForfait = $pdo->getLesFraisForfait($idvisiteur, $mois);
    
    $lesPuissances = $pdo->getLesPuissances();
    // Afin de sélectionner par défaut une puisssance dans la zone de liste
    // on demande toutes les clés, et on prend la première,
    $lesCles = array_keys($lesPuissances);
    $puissanceASelectionner = $lesCles[0];
    
    include("vues/v_listeFraisForfait.php");
    include("vues/v_listeFraisHorsForfait.php");
} else {
    include("vues/accesRefuseComptable.php");
}
?>