<?php
// Recuperation variable pour interdire acces au non comptable
$group_id = $_SESSION['group_id'];

if ($group_id == 2) {
    include("vues/v_sommaireComptable.php");
    $action = $_REQUEST['action'];
    $idVisiteur = $_SESSION['idVisiteur'];
    switch ($action) {
        case 'validerFrais': {
            //

            include("vues/v_formValidFrais.php");
            break;
        }
        case 'suviPaiement': {
            //

            include("vues/v_suiviPaiement.php");
            break;
        }
    }
}
else{
    include("vues/accesInterdit.php");
}
?>