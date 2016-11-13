<?php
$group_id = $_SESSION['group_id'];

if ($group_id == 1) {
    include("vues/v_sommaire.php");
    $action = $_REQUEST['action'];
    $idvisiteur = $_SESSION['idvisiteur'];
    switch ($action) {
        case 'selectionnerMois': {
                $lesMois = $pdo->getLesMoisDisponibles($idvisiteur);
                // Afin de sélectionner par défaut le dernier mois dans la zone de liste
                // on demande toutes les clés, et on prend la première,
                // les mois étant triés décroissants
                $lesCles = array_keys($lesMois);
                $moisASelectionner = $lesCles[0];
                include("vues/v_listeMois.php");
                break;
            }
        case 'voirEtatFrais': {
                $leMois = $_REQUEST['lstMois'];
                $lesMois = $pdo->getLesMoisDisponibles($idvisiteur);
                $moisASelectionner = $leMois;
                include("vues/v_listeMois.php");
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
                include("vues/v_etatFrais.php");
                break;
            }
        case 'fichePdf':
            $nomvisiteur2 = $_REQUEST['nomvisiteur'];
            $mois = $_REQUEST['mois'];
            $moisTotal = $_REQUEST['moistotal'];
            $annee = $_REQUEST['annee'];
            $idvisiteur = $_REQUEST['idvisiteur'];
            $elementForfait = $pdo->getLesFraisForfaitPdf($idvisiteur, $moisTotal);
            $horsforfait = $pdo->getLesFraisHorsForfait($idvisiteur, $moisTotal);
            $totalFrais = $pdo->getTotalForfaitPdf($idvisiteur, $moisTotal);
            include 'vues/v_fichePdf.php';
            break;
    }
} else {
    if($action != 'fichePdf'){
    include("vues/accesRefuseComptable.php");
    }
}
?>