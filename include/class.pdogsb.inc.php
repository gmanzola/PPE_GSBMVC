<?php

/**
 * Classe d'accès aux données. 

 * Utilise les services de la classe PDO
 * pour l'application GSB
 * Les attributs sont tous statiques,
 * les 4 premiers pour la connexion
 * $monPdo de type PDO 
 * $monPdoGsb qui contiendra l'unique instance de la classe

 * @package default
 * @author Cheri Bibi
 * @version    1.0
 * @link       http://www.php.net/manual/fr/book.pdo.php
 */
class PdoGsb {

    private static $serveur = 'mysql:host=localhost';
    private static $bdd = 'dbname= gmanzola';
    private static $user = 'gmanzola';
    private static $mdp = 'hpvs17';
    private static $monPdo;
    private static $monPdoGsb = null;

    /**
     * Constructeur privé, crée l'instance de PDO qui sera sollicitée
     * pour toutes les méthodes de la classe
     */
    private function __construct() {
        PdoGsb::$monPdo = new PDO(PdoGsb::$serveur . ';' . PdoGsb::$bdd, PdoGsb::$user, PdoGsb::$mdp);
        PdoGsb::$monPdo->query("SET CHARACTER SET utf8");
    }

    public function _destruct() {
        PdoGsb::$monPdo = null;
    }

    /**
     * Fonction statique qui crée l'unique instance de la classe

     * Appel : $instancePdoGsb = PdoGsb::getPdoGsb();

     * @return l'unique objet de la classe PdoGsb
     */
    public static function getPdoGsb() {
        if (PdoGsb::$monPdoGsb == null) {
            PdoGsb::$monPdoGsb = new PdoGsb();
        }
        return PdoGsb::$monPdoGsb;
    }

    /**
     * Retourne les informations d'un visiteur
     * @param $login
     * @param $mdp
     * @return l'id, le nom et le prénom sous la forme d'un tableau associatif
     */
    public function getInfosVisiteur($login, $mdp) {
        //$salt = "VM9DIwqzDv";
        //$mdpsecurise="$salt.$mdp";
        $req = "select visiteur.id as id, visiteur.nom as nom, visiteur.prenom as prenom, typecompte.type, visiteur.typeCompte from visiteur
                INNER JOIN typecompte ON typecompte.id = visiteur.typeCompte
		        where visiteur.login='$login' and visiteur.mdp=SHA1('$mdp')";
        $rs = PdoGsb::$monPdo->query($req);
        $ligne = $rs->fetch();
        return $ligne;
    }

    /**
     * Retourne sous forme d'un tableau associatif toutes les lignes de frais hors forfait
     * concernées par les deux arguments
     * La boucle foreach ne peut être utilisée ici car on procède
     * à une modification de la structure itérée - transformation du champ date-
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     * @return tous les champs des lignes de frais hors forfait sous la forme d'un tableau associatif
     */
    public function getLesFraisHorsForfait($idvisiteur, $mois) {
        $req = "select * from lignefraishorsforfait where lignefraishorsforfait.idvisiteur ='$idvisiteur'
		and lignefraishorsforfait.mois = '$mois' ";
        $res = PdoGsb::$monPdo->query($req);
        $lesLignes = $res->fetchAll();
        $nbLignes = count($lesLignes);
        for ($i = 0; $i < $nbLignes; $i++) {
            $date = $lesLignes[$i]['date'];
            $lesLignes[$i]['date'] = dateAnglaisVersFrancais($date);
        }
        return $lesLignes;
    }

    /**
     * Retourne le nombre de justificatif d'un visiteur pour un mois donné
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     * @return le nombre entier de justificatifs
     */
    public function getNbjustificatifs($idvisiteur, $mois) {
        $req = "select fichefrais.nbjustificatifs as nb from  fichefrais where fichefrais.idvisiteur ='$idvisiteur' and fichefrais.mois = '$mois'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        return $laLigne['nb'];
    }

