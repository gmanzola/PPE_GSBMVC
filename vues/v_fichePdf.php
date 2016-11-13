<?php
include 'fpdf/fpdf.php';
class PDF extends FPDF{
function Header(){
$this->Image('images/logo.jpg', 80, 2, 60);
$this->Ln(20);
}
function Footer(){
$this->SetY(-50);
$this->Cell(190,5, utf8_decode('Fait à Paris, le '.date("d-m-Y")));
$this->SetY(-40);
$this->Cell(202,5, utf8_decode('Vu l\'agent comptable'));
$this->Image('images/signature.jpg', 110, 250, 60);
}
}
ob_get_clean();
// Activation de la classe
$pdf = new PDF('P', 'mm', 'A4');
$pdf->AddPage();
$pdf->SetFont('Helvetica', '', 11);
$pdf->SetTextColor(0);
$pdf->Text(8, 58,'Visiteur : '.$nomvisiteur2);
$pdf->Text(8, 69, 'Mois : '.$mois."/".$annee);
// Position de l'entête à 10mm des infos (69+10)
$position_entete = 79;
function entete_table($position_entete){
    global $pdf;
    $pdf->SetDrawColor(183); // Couleur du fond
    $pdf->SetFillColor(221); // Couleur des filets
    $pdf->SetTextColor(0); // Couleur du texte
    $pdf->SetY($position_entete);
    $pdf->SetX(8); //position de la premiere colonne
    $pdf->Cell(40,8,'Frais Forfaitaires',1,0,'L',1);
    $pdf->SetX(48); //40+8
    $pdf->Cell(40,8,'Quantite',1,0,'C',1);
    $pdf->SetX(88); 
    $pdf->Cell(40,8,'Montant unitaire',1,0,'C',1);
    $pdf->SetX(128);
    $pdf->Cell(35, 8,'Total',1,0,'C',1);
    $pdf->Ln(); // Retour à la ligne
}
entete_table($position_entete);
//liste des détails
$position_detail = 87;
foreach($elementForfait as $unElement){
    $pdf->SetY($position_detail);
    $pdf->SetX(8);
    $pdf->MultiCell(40,8,utf8_decode($unElement['libelle']),1,'L');
    $pdf->SetY($position_detail);
    $pdf->SetX(48);
    $pdf->MultiCell(40,8,$unElement['quantite'],1,'C');
    $pdf->SetY($position_detail);
    $pdf->SetX(88);
    $pdf->MultiCell(40,8,$unElement['montant'],1,'R');
    $pdf->SetY($position_detail);
    $pdf->SetX(128);
    $pdf->MultiCell(35,8,$unElement['total'],1,'R');
    $position_detail += 8;
}
//liste details hors forfaits
$position_detail2 = $position_detail + 20;
$pdf->Text(80, $position_detail2,'Autres Frais');
$position_entete2 = $position_detail2 + 10;
function entete_table2($position_entete2){
    global $pdf;
    $pdf->SetDrawColor(183); // Couleur du fond
    $pdf->SetFillColor(221); // Couleur des filets
    $pdf->SetTextColor(0); // Couleur du texte
    $pdf->SetY($position_entete2);
    $pdf->SetX(8); //position de la premiere colonne
    $pdf->Cell(40,8,'Date',1,0,'L',1);
    $pdf->SetX(48); //40+8
    $pdf->Cell(80,8,'Libelle',1,0,'C',1);
    $pdf->SetX(128); 
    $pdf->Cell(35,8,'Montant',1,0,'R',1);
    $pdf->Ln(); // Retour à la ligne
}
entete_table2($position_entete2);
$position_detail2 = $position_entete2 + 8;
foreach($horsforfait as $unElement){
    $pdf->SetY($position_detail2);
    $pdf->SetX(8);
    $pdf->MultiCell(40,8,utf8_decode($unElement['date']),1,'L');
    $pdf->SetY($position_detail2);
    $pdf->SetX(48);
    $pdf->MultiCell(80,8,$unElement['libelle'],1,'L');
    $pdf->SetY($position_detail2);
    $pdf->SetX(128);
    $pdf->MultiCell(35,8,$unElement['montant'],1,'R');
    $position_detail2 += 8;
}
foreach($totalFrais as $total){
$pdf->SetX(100);
$pdf->Cell(28, 8,'Total : ',1,'L');
$pdf->SetX(128);
$pdf->Cell(35, 8, $total['total'], 1,'R');
}
$pdf->Output();
?>
