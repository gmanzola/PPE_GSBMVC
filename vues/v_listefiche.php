
﻿ <div id="contenu">
    <h2>Valider fiche frais </h2>
    
    <div>
      <ul id='menu'>
        <li><a href="index.php?uc=validerFrais&action=SelectionnerMois" title="mois">Changer de mois</a></li>
        <li><a href="index.php?uc=validerFrais&action=choisirVisiteur" title="Changer visiteur">Changer de visiteur</a></li>
      </ul>
    </div>

<div class="encadre">
    
    <h3>Fiche de frais du Visiteur "<?php echo $nom. " " .$prenom ?>" du mois <?php echo $numMois . "-" . $numAnnee ?> : </h3>
    
    <form method="POST" action="index.php?uc=validerfichefrais&action=modification"> 
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
            <th class='supprimer'>Supprimer</th> 
            <th class='reporter'>Reporter</th> 
        </tr>
        <?php
        foreach ($lesFraisHorsForfait as $unFraisHorsForfait) {
            $id = $unFraisHorsForfait['id'];
            $date = $unFraisHorsForfait['date'];
            $libelle = $unFraisHorsForfait['libelle'];
            $montant = $unFraisHorsForfait['montant'];
            ?>

            <tr>
                <td><?php echo $date ?></td>
                <td><?php echo $libelle ?></td>
                <td><?php echo $montant ?></td>
                <td><a href="index.php?uc=validerfichefrais&action=supprimer&id=<?php echo $id;?>">Refuser</a></td>
                <td><a href="index.php?uc=validerfichefrais&action=reporter&id=<?php echo $id;?>">Reporter</a></td>
            </tr>
            <?php
        }
        ?>
    </table>
        </form>
</div>
          
    </div>