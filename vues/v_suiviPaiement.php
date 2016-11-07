 <div id="contenu">
    <h2>Les fiches de frais a payer</h2>
    <h3>Mois à sélectionner : </h3>
    <form action="index.php?uc=suiviFrais&action=choisirVisiteur" method="post">
        <div class="corpsForm">

            <p>

                <label for="lstMois" accesskey="n">Mois : </label>
                <select id="lstMois" name="choixMois">
                    <?php
                    foreach ($lesMois as $unMois) {
                        $mois = $unMois['mois'];
                        $numAnnee = $unMois['numAnnee'];
                        $numMois = $unMois['numMois'];
                        ?>
                        <option selected value="<?php echo $mois ?>"><?php echo $numMois . "/" . $numAnnee ?> </option>
                        <?php
                    }
                    ?>    

                </select>
            </p>
        </div>
        <div class="piedForm">
            <p>
                <input id="annuler" type="reset" value="Réinitialiser"/>
                <input id="ok" type="submit" value="Valider"/>
            </p> 
        </div>

    </form>