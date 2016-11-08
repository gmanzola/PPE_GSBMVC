 <div id="contenu">
    <h2>Mettre en Paiement les fiches de frais </h2>
    <h3>Visiteur à sélectionner : </h3>
    
    <div>
      <ul id='menu'>
        <li><a href="index.php?uc=suiviFrais&action=SelectionnerMois" title="mois">Changer de mois</a></li>
      </ul>
    </div>
    
    <form action="index.php?uc=suiviFrais&action=fiche" method="post">
        <div class="corpsForm">

            <p>
                <label for="lstVisiteurs" accesskey="n">Rechercher le visiteur médical : </label>
                <select id="lstVisiteurs" name="choixVisiteur">
                    <?php
                    foreach ($lesVisiteurs as $Visiteur) {
                        $id = $Visiteur['id'];
                        $prenom = $Visiteur['prenom'];
                        $nom = $Visiteur['nom'];
                        if ($Visiteur == $Visiteur['id']) {
                            ?>                     
                            <option selected value="<?php echo $id ?>"><?php echo $nom . " " . $prenom ?></option>
                            <?php
                        } else {
                            ?>
                            <option value="<?php echo $id ?>"><?php echo $nom . " " . $prenom ?></option>
                            <?php
                        }
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