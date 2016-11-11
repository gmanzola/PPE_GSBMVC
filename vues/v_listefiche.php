
<div class="encadre">
    
    <h3>Fiche de frais du Visiteur "<?php echo $nom. " " .$prenom ?>" du mois <?php echo $numMois . "-" . $numAnnee ?> : </h3>
    
    <form method="POST" action="index.php?uc=validerFrais&action=modification"> 
        <table class="listeLegere">
           <caption><i>Elements forfaitisés</i></caption>
            
            <tr>
                <?php
                foreach ($lesFraisForfait as $unFraisForfait) {
                    $libelle = $unFraisForfait['libelle'];
                    ?>	
                    <th> <?php echo $libelle ?></th>
                    <?php
                }
                ?>
            </tr>
            <tr>
                <?php
                foreach ($lesFraisForfait as $unFraisForfait) {
                    $quantite = $unFraisForfait['quantite'];
                    $idfrais = $unFraisForfait['idfrais'];
                    ?>
                    <td class="qteForfait"><input type="text" size="10" maxlength="5" name="lesFrais[<?php echo $idfrais ?>]" value="<?php echo $quantite ?> "></td>


                    <?php
                }
                ?><td><input type="submit" value="Modifier" ></td>
            </tr>
        </table>
        <br>
    <table class="listeLegere">
        <caption><i>Descriptif des élements hors forfait -<?php echo $nbjustificatifs ?> justificatifs reçus -
            </i></caption>
        <tr>
            <th class="date">Date</th>
            <th class="libelle">Libellé</th>
            <th class='montant'>Montant</th>
            <th class='montant'>Etat</th>
            <th class='supprimer'>Refuser</th> 
            <th class='reporter'>Reporter</th> 
            <th class='reporter'>Valider</th>
        </tr>
        <?php
        
        
        
        foreach ($lesFraisHorsForfait as $unFraisHorsForfait){
            $id = $unFraisHorsForfait['id'];
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
                <td><a href="index.php?uc=validerFrais&action=refus&id=<?php echo $id;?>&libelle=<?php echo $libelle;?>">Refuser</a></td>
                <td><a href="index.php?uc=validerfichefrais&action=reporter&id=<?php echo $id;?>">Reporter</a></td>
                <td><a href="index.php?uc=validerFrais&action=validerFraisHF&id=<?php echo $id;?>">Valider</a></td>
            </tr>
            <?php
        }
        ?>
    </table>
        </form>
    <center><a href="index.php?uc=validerFrais&action=validerFicheFrais&id=<?php echo $id;?>" 
                      onclick="return confirm('Voulez-vous vraiment valider cette fiche ?');">Valider</a></center>
</div>
    </div>