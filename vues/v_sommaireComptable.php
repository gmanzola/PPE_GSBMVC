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
              <a href="index.php?uc=validerFrais&action=validerFrais" title="Valider fiche de frais ">Valider fiche de frais</a>
           </li>
           <li class="smenu">
              <a href="index.php?uc=validerFrais&action=suviPaiement" title="Suivi des paiements">Suivi des paiements</a>
           </li>
            </br></br>
 	   <li class="smenu">
              <a href="index.php?uc=connexion&action=deconnexion" title="Se déconnecter">Déconnexion</a>
           </li>
         </ul>
        
    </div>
    