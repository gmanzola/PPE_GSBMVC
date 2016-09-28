-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Mar 27 Septembre 2016 à 01:04
-- Version du serveur :  5.5.52-0+deb8u1
-- Version de PHP :  5.6.24-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  ` gmanzola`
--

-- --------------------------------------------------------

--
-- Structure de la table `etat`
--

CREATE TABLE IF NOT EXISTS `etat` (
  `id` char(2) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `etat`
--

INSERT INTO `etat` (`id`, `libelle`) VALUES
('cl', 'saisie clôturée'),
('cr', 'fiche créée, saisie en cours'),
('rb', 'remboursée'),
('va', 'validée et mise en paiement');

-- --------------------------------------------------------

--
-- Structure de la table `fichefrais`
--

CREATE TABLE IF NOT EXISTS `fichefrais` (
  `idvisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `nbjustificatifs` int(11) DEFAULT NULL,
  `montantvalide` decimal(10,2) DEFAULT NULL,
  `datemodif` date DEFAULT NULL,
  `idetat` char(2) DEFAULT 'cr'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `fichefrais`
--

INSERT INTO `fichefrais` (`idvisiteur`, `mois`, `nbjustificatifs`, `montantvalide`, `datemodif`, `idetat`) VALUES
('a12', '201609', 0, 0.00, '2016-09-08', 'cr'),
('a12', '201610', 0, 0.00, '2016-09-24', 'cr'),
('a131', '201609', 0, 0.00, '2016-09-08', 'cr'),
('a17', '201609', 0, 0.00, '2016-09-05', 'cr'),
('a55', '201608', 0, NULL, NULL, 'cr'),
('a55', '201609', 0, 0.00, '2016-09-05', 'cr'),
('a945', '201609', 0, 0.00, '2016-09-14', 'cr'),
('b16', '201609', 0, 0.00, '2016-09-23', 'cr'),
('b4', '201607', 0, NULL, NULL, 'cr');

-- --------------------------------------------------------

--
-- Structure de la table `fraisforfait`
--

CREATE TABLE IF NOT EXISTS `fraisforfait` (
  `id` char(3) NOT NULL,
  `libelle` char(20) DEFAULT NULL,
  `montant` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `fraisforfait`
--

INSERT INTO `fraisforfait` (`id`, `libelle`, `montant`) VALUES
('etp', 'forfait etape', 110.00),
('km', 'frais kilométrique', 0.62),
('nui', 'nuitée hôtel', 80.00),
('rep', 'repas restaurant', 25.00);

-- --------------------------------------------------------

--
-- Structure de la table `lignefraisforfait`
--

CREATE TABLE IF NOT EXISTS `lignefraisforfait` (
  `idvisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `idfraisforfait` char(3) NOT NULL,
  `quantite` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lignefraisforfait`
--

INSERT INTO `lignefraisforfait` (`idvisiteur`, `mois`, `idfraisforfait`, `quantite`) VALUES
('a12', '201609', 'etp', 20),
('a12', '201609', 'km', 43),
('a12', '201609', 'nui', 100),
('a12', '201609', 'rep', 100),
('a12', '201610', 'etp', 0),
('a12', '201610', 'km', 0),
('a12', '201610', 'nui', 0),
('a12', '201610', 'rep', 0),
('a131', '201609', 'etp', 45),
('a131', '201609', 'km', 34),
('a131', '201609', 'nui', 500),
('a131', '201609', 'rep', 68),
('a17', '201609', 'etp', 122),
('a17', '201609', 'km', 8793),
('a17', '201609', 'nui', 100),
('a17', '201609', 'rep', 58),
('a55', '201609', 'etp', 0),
('a55', '201609', 'km', 0),
('a55', '201609', 'nui', 0),
('a55', '201609', 'rep', 0),
('a945', '201609', 'etp', 15),
('a945', '201609', 'km', 20),
('a945', '201609', 'nui', 35),
('a945', '201609', 'rep', 40),
('b16', '201609', 'etp', 20),
('b16', '201609', 'km', 50),
('b16', '201609', 'nui', 50),
('b16', '201609', 'rep', 40);

-- --------------------------------------------------------

--
-- Structure de la table `lignefraishorsforfait`
--

CREATE TABLE IF NOT EXISTS `lignefraishorsforfait` (
`id` int(11) NOT NULL,
  `idvisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lignefraishorsforfait`
--

INSERT INTO `lignefraishorsforfait` (`id`, `idvisiteur`, `mois`, `libelle`, `date`, `montant`) VALUES
(5, 'a17', '201609', 'exces de vitesse', '2016-09-04', 135.00),
(8, 'a945', '201609', 'exces de vitesse', '2016-09-03', 135.00),
(11, 'a945', '201609', 'test', '2016-08-31', 10.00),
(13, 'a945', '201609', 'exces de vitesse', '2016-09-03', 135.87),
(14, 'a131', '201609', 'cadeau', '2016-09-04', 135.87),
(15, 'a131', '201609', 'exces de vitesse', '2016-08-04', 232.00),
(16, 'a131', '201609', 'test', '2016-08-04', 100.00),
(17, 'a131', '201609', 'dejeuner pour investisseur', '2016-09-04', 90.00),
(20, 'a945', '201609', 'test', '2016-09-03', 232.00),
(21, 'a945', '201609', 'abcd', '2016-07-09', 30.00),
(25, 'a17', '201609', 'dejeuner pour investisseur', '2016-08-04', 20.00),
(39, 'a12', '201609', 'Dejeuner pour investisseur', '2016-09-26', 232.00),
(40, 'a12', '201609', 'Test', '2016-09-09', 135.00),
(41, 'a131', '201609', 'Exces de vitesse', '0000-00-00', 232.00),
(42, 'a17', '201609', 'Essence', '2016-08-12', 65.00);

-- --------------------------------------------------------

--
-- Structure de la table `typecompte`
--

CREATE TABLE IF NOT EXISTS `typecompte` (
`id` int(11) NOT NULL,
  `type` char(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `typecompte`
--

INSERT INTO `typecompte` (`id`, `type`) VALUES
(1, 'Visiteur'),
(2, 'Comptable');

-- --------------------------------------------------------

--
-- Structure de la table `visiteur`
--

CREATE TABLE IF NOT EXISTS `visiteur` (
  `id` char(4) NOT NULL,
  `nom` char(30) DEFAULT NULL,
  `prenom` char(30) DEFAULT NULL,
  `login` char(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `mdp` varchar(50) DEFAULT NULL,
  `adresse` char(30) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` char(30) DEFAULT NULL,
  `dateembauche` date DEFAULT NULL,
  `typecompte` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `visiteur`
--

INSERT INTO `visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateembauche`, `typecompte`) VALUES
('a12', 'Traore', 'Adama', 'atraore', '123', '43 rue des couronnes', '75020', 'paris', '2015-09-22', 2),
('a131', 'Villechalane', 'Louis', 'lvillachane', 'jux7g', '8 rue des charmes', '46000', 'cahors', '2005-12-21', 1),
('a17', 'Andre', 'David', 'dandre', 'oppg5', '1 rue petit', '46200', 'lalbenque', '1998-11-23', 1),
('a55', 'Bedos', 'Christian', 'cbedos', 'gmhxd', '1 rue peranud', '46250', 'montcuq', '1995-01-12', 1),
('a93', 'Tusseau', 'Louis', 'ltusseau', 'ktp3s', '22 rue des ternes', '46123', 'gramat', '2000-05-01', 1),
('a945', 'Manzola', 'Gael', 'gmanzola', 'test', '11 rue danton', '94270', 'kremlin-bicetre', '2016-01-01', 2),
('b13', 'Bentot', 'Pascal', 'pbentot', 'doyw1', '11 allée des cerises', '46512', 'bessines', '1992-07-09', 1),
('b16', 'Bioret', 'Luc', 'lbioret', 'hrjfs', '1 avenue gambetta', '46000', 'cahors', '1998-05-11', 1),
('b19', 'Bunisset', 'Francis', 'fbunisset', '4vbnd', '10 rue des perles', '93100', 'montreuil', '1987-10-21', 1),
('b25', 'Bunisset', 'Denise', 'dbunisset', 's1y1r', '23 rue manin', '75019', 'paris', '2010-12-05', 1),
('b28', 'Cacheux', 'Bernard', 'bcacheux', 'uf7r3', '114 rue blanche', '75017', 'paris', '2009-11-12', 1),
('b34', 'Cadic', 'Eric', 'ecadic', '6u8dc', '123 avenue de la république', '75011', 'paris', '2008-09-23', 1),
('b4', 'Charoze', 'Catherine', 'ccharoze', 'u817o', '100 rue petit', '75019', 'paris', '2005-11-12', 1),
('b50', 'Clepkens', 'Christophe', 'cclepkens', 'bw1us', '12 allée des anges', '93230', 'romainville', '2003-08-11', 1),
('b59', 'Cottin', 'Vincenne', 'vcottin', '2hoh9', '36 rue des roches', '93100', 'monteuil', '2001-11-18', 1),
('c14', 'Daburon', 'François', 'fdaburon', '7oqpv', '13 rue de chanzy', '94000', 'créteil', '2002-02-11', 1),
('c3', 'De', 'Philippe', 'pde', 'gk9kx', '13 rue barthes', '94000', 'créteil', '2010-12-14', 1),
('c54', 'Debelle', 'Michel', 'mdebelle', 'od5rt', '181 avenue barbusse', '93210', 'rosny', '2006-11-23', 1),
('d13', 'Debelle', 'Jeanne', 'jdebelle', 'nvwqq', '134 allée des joncs', '44000', 'nantes', '2000-05-11', 1),
('d51', 'Debroise', 'Michel', 'mdebroise', 'sghkb', '2 bld jourdain', '44000', 'nantes', '2001-04-17', 1),
('e22', 'Desmarquest', 'Nathalie', 'ndesmarquest', 'f1fob', '14 place d arc', '45000', 'orléans', '2005-11-12', 1),
('e24', 'Desnost', 'Pierre', 'pdesnost', '4k2o5', '16 avenue des cèdres', '23200', 'guéret', '2001-02-05', 1),
('e39', 'Dudouit', 'Frédéric', 'fdudouit', '44im8', '18 rue de l église', '23120', 'grandbourg', '2000-08-01', 1),
('e49', 'Duncombe', 'Claude', 'cduncombe', 'qf77j', '19 rue de la tour', '23100', 'la souteraine', '1987-10-10', 1),
('e5', 'Enault-pascreau', 'Céline', 'cenault', 'y2qdu', '25 place de la gare', '23200', 'gueret', '1995-09-01', 1),
('e52', 'Eynde', 'Valérie', 'veynde', 'i7sn3', '3 grand place', '13015', 'marseille', '1999-11-01', 1),
('f21', 'Finck', 'Jacques', 'jfinck', 'mpb3t', '10 avenue du prado', '13002', 'marseille', '2001-11-10', 1),
('f39', 'Frémont', 'Fernande', 'ffremont', 'xs5tq', '4 route de la mer', '13012', 'allauh', '1998-10-01', 1),
('f4', 'Gest', 'Alain', 'agest', 'dywvt', '30 avenue de la mer', '13025', 'berre', '1985-11-01', 1);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `etat`
--
ALTER TABLE `etat`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `fichefrais`
--
ALTER TABLE `fichefrais`
 ADD PRIMARY KEY (`idvisiteur`,`mois`), ADD KEY `idetat` (`idetat`);

--
-- Index pour la table `fraisforfait`
--
ALTER TABLE `fraisforfait`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lignefraisforfait`
--
ALTER TABLE `lignefraisforfait`
 ADD PRIMARY KEY (`idvisiteur`,`mois`,`idfraisforfait`), ADD KEY `idfraisforfait` (`idfraisforfait`);

--
-- Index pour la table `lignefraishorsforfait`
--
ALTER TABLE `lignefraishorsforfait`
 ADD PRIMARY KEY (`id`), ADD KEY `idvisiteur` (`idvisiteur`,`mois`);

--
-- Index pour la table `typecompte`
--
ALTER TABLE `typecompte`
 ADD PRIMARY KEY (`id`);

--
-- Index pour la table `visiteur`
--
ALTER TABLE `visiteur`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `login` (`login`), ADD KEY `fk_visiteur_typecompte` (`typecompte`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `lignefraishorsforfait`
--
ALTER TABLE `lignefraishorsforfait`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT pour la table `typecompte`
--
ALTER TABLE `typecompte`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `fichefrais`
--
ALTER TABLE `fichefrais`
ADD CONSTRAINT `fichefrais_ibfk_1` FOREIGN KEY (`idetat`) REFERENCES `etat` (`id`),
ADD CONSTRAINT `fichefrais_ibfk_2` FOREIGN KEY (`idvisiteur`) REFERENCES `visiteur` (`id`);

--
-- Contraintes pour la table `lignefraisforfait`
--
ALTER TABLE `lignefraisforfait`
ADD CONSTRAINT `lignefraisforfait_ibfk_1` FOREIGN KEY (`idvisiteur`, `mois`) REFERENCES `fichefrais` (`idvisiteur`, `mois`),
ADD CONSTRAINT `lignefraisforfait_ibfk_2` FOREIGN KEY (`idfraisforfait`) REFERENCES `fraisforfait` (`id`);

--
-- Contraintes pour la table `lignefraishorsforfait`
--
ALTER TABLE `lignefraishorsforfait`
ADD CONSTRAINT `lignefraishorsforfait_ibfk_1` FOREIGN KEY (`idvisiteur`, `mois`) REFERENCES `fichefrais` (`idvisiteur`, `mois`);

--
-- Contraintes pour la table `visiteur`
--
ALTER TABLE `visiteur`
ADD CONSTRAINT `fk_visiteur_typecompte` FOREIGN KEY (`typecompte`) REFERENCES `typecompte` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