    /**
     * Retourne sous forme d'un tableau associatif toutes les lignes de frais au forfait
     * concernées par les deux arguments
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     * @return l'id, le libelle et la quantité sous la forme d'un tableau associatif
     */
    public function getLesFraisForfait($idvisiteur, $mois) {
        $req = "select fraisforfait.id as idfrais, fraisforfait.libelle as libelle,
		lignefraisforfait.quantite as quantite from lignefraisforfait inner join fraisforfait
		on fraisforfait.id = lignefraisforfait.idfraisforfait
		where lignefraisforfait.idvisiteur ='$idvisiteur' and lignefraisforfait.mois='$mois'
		order by lignefraisforfait.idfraisforfait";
        $res = PdoGsb::$monPdo->query($req);
        $lesLignes = $res->fetchAll();
        return $lesLignes;
    }

    /**
     * Retourne tous les id de la table FraisForfait
     * @return un tableau associatif
     */
    public function getLesIdFrais() {
        $req = "select fraisforfait.id as idfrais from fraisforfait order by fraisforfait.id";
        $res = PdoGsb::$monPdo->query($req);
        $lesLignes = $res->fetchAll();
        return $lesLignes;
    }

    /**
     * Met à jour la table ligneFraisForfait
     * Met à jour la table ligneFraisForfait pour un visiteur et
     * un mois donné en enregistrant les nouveaux montants
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     * @param $lesFrais tableau associatif de clé idFrais et de valeur la quantité pour ce frais
     * @return un tableau associatif
     */
    public function majFraisForfait($idvisiteur, $mois, $lesFrais) {
        $lesCles = array_keys($lesFrais);
        foreach ($lesCles as $unIdFrais) {
            $qte = $lesFrais[$unIdFrais];
            $req = "update lignefraisforfait set lignefraisforfait.quantite = $qte
			where lignefraisforfait.idvisiteur = '$idvisiteur' and lignefraisforfait.mois = '$mois'
			and lignefraisforfait.idfraisforfait = '$unIdFrais'";
            PdoGsb::$monPdo->exec($req);
        }
    }

