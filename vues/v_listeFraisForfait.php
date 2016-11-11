<div id="contenu">
      <h2>Renseigner ma fiche de frais du mois <?php echo $numMois."-".$numAnnee ?></h2>
         
      <form method="POST"  action="index.php?uc=gererFrais&action=validerMajFraisForfait">
      <div class="corpsForm">
          
          <fieldset>
            <legend>Eléments forfaitisés
            </legend>
			<?php
				foreach ($lesFraisForfait as $unFrais)
				{
					$idfrais = $unFrais['idfrais'];
					$libelle = $unFrais['libelle'];
					$quantite = $unFrais['quantite'];
			?>
					<p>
						<label for="idfrais"><?php echo $libelle ?></label>
						<input type="text" id="idfrais" name="lesFrais[<?php echo $idfrais?>]" size="10" maxlength="5" value="<?php echo $quantite?>" >
					</p>
			
			<?php
				}
			?>
                                        
        <label for="puissance" accesskey="n">Puissance : </label>
        <select id="puissance" name="puissance">

                                        <?php
			foreach ($lesPuissances as $unePuissance)
			{
                                $id = $unePuissance['id'];
				$type =  $unePuissance['typevehicule'];
				$puissance =  $unePuissance['puissance'];
				if($lesPuissances == $puissanceASelectionner){
				?>
                    <option selected value="<?php echo $id ?>"><?php echo  $type." ".$puissance ?> </option>
				<?php 
				}
				else{ ?>
                    <option value="<?php echo $id ?>"><?php echo  $type." ".$puissance ?> </option>
				<?php 
				}
			
			}
           
		   ?>
                    </select>

          </fieldset>
      </div>
      <div class="piedForm">
      <p>
        <input id="annuler" type="reset" value="Effacer"/>
        <input id="ok" type="submit" value="Valider"/>
      </p> 
      </div>
        
      </form>
  