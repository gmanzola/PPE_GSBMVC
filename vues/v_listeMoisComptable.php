
 <div id="contenu">
    <h2>Valider fiche frais </h2>
    <h3>sélectionner le mois à valider : </h3>
    <form action="index.php?uc=validerFrais&action=choisirVisiteur" method="post">

        <div class="corpsForm">
            <p>
                <label for="lstMois" accesskey="n">selectionner votre mois: </label>
                <select id="lstMois" name="lstMois">
                    <?php
                    $tableMois = $lastSixMonth['id'];
                    $i = 0;
                    foreach ($tableMois as $mois) {
                        if ($mois == $Visiteur['id']) {
                            
                        } else {
                            ?>
                            <option value="<?php echo $mois; ?>"><?php echo $lastSixMonth['libelle'][$i]; ?></option> 
                            <?php
                        }
                        $i++;
                    }
                    ?>

                </select>
    
            </p>

            
            
        </div>
        <div class="piedForm">
            <p>
                <input id="ok" type="submit" value="Valider"/>
                <input id="annuler" type="reset" value="Effacer"/>
            </p> 

        </div>

    </form>
