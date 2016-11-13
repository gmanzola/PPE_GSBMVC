
<h3>Fiche de frais du mois <?php echo $numMois."-".$numAnnee?> : 
    </h3>
    <div class="encadre">
        <?php $nomvisiteur = $_SESSION['prenom'] . " " . $_SESSION['nom']; ?>
        <?php $leMoisNew = substr($leMois, 4,2); ?>
        <?php $annee = substr($leMois, 0,4); ?>
        
    <p>
        Etat : <?php echo $libetat?> depuis le <?php echo $datemodif?> <br> Montant validé : <?php echo $montantvalide?>
    </p>

  	<table class="listeLegere">
  	   <caption>Eléments forfaitisés </caption>
        <tr>
         <?php
         foreach ( $lesFraisForfait as $unFraisForfait ) 
		 {
			$libelle = $unFraisForfait['libelle'];
		?>	
			<th> <?php echo $libelle?></th>
		 <?php
        }
		?>
		</tr>   
        <tr>
        <?php
          foreach (  $lesFraisForfait as $unFraisForfait  ) 
		  {
				$quantite = $unFraisForfait['quantite'];
		?>
                <td class="qteForfait"><?php echo $quantite?> </td>
		 <?php
          }
		?>
		</tr>
    </table>
  	<table class="listeLegere">
  	   <caption>Descriptif des éléments hors forfait -<?php echo $nbjustificatifs ?> justificatifs reçus - </caption>
             <tr>
                <th class="date">Date</th>
                <th class="libelle">Libellé</th>
                <th class='montant'>Montant</th>
                <th class='etat'>Etat</th>
             </tr>
        <?php      
          foreach ( $lesFraisHorsForfait as $unFraisHorsForfait ) 
		  {
			$date = $unFraisHorsForfait['date'];
			$libelle = $unFraisHorsForfait['libelle'];
			$montant = $unFraisHorsForfait['montant'];
                        $etat = $unFraisHorsForfait['etat'];
		?>
             <tr>
                <td><?php echo $date ?></td>
                <td><?php echo $libelle ?></td>
                <td><?php echo $montant ?></td>
                <td><?php echo $etat ?></td>
             </tr>
        <?php 
          }
		?>
    </table>
    
    <p class="pdf">
    
    <center><a href="index.php?uc=etatFrais&action=fichePdf&nomvisiteur=<?php echo $nomvisiteur; ?>&mois=<?php echo $leMoisNew; ?>&moistotal=<?php echo $leMois; ?>&annee=<?php echo $annee; ?>&idvisiteur=<?php echo $idvisiteur; ?>"
               onclick="return confirm('Voulez vous generer votre fiche ?');">
               <input type="submit" value="Génerer un pdf"/></a></center>
    </p>
  </div>
 













