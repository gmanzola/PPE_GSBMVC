-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Sam 12 Novembre 2016 à 00:31
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
('at', 'En attente'),
('cl', 'saisie clôturée'),
('cr', 'fiche créée, saisie en cours'),
('mp', 'mise en paiement'),
('rb', 'remboursée'),
('rf', 'refusé'),
('rp', 'reporté'),
('va', 'validée');

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
('a12', '201609', 0, 0.00, '2016-11-08', 'va'),
('a131', '201609', 0, 12165.20, '2016-11-08', 'mp'),
('a131', '201610', 0, 2670.20, '2016-11-08', 'cl'),
('a131', '201611', 0, 0.00, '2016-11-08', 'cr'),
('a17', '201609', 0, 28053.98, '2016-11-08', 'mp'),
('a17', '201610', 0, 6291.20, '2016-11-10', 'va'),
('a17', '201611', 0, 0.00, '2016-11-08', 'cr'),
('a55', '201609', 0, 7121.60, '2016-11-08', 'mp'),
('a55', '201610', 0, 0.00, '2016-11-08', 'cl'),
('a55', '201611', 0, 0.00, '2016-11-08', 'cr'),
('a945', '201609', 0, 0.00, '2016-11-08', 'cl'),
('b13', '201610', 0, 0.00, '2016-11-08', 'cl'),
('b13', '201611', 0, 0.00, '2016-11-08', 'cr'),
('b13', '201612', 0, 0.00, '2016-11-08', 'cr'),
('b16', '201609', 0, 0.00, '2016-11-08', 'cl'),
('b16', '201611', 0, 0.00, '2016-11-08', 'cr'),
('b4', '201609', 0, 9240.00, '2016-11-08', 'va'),
('b4', '201610', 0, 0.00, '2016-11-08', 'cl');

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
('km1', 'frais kilométrique', 0.52),
('km2', 'frais kilométrique', 0.58),
('km3', 'frais kilométrique', 0.67),
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
('a131', '201609', 'etp', 50),
('a131', '201609', 'km', 10),
('a131', '201609', 'nui', 43),
('a131', '201609', 'rep', 76),
('a131', '201610', 'etp', 5),
('a131', '201610', 'km', 10),
('a131', '201610', 'nui', 15),
('a131', '201610', 'rep', 20),
('a131', '201611', 'etp', 10),
('a131', '201611', 'km', 12),
('a131', '201611', 'nui', 5),
('a131', '201611', 'rep', 3),
('a17', '201609', 'etp', 122),
('a17', '201609', 'km', 879),
('a17', '201609', 'nui', 100),
('a17', '201609', 'rep', 58),
('a17', '201610', 'etp', 50),
('a17', '201610', 'km', 10),
('a17', '201610', 'nui', 5),
('a17', '201610', 'rep', 12),
('a17', '201611', 'etp', 0),
('a17', '201611', 'km', 0),
('a17', '201611', 'nui', 0),
('a17', '201611', 'rep', 0),
('a55', '201609', 'etp', 10),
('a55', '201609', 'km', 30),
('a55', '201609', 'nui', 40),
('a55', '201609', 'rep', 32),
('a55', '201610', 'etp', 0),
('a55', '201610', 'km', 0),
('a55', '201610', 'nui', 0),
('a55', '201610', 'rep', 0),
('a55', '201611', 'etp', 0),
('a55', '201611', 'km', 0),
('a55', '201611', 'nui', 0),
('a55', '201611', 'rep', 0),
('a945', '201609', 'etp', 15),
('a945', '201609', 'km', 20),
('a945', '201609', 'nui', 35),
('a945', '201609', 'rep', 40),
('b13', '201610', 'etp', 5),
('b13', '201610', 'km', 5),
('b13', '201610', 'nui', 2),
('b13', '201610', 'rep', 3),
('b13', '201611', 'etp', 0),
('b13', '201611', 'km', 0),
('b13', '201611', 'nui', 0),
('b13', '201611', 'rep', 0),
('b13', '201612', 'etp', 0),
('b13', '201612', 'km', 0),
('b13', '201612', 'nui', 0),
('b13', '201612', 'rep', 0),
('b16', '201609', 'etp', 20),
('b16', '201609', 'km', 50),
('b16', '201609', 'nui', 49),
('b16', '201609', 'rep', 40),
('b16', '201611', 'etp', 0),
('b16', '201611', 'km', 0),
('b16', '201611', 'nui', 0),
('b16', '201611', 'rep', 0),
('b4', '201609', 'etp', 50),
('b4', '201609', 'km', 200),
('b4', '201609', 'nui', 9),
('b4', '201609', 'rep', 13),
('b4', '201610', 'etp', 0),
('b4', '201610', 'km', 0),
('b4', '201610', 'nui', 0),
('b4', '201610', 'rep', 0);

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
  `montant` decimal(10,2) DEFAULT NULL,
  `etat` char(2) NOT NULL DEFAULT 'ea'
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lignefraishorsforfait`
--

INSERT INTO `lignefraishorsforfait` (`id`, `idvisiteur`, `mois`, `libelle`, `date`, `montant`, `etat`) VALUES
(25, 'a17', '201609', 'Achat costume pour RDV', '2016-08-04', 20.00, 'va'),
(39, 'a12', '201609', 'Dejeuner pour investisseur', '2016-09-26', 232.00, 'at'),
(48, 'a55', '201609', 'Repas avec client', '2016-09-05', 99.00, 'va'),
(50, 'b4', '201609', 'Repas avec client', '2016-09-06', 17.00, 'va'),
(53, 'a12', '201609', 'voyage sncf', '2016-09-19', 56.00, 'at'),
(54, 'a12', '201609', 'achat de matériel de papèterie', '2016-09-19', 17.00, 'at'),
(55, 'a12', '201609', 'voyage sncf', '2016-09-22', 64.00, 'at'),
(57, 'a131', '201610', 'location équipement vidéo/sonore', '2016-09-14', 414.00, 'va'),
(58, 'a131', '201609', '« REFUSE » frais vestimentaire/représentation', '2016-09-01', 275.00, 'rf'),
(59, 'a131', '201609', '« REFUSE » rémunération intervenant/spécialiste', '2016-09-23', 923.00, 'rf'),
(60, 'a17', '201609', '« REFUSE » taxi', '2016-09-28', 28.00, 'rf'),
(61, 'a17', '201610', 'repas avec praticien', '2016-09-13', 44.00, 'va'),
(62, 'a17', '201610', 'taxi', '2016-09-16', 41.00, 'va'),
(63, 'a17', '201609', 'location salle conférence', '2016-09-01', 121.00, 'va'),
(64, 'a17', '201609', 'location équipement vidéo/sonore', '2016-09-09', 667.00, 'va'),
(65, 'a17', '201609', 'frais vestimentaire/représentation', '2016-09-25', 370.00, 'va'),
(66, 'a55', '201609', 'location véhicule', '2016-09-12', 390.00, 'va'),
(67, 'a55', '201609', 'frais vestimentaire/représentation', '2016-09-01', 171.00, 'va'),
(68, 'a55', '201609', 'traiteur, alimentation, boisson', '2016-09-26', 91.00, 'va'),
(69, 'a945', '201609', 'frais vestimentaire/représentation', '2016-09-06', 155.00, 'at'),
(70, 'a945', '201609', 'repas avec praticien', '2016-09-10', 33.00, 'at'),
(71, 'a945', '201609', 'location véhicule', '2016-09-28', 49.00, 'at'),
(72, 'b16', '201609', 'frais vestimentaire/représentation', '2016-09-04', 182.00, 'at'),
(73, 'b16', '201609', 'taxi', '2016-09-01', 64.00, 'at'),
(74, 'b16', '201609', 'traiteur, alimentation, boisson', '2016-09-19', 342.00, 'at'),
(75, 'b16', '201609', 'location équipement vidéo/sonore', '2016-09-16', 583.00, 'at'),
(76, 'b16', '201609', 'repas avec praticien', '2016-09-14', 40.00, 'at'),
(77, 'b4', '201609', 'location équipement vidéo/sonore', '2016-09-10', 586.00, 'va'),
(78, 'a12', '201609', 'frais vestimentaire/représentation', '2016-09-18', 132.00, 'at'),
(80, 'a131', '201610', 'location salle conférence', '2016-09-25', 333.00, 'rp'),
(81, 'a17', '201609', 'voyage sncf', '2016-09-13', 90.00, 'va'),
(82, 'a17', '201609', 'frais vestimentaire/représentation', '2016-09-02', 141.00, 'va'),
(83, 'a17', '201609', 'voyage sncf', '2016-09-01', 50.00, 'va'),
(84, 'a55', '201609', 'achat de matériel de papèterie', '2016-09-05', 12.00, 'va'),
(85, 'a55', '201609', 'voyage sncf', '2016-09-03', 79.00, 'va'),
(86, 'a55', '201609', 'achat de matériel de papèterie', '2016-09-16', 20.00, 'va'),
(87, 'a945', '201609', 'taxi', '2016-09-22', 69.00, 'at'),
(88, 'b16', '201609', 'taxi', '2016-09-26', 67.00, 'at'),
(89, 'b16', '201609', 'traiteur, alimentation, boisson', '2016-09-22', 99.00, 'at'),
(90, 'b16', '201609', 'frais vestimentaire/représentation', '2016-09-08', 303.00, 'at'),
(91, 'b4', '201609', 'traiteur, alimentation, boisson', '2016-09-14', 254.00, 'va'),
(92, 'b4', '201609', 'repas avec praticien', '2016-09-15', 44.00, 'va'),
(93, 'b4', '201609', '« REFUSE » voyage sncf', '2016-09-16', 130.00, 'rf'),
(94, 'a12', '201609', 'repas avec praticien', '2016-09-11', 48.00, 'at'),
(95, 'a12', '201609', 'voyage sncf', '2016-09-23', 148.00, 'at'),
(96, 'a12', '201609', 'achat de matériel de papèterie', '2016-09-12', 18.00, 'at'),
(97, 'a12', '201609', 'traiteur, alimentation, boisson', '2016-09-13', 69.00, 'at'),
(98, 'a131', '201609', 'location salle conférence', '2016-09-21', 153.00, 'va'),
(100, 'a131', '201609', 'traiteur, alimentation, boisson', '2016-09-19', 425.00, 'va'),
(101, 'a17', '201609', 'location équipement vidéo/sonore', '2016-09-09', 749.00, 'va'),
(102, 'a17', '201609', 'taxi', '2016-09-25', 78.00, 'va'),
(103, 'a55', '201610', 'location équipement vidéo/sonore', '2016-09-15', 271.00, 'rp'),
(104, 'a55', '201610', 'location équipement vidéo/sonore', '2016-09-21', 356.00, 'rp'),
(105, 'a945', '201609', 'frais vestimentaire/représentation', '2016-09-18', 374.00, 'at'),
(106, 'a945', '201609', 'location salle conférence', '2016-09-20', 252.00, 'at'),
(107, 'b16', '201609', 'voyage sncf', '2016-09-26', 83.00, 'at'),
(108, 'b4', '201610', 'location salle conférence', '2016-09-16', 415.00, 'rp'),
(109, 'a12', '201609', 'repas avec praticien', '2016-09-09', 50.00, 'at'),
(110, 'a12', '201609', 'achat de matériel de papèterie', '2016-09-21', 48.00, 'at'),
(111, 'a12', '201609', 'traiteur, alimentation, boisson', '2016-09-17', 450.00, 'at'),
(112, 'a131', '201609', 'location véhicule', '2016-09-01', 159.00, 'va'),
(113, 'a131', '201609', '« REFUSE » : taxi', '2016-09-05', 52.00, 'rf'),
(114, 'a131', '201609', '« REFUSE » repas avec praticien', '2016-09-09', 43.00, 'rf'),
(115, 'a17', '201609', 'location équipement vidéo/sonore', '2016-09-05', 679.00, 'va'),
(116, 'a17', '201609', 'location salle conférence', '2016-09-14', 586.00, 'va'),
(117, 'a17', '201609', 'repas avec praticien', '2016-09-11', 47.00, 'va'),
(118, 'a55', '201610', 'taxi', '2016-09-18', 43.00, 'rp'),
(119, 'a55', '201610', 'voyage sncf', '2016-09-16', 97.00, 'rp'),
(120, 'a55', '201610', 'taxi', '2016-09-16', 26.00, 'rp'),
(121, 'a55', '201609', '« REFUSE » location véhicule', '2016-09-11', 240.00, 'rf'),
(122, 'a945', '201609', 'voyage sncf', '2016-09-20', 99.00, 'at'),
(123, 'b16', '201609', 'traiteur, alimentation, boisson', '2016-09-28', 170.00, 'at'),
(124, 'b16', '201609', 'frais vestimentaire/représentation', '2016-09-22', 77.00, 'at'),
(125, 'b16', '201609', 'achat de matériel de papèterie', '2016-09-18', 30.00, 'at'),
(126, 'b16', '201609', 'traiteur, alimentation, boisson', '2016-09-13', 250.00, 'at'),
(127, 'b16', '201609', 'frais vestimentaire/représentation', '2016-09-19', 105.00, 'at'),
(128, 'b4', '201610', 'location équipement vidéo/sonore', '2016-09-25', 233.00, 'rp'),
(129, 'a12', '201609', 'traiteur, alimentation, boisson', '2016-09-02', 360.00, 'at'),
(130, 'a12', '201609', 'traiteur, alimentation, boisson', '2016-09-14', 41.00, 'at'),
(131, 'a12', '201609', 'voyage sncf', '2016-09-06', 65.00, 'at'),
(132, 'a131', '201609', 'frais vestimentaire/représentation', '2016-09-11', 152.00, 'va'),
(134, 'a131', '201609', '« REFUSE » : voyage sncf', '2016-09-02', 33.00, 'rf'),
(135, 'a17', '201609', 'location équipement vidéo/sonore', '2016-09-21', 817.00, 'va'),
(136, 'a17', '201609', 'voyage sncf', '2016-09-19', 109.00, 'va'),
(137, 'a55', '201609', '« REFUSE » rémunération intervenant/spécialiste', '2016-09-27', 702.00, 'rf'),
(138, 'a55', '201609', '« REFUSE » repas avec praticien', '2016-09-21', 31.00, 'rf'),
(139, 'a55', '201609', '« REFUSE » repas avec praticien', '2016-09-22', 43.00, 'rf'),
(140, 'a55', '201610', 'traiteur, alimentation, boisson', '2016-09-02', 63.00, 'va'),
(141, 'a55', '201609', 'location équipement vidéo/sonore', '2016-09-01', 527.00, 'va'),
(142, 'a945', '201609', 'frais vestimentaire/représentation', '2016-09-24', 414.00, 'at'),
(143, 'b16', '201609', 'location salle conférence', '2016-09-27', 578.00, 'at'),
(144, 'b16', '201609', 'location équipement vidéo/sonore', '2016-09-25', 578.00, 'at'),
(145, 'b16', '201609', 'voyage sncf', '2016-09-16', 45.00, 'at'),
(146, 'b16', '201609', 'achat de matériel de papèterie', '2016-09-06', 49.00, 'at'),
(147, 'b16', '201609', 'traiteur, alimentation, boisson', '2016-09-07', 403.00, 'at'),
(148, 'b16', '201609', 'rémunération intervenant/spécialiste', '2016-09-09', 827.00, 'at'),
(149, 'b4', '201609', '« REFUSE » location salle conférence', '2016-09-11', 587.00, 'rf'),
(150, 'b4', '201609', '« REFUSE » location salle conférence', '2016-09-27', 460.00, 'rf'),
(151, 'a12', '201609', 'location salle conférence', '2016-09-25', 182.00, 'at'),
(152, 'a12', '201609', 'repas avec praticien', '2016-09-07', 50.00, 'at'),
(153, 'a12', '201609', 'traiteur, alimentation, boisson', '2016-09-01', 344.00, 'at'),
(154, 'a131', '201609', 'location salle conférence', '2016-09-02', 430.00, 'va'),
(155, 'a17', '201609', 'traiteur, alimentation, boisson', '2016-09-04', 115.00, 'va'),
(156, 'a55', '201609', 'frais vestimentaire/représentation', '2016-09-26', 366.00, 'va'),
(157, 'a55', '201609', 'frais vestimentaire/représentation', '2016-09-03', 248.00, 'va'),
(158, 'a945', '201609', 'frais vestimentaire/représentation', '2016-09-13', 110.00, 'at'),
(159, 'a945', '201609', 'traiteur, alimentation, boisson', '2016-09-13', 429.00, 'at'),
(160, 'b16', '201609', 'location salle conférence', '2016-09-18', 142.00, 'at'),
(161, 'b16', '201609', 'location salle conférence', '2016-09-24', 479.00, 'at'),
(162, 'b16', '201609', 'voyage sncf', '2016-09-05', 91.00, 'at'),
(163, 'b16', '201609', 'frais vestimentaire/représentation', '2016-09-15', 91.00, 'at'),
(164, 'b4', '201609', 'taxi', '2016-09-06', 44.00, 'va'),
(165, 'b4', '201609', '« REFUSE » voyage sncf', '2016-09-02', 143.00, 'rf'),
(166, 'b4', '201609', 'rémunération intervenant/spécialiste', '2016-09-18', 596.00, 'va'),
(167, 'b4', '201609', 'rémunération intervenant/spécialiste', '2016-09-06', 1030.00, 'va'),
(168, 'a131', '201610', 'Cadeau', '2016-09-05', 17.00, 'rp'),
(169, 'b13', '201612', 'Exces de vitesse', '2016-09-26', 135.00, 'rp'),
(170, 'b13', '201610', 'Test', '2016-09-26', 20.00, 'at'),
(171, 'b13', '201610', 'Cadeau', '2016-09-09', 213.00, 'at'),
(172, 'b13', '201610', 'Dejeuner pour investisseur', '2016-10-01', 144.00, 'va');

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
-- Structure de la table `typevehicule`
--

CREATE TABLE IF NOT EXISTS `typevehicule` (
  `id` char(3) NOT NULL,
  `typevehicule` varchar(15) NOT NULL,
  `puissance` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `typevehicule`
--

INSERT INTO `typevehicule` (`id`, `typevehicule`, `puissance`) VALUES
('km', 'Essence', '4CV'),
('km1', 'Disel', '4CV'),
('km2', 'Diesel', '5/6CV'),
('km3', 'Essence', '5/6CV');

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
('a12', 'Traore', 'Adama', 'atraore', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '43 rue des couronnes', '75020', 'paris', '2015-09-22', 2),
('a131', 'Villechalane', 'Louis', 'lvillachane', '3abf9eb797afe468902101efe6b4b00f7d50802a', '8 rue des charmes', '46000', 'cahors', '2005-12-21', 1),
('a17', 'Andre', 'David', 'dandre', '12e0b9be32932a8028b0ef0432a0a0a99421f745', '1 rue petit', '46200', 'lalbenque', '1998-11-23', 1),
('a55', 'Bedos', 'Christian', 'cbedos', 'a34b9dfadee33917a63c3cdebdc9526230611f0b', '1 rue peranud', '46250', 'montcuq', '1995-01-12', 1),
('a93', 'Tusseau', 'Louis', 'ltusseau', 'f1c1d39e9898f3202a2eaa3dc38ae61575cd77ad', '22 rue des ternes', '46123', 'gramat', '2000-05-01', 1),
('a945', 'Manzola', 'Gael', 'gmanzola', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '11 rue danton', '94270', 'kremlin-bicetre', '2016-01-01', 2),
('b13', 'Bentot', 'Pascal', 'pbentot', '178e1efaf000fdf2267edc43fad2a65197a0ab10', '11 allée des cerises', '46512', 'bessines', '1992-07-09', 1),
('b16', 'Bioret', 'Luc', 'lbioret', 'ab7fa51f9bf8fde35d9e5bcc5066d3b71dda00d2', '1 avenue gambetta', '46000', 'cahors', '1998-05-11', 1),
('b19', 'Bunisset', 'Francis', 'fbunisset', 'aa710ca3a1f12234bc2872aa0a6f88d6cf896ae4', '10 rue des perles', '93100', 'montreuil', '1987-10-21', 1),
('b25', 'Bunisset', 'Denise', 'dbunisset', '40ff56dc0525aa08de29eba96271997a91e7d405', '23 rue manin', '75019', 'paris', '2010-12-05', 1),
('b28', 'Cacheux', 'Bernard', 'bcacheux', '51a4fac4890def1ef8605f0b2e6554c86b2eb919', '114 rue blanche', '75017', 'paris', '2009-11-12', 1),
('b34', 'Cadic', 'Eric', 'ecadic', '2ed5ee95d2588be3650a935ff7687dee46d70fc8', '123 avenue de la république', '75011', 'paris', '2008-09-23', 1),
('b4', 'Charoze', 'Catherine', 'ccharoze', '8b16cf71ab0842bd871bce99a1ba61dd7e9d4423', '100 rue petit', '75019', 'paris', '2005-11-12', 1),
('b50', 'Clepkens', 'Christophe', 'cclepkens', '7ddda57eca7a823c85ac0441adf56928b47ece76', '12 allée des anges', '93230', 'romainville', '2003-08-11', 1),
('b59', 'Cottin', 'Vincenne', 'vcottin', '2f95d1cac7b8e7459376bf36b93ae7333026282d', '36 rue des roches', '93100', 'monteuil', '2001-11-18', 1),
('c14', 'Daburon', 'François', 'fdaburon', '5c7cc4a7f0123460c29c84d8f8a73bc86184adbb', '13 rue de chanzy', '94000', 'créteil', '2002-02-11', 1),
('c3', 'De', 'Philippe', 'pde', '03b03872dd570959311f4fb9be01788e4d1a2abf', '13 rue barthes', '94000', 'créteil', '2010-12-14', 1),
('c54', 'Debelle', 'Michel', 'mdebelle', '1fa95c2fac5b14c6386b73cbe958b663fc66fdfa', '181 avenue barbusse', '93210', 'rosny', '2006-11-23', 1),
('d13', 'Debelle', 'Jeanne', 'jdebelle', '18c2cad6adb7cee7884f70108cfd0a9b448be9be', '134 allée des joncs', '44000', 'nantes', '2000-05-11', 1),
('d51', 'Debroise', 'Michel', 'mdebroise', '46b609fe3aaa708f5606469b5bc1c0fa85010d76', '2 bld jourdain', '44000', 'nantes', '2001-04-17', 1),
('e22', 'Desmarquest', 'Nathalie', 'ndesmarquest', 'abc20ea01dabd079ddd63fd9006e7232e442973c', '14 place d arc', '45000', 'orléans', '2005-11-12', 1),
('e24', 'Desnost', 'Pierre', 'pdesnost', '8eaa8011ec8aa8baa63231a21d12f4138ccc1a3d', '16 avenue des cèdres', '23200', 'guéret', '2001-02-05', 1),
('e39', 'Dudouit', 'Frédéric', 'fdudouit', '55072fa16c988da8f1fb31e40e4ac5f325ac145d', '18 rue de l église', '23120', 'grandbourg', '2000-08-01', 1),
('e49', 'Duncombe', 'Claude', 'cduncombe', '577576f0b2c56c43b596f701b782870c8742c592', '19 rue de la tour', '23100', 'la souteraine', '1987-10-10', 1),
('e5', 'Enault-pascreau', 'Céline', 'cenault', 'cc0fb4115bb04c613fd1b95f4792fc44f07e9f4f', '25 place de la gare', '23200', 'gueret', '1995-09-01', 1),
('e52', 'Eynde', 'Valérie', 'veynde', 'd06ace8d729693904c304625e6a6fab6ab9e9746', '3 grand place', '13015', 'marseille', '1999-11-01', 1),
('f21', 'Finck', 'Jacques', 'jfinck', '6d8b2060b60132d9bdb09d37913fbef637b295f2', '10 avenue du prado', '13002', 'marseille', '2001-11-10', 1),
('f39', 'Frémont', 'Fernande', 'ffremont', 'aa45efe9ecbf37db0089beeedea62ceb57db7f17', '4 route de la mer', '13012', 'allauh', '1998-10-01', 1),
('f4', 'Gest', 'Alain', 'agest', '1af7dedacbbe8ce324e316429a816daeff4c542f', '30 avenue de la mer', '13025', 'berre', '1985-11-01', 1);

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
-- Index pour la table `typevehicule`
--
ALTER TABLE `typevehicule`
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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=173;
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
-- Contraintes pour la table `typevehicule`
--
ALTER TABLE `typevehicule`
ADD CONSTRAINT `typevehicule_ibfk_1` FOREIGN KEY (`id`) REFERENCES `fraisforfait` (`id`);

--
-- Contraintes pour la table `visiteur`
--
ALTER TABLE `visiteur`
ADD CONSTRAINT `fk_visiteur_typecompte` FOREIGN KEY (`typecompte`) REFERENCES `typecompte` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