    /**
     * met à jour le nombre de justificatifs de la table ficheFrais
     * pour le mois et le visiteur concerné
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     */
    public function majNbJustificatifs($idvisiteur, $mois, $nbjustificatifs) {
        $req = "update fichefrais set nbjustificatifs = $nbjustificatifs
		where fichefrais.idvisiteur = '$idvisiteur' and fichefrais.mois = '$mois'";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * Teste si un visiteur possède une fiche de frais pour le mois passé en argument
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     * @return vrai ou faux
     */
    public function estPremierFraisMois($idvisiteur, $mois) {
        $ok = false;
        $req = "select count(*) as nblignesfrais from fichefrais
		where fichefrais.mois = '$mois' and fichefrais.idvisiteur = '$idvisiteur'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        if ($laLigne['nblignesfrais'] == 0) {
            $ok = true;
        }
        return $ok;
    }

    /**
     * Retourne le dernier mois en cours d'un visiteur
     * @param $idVisiteur
     * @return le mois sous la forme aaaamm
     */
    public function dernierMoisSaisi($idvisiteur) {
        $req = "select max(mois) as dernierMois from fichefrais where fichefrais.idvisiteur = '$idvisiteur'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        $dernierMois = $laLigne['dernierMois'];
        return $dernierMois;
    }

    /**
     * Crée une nouvelle fiche de frais et les lignes de frais au forfait pour un visiteur et un mois donnés
     * récupère le dernier mois en cours de traitement, crée une nouvelle fiche de frais
     * avec un idEtat à 'CR' et crée les lignes de frais forfait de quantités nulles
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     */
    public function creeNouvellesLignesFrais($idvisiteur, $moisSuivant) {
        $dernierMois = $this->dernierMoisSaisi($idvisiteur);
        $laDerniereFiche = $this->getLesInfosFicheFrais($idvisiteur, $dernierMois);
        if ($laDerniereFiche['idetat'] == 'cr') {
            $this->majEtatFicheFrais($idvisiteur, $dernierMois, 'cr');
        }
        $req = "insert into fichefrais(idvisiteur,mois,nbjustificatifs,montantvalide,datemodif,idetat)
		values('$idvisiteur','$moisSuivant',0,0,now(),'cr')";
        PdoGsb::$monPdo->exec($req);
        $lesIdFrais = $this->getLesIdFrais();
        foreach ($lesIdFrais as $uneLigneIdFrais) {
            $unIdFrais = $uneLigneIdFrais['idfrais'];
            $req = "insert into lignefraisforfait(idvisiteur,mois,idfraisforfait,quantite)
			values('$idvisiteur','$moisSuivant','$unIdFrais',0)";
            PdoGsb::$monPdo->exec($req);
        }
    }

    /**
     * Crée un nouveau frais hors forfait pour un visiteur un mois donné
     * à partir des informations fournies en paramètre
     * @param $idVisiteur
     * @param $mois sous la forme aaaamm
     * @param $libelle : le libelle du frais
     * @param $date : la date du frais au format français jj//mm/aaaa
     * @param $montant : le montant
     */
    public function creeNouveauFraisHorsForfait($idvisiteur, $mois, $libelle, $date, $montant) {
        $datefr = dateFrancaisVersAnglais($date);
        $req = "insert into lignefraishorsforfait (idvisiteur,mois,libelle,date,montant)
		values('$idvisiteur','$mois','$libelle','$datefr','$montant')";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * Supprime le frais hors forfait dont l'id est passé en argument
     * @param $idFrais
     */
    public function supprimerFraisHorsForfait($idfrais) {
        $req = "delete from lignefraishorsforfait where lignefraishorsforfait.id =$idfrais ";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * Retourne les mois pour lesquel un visiteur a une fiche de frais
     * @param $idvisiteur
     * @return un tableau associatif de clé un mois -aaaamm- et de valeurs l'année et le mois correspondant
     */
    public function getLesMoisDisponibles($idvisiteur) {
        $req = "select fichefrais.mois as mois from  fichefrais where fichefrais.idvisiteur ='$idvisiteur'
		order by fichefrais.mois desc ";
        $res = PdoGsb::$monPdo->query($req);
        $lesMois = array();
        $laLigne = $res->fetch();
        while ($laLigne != null) {
            $mois = $laLigne['mois'];
            $numAnnee = substr($mois, 0, 4);
            $numMois = substr($mois, 4, 2);
            $lesMois["$mois"] = array(
                "mois" => "$mois",
                "numAnnee" => "$numAnnee",
                "numMois" => "$numMois"
            );
            $laLigne = $res->fetch();
        }
        return $lesMois;
    }

    /**
     * Retourne les mois pour lesquel des fiches de frais sont à valider 
     * @param Aucun
     * @return un tableau associatif de clé un mois -aaaamm- et de valeurs l'année et le mois correspondant
     */
    public function getLesMoisAvalider() {
        $req = "SELECT mois from fichefrais where idetat ='cl' group by mois ORDER BY `fichefrais`.`mois`  DESC";
        $res = PdoGsb::$monPdo->query($req);
        $lesMois = array();
        $laLigne = $res->fetch();
        while ($laLigne != null) {
            $mois = $laLigne['mois'];
            $numAnnee = substr($mois, 0, 4);
            $numMois = substr($mois, 4, 2);
            $lesMois["$mois"] = array(
                "mois" => "$mois",
                "numAnnee" => "$numAnnee",
                "numMois" => "$numMois"
            );
            $laLigne = $res->fetch();
        }
        return $lesMois;
    }
    /**
     * Retourne les mois pour lesquel des fiches de frais sont à valider 
     * @return type
     */
    public function getLesMoisAPayer() {
        $req = "SELECT mois from fichefrais where idetat ='va' group by mois ORDER BY `fichefrais`.`mois`  DESC";
        $res = PdoGsb::$monPdo->query($req);
        $lesMois = array();
        $laLigne = $res->fetch();
        while ($laLigne != null) {
            $mois = $laLigne['mois'];
            $numAnnee = substr($mois, 0, 4);
            $numMois = substr($mois, 4, 2);
            $lesMois["$mois"] = array(
                "mois" => "$mois",
                "numAnnee" => "$numAnnee",
                "numMois" => "$numMois"
            );
            $laLigne = $res->fetch();
        }
        return $lesMois;
    }
    /**
     * Retourne les informations d'une fiche de frais d'un visiteur pour un mois donné
     * @param $idvisiteur
     * @param $mois sous la forme aaaamm
     * @return un tableau avec des champs de jointure entre une fiche de frais et la ligne d'état
     */
    public function getLesInfosFicheFrais($idvisiteur, $mois) {
        $req = "select fichefrais.idetat as idetat, fichefrais.datemodif as datemodif, fichefrais.nbjustificatifs as nbjustificatifs,
			fichefrais.montantvalide as montantvalide, etat.libelle as libetat from  fichefrais inner join etat on fichefrais.idetat = etat.id
			where fichefrais.idvisiteur ='$idvisiteur' and fichefrais.mois = '$mois'";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        return $laLigne;
    }

    /**
     * Modifie l'état et la date de modification d'une fiche de frais
     * Modifie le champ idEtat et met la date de modif à aujourd'hui
     * @param $idvisiteur, $mois, $etat
     * @param $mois sous la forme aaaamm
     */
    public function majEtatFicheFrais($idvisiteur, $mois, $etat) {
        $req = "update fichefrais set idetat = '$etat', datemodif = now()
		where fichefrais.idvisiteur ='$idvisiteur' and fichefrais.mois = '$mois'";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * fonction qui renvoie l'ensemble des visiteurs de la table & qui ne sont pas comptable
     * @return un tableau de visiteur
     */
    public function getLesVisiteurs() {
        $req = "select id, nom as nom, prenom as prenom from visiteur where typecompte=1 order by nom asc";
        $res = PdoGsb::$monPdo->query($req);
        $lesVisiteurs = array();
        $laLigne = $res->fetch();
        while ($laLigne != null) {
            $id = $laLigne['id'];
            $nom = $laLigne['nom'];
            $prenom = $laLigne['prenom'];
            $lesVisiteurs["$id"] = array(
                "id" => "$id",
                "nom" => "$nom",
                "prenom" => "$prenom"
            );
            $laLigne = $res->fetch();
        }
        return $lesVisiteurs;
    }

    /**
     * renvoie les visiteurs qui ont une fiche de frais pour le mois en paramètre
     * @param $choixMois
     * @return un tableau contenant les visiteurs
     */
    public function getLesVisiteursAValider($choixMois) {
        $req = "SELECT id,nom as nom, prenom as prenom from fichefrais join visiteur v where idVisiteur = v.id and mois ='$choixMois' and typecompte = 1 and idetat = 'cl'";
        $res = PdoGsb::$monPdo->query($req);
        $lesVisiteursValidation = array();
        $laLigne = $res->fetch();
        while ($laLigne != null) {
            $id = $laLigne['id'];
            $nom = $laLigne['nom'];
            $prenom = $laLigne['prenom'];
            $lesVisiteursValidation["$id"] = array(
                "id" => "$id",
                "nom" => "$nom",
                "prenom" => "$prenom"
            );
            $laLigne = $res->fetch();
        }
        return $lesVisiteursValidation;
    }

    public function getLesVisiteursAPayer($choixMois) {
        $req = "SELECT id,nom as nom, prenom as prenom from fichefrais join visiteur  where idVisiteur = id and mois = '$choixMois' and typecompte = 1 and idetat = 'va'";
        $res = PdoGsb::$monPdo->query($req);
        $lesVisiteursValidation = array();
        $laLigne = $res->fetch();
        while ($laLigne != null) {
            $id = $laLigne['id'];
            $nom = $laLigne['nom'];
            $prenom = $laLigne['prenom'];
            $lesVisiteursValidation["$id"] = array(
                "id" => "$id",
                "nom" => "$nom",
                "prenom" => "$prenom"
            );
            $laLigne = $res->fetch();
        }
        return $lesVisiteursValidation;
    }
    public function getLeVisiteur($idVisiteur) {
        $req = "select * from visiteur where id ='$idVisiteur'";
        $resultat = PdoGsb::$monPdo->query($req);
        $fetch = $resultat->fetch();
        return $fetch;
    }

    /**
     * fonction qui refuse un frais (ce frais n'est pas supprimer mais il change d'état)
     * @param $id du frais hors forfait
     */
    public function refuserFraisHorsForfait($id, $libelle) {
        $req = "update lignefraishorsforfait set etat = 'rf', libelle = concat('« REFUSE » ','$libelle') where id = '$id'";
        //echo $req;
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * fonction qui reporte un frais (ce frais est envoyé au mois suivant)
     * @param $id du frais hors forfait
     */
    public function ReportFraisHorsForfait($moisSuivant, $idVisiteur, $id) {
        $req = "UPDATE lignefraishorsforfait SET mois ='$moisSuivant', etat = 'rp' WHERE idvisiteur='$idVisiteur' and id ='$id'";
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * fonction qui valide un frais (ce frais change d'état)
     * @param $id du frais hors forfait
     */
    public function validerFraisHorsForfait($id) {
        $req = "update lignefraishorsforfait set etat ='va' where id = '$id'";
        //echo $req;
        PdoGsb::$monPdo->exec($req);
    }

    public function validerFicheFrais($idVisiteur, $choixMois, $montantTotal) {
        $req = "update fichefrais set idetat = 'va', montantvalide = '$montantTotal', datemodif= now() where idvisiteur = '$idVisiteur' and mois ='$choixMois' ";
        //echo $req;
        PdoGsb::$monPdo->exec($req);
    }
    
    public function mettreEnPaiement($idVisiteur, $choixMois) {
        $req = "update fichefrais set idetat = 'mp',datemodif= now() where idvisiteur = '$idVisiteur' and mois = '$choixMois'";
        //echo $req;
        PdoGsb::$monPdo->exec($req);
    }

    /**
     * fonction 
     * @param $idVisiteur, $mois
     */
    public function verifEtatFraisHF($idVisiteur, $choixMois) {

        $ok = false;
        $req = "select count(*) as nblignesfraisHF from lignefraishorsforfait where idvisiteur ='$idVisiteur' and etat = 'at' and mois='$choixMois' ";
        $res = PdoGsb::$monPdo->query($req);
        $laLigne = $res->fetch();
        if ($laLigne['nblignesfraisHF'] == 0) {
            $ok = true;
        }
        return $ok;
    }

    public function montantTotal($idVisiteur, $choixMois) {
        $req = "select sum(montant) as montantTotalFraisHF from lignefraishorsforfait where idvisiteur='$idVisiteur' and mois='$choixMois' and etat='va'";
        $res = PdoGsb::$monPdo->query($req);
        $montantHF = $res->fetch();

        $req = "select SUM(montant * quantite) as montantFraisForfait from fraisforfait inner join lignefraisforfait on fraisforfait.id = lignefraisforfait.idfraisforfait where idvisiteur = '$idVisiteur' and mois ='$choixMois'";
        $res = PdoGsb::$monPdo->query($req);
        $montantForfait = $res->fetch();

        $montantTotal = $montantHF['montantTotalFraisHF'] + $montantForfait['montantFraisForfait'];
        return $montantTotal;
    }

}

?>
