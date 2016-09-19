    <!-- Division pour le sommaire -->
    <div id="menuGauche">
     <div id="infosUtil">
    
        <h2>
    
</h2>
    
      </div>  
        <ul id="menuList">
			<li >

                <?php
                echo $_SESSION['group_type']
                ?>

                :</br><br>
                <?php echo $_SESSION['prenom']."  ".$_SESSION['nom']  ?>
                </br></br>
			</li>
                    <li class="smenu">
              <a href="index.php?uc=validerFrais&action=choisirVisiteur" title="Valider fiche de frais">Valider fiche frais</a>
           </li>
           <br>
           <li class="smenu">
              <a href="index.php?uc=suiviFrais&action=selectionnerFicheDeFrais" title="Suivre le paiement fiches de frais">Suivi paiement des fiches de frais</a>
           </li>
           </br></br>
 	   <li class="smenu">
              <a href="index.php?uc=connexion&action=deconnexion" title="Se déconnecter">Déconnexion</a>
           </li>
         </ul>
        
</div>
    