-- phpmyadmin sql dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- host: localhost:3306
-- generation time: sep 16, 2016 at 09:12 am
-- server version: 5.7.13-log
-- php version: 7.0.10

set sql_mode = "no_auto_value_on_zero";
set time_zone = "+00:00";


/*!40101 set @old_character_set_client=@@character_set_client */;
/*!40101 set @old_character_set_results=@@character_set_results */;
/*!40101 set @old_collation_connection=@@collation_connection */;
/*!40101 set names utf8mb4 */;

--
-- database: `gsbv2`
--

-- --------------------------------------------------------

--
-- table structure for table `etat`
--

create table `etat` (
  `id` char(2) not null,
  `libelle` varchar(30) default null
) engine=innodb default charset=latin1;

--
-- dumping data for table `etat`
--

insert into `etat` (`id`, `libelle`) values
('cl', 'saisie clôturée'),
('cr', 'fiche créée, saisie en cours'),
('rb', 'remboursée'),
('va', 'validée et mise en paiement');

-- --------------------------------------------------------

--
-- table structure for table `fichefrais`
--

create table `fichefrais` (
  `idvisiteur` char(4) not null,
  `mois` char(6) not null,
  `nbjustificatifs` int(11) default null,
  `montantvalide` decimal(10,2) default null,
  `datemodif` date default null,
  `idetat` char(2) default 'cr'
) engine=innodb default charset=latin1;

--
-- dumping data for table `fichefrais`
--

insert into `fichefrais` (`idvisiteur`, `mois`, `nbjustificatifs`, `montantvalide`, `datemodif`, `idetat`) values
('a12', '201609', 0, '0.00', '2016-09-08', 'cr'),
('a131', '201609', 0, '0.00', '2016-09-08', 'cr'),
('a17', '201609', 0, '0.00', '2016-09-05', 'cr'),
('a55', '201609', 0, '0.00', '2016-09-05', 'cr'),
('a945', '201609', 0, '0.00', '2016-09-14', 'cr');

-- --------------------------------------------------------

--
-- table structure for table `fraisforfait`
--

create table `fraisforfait` (
  `id` char(3) not null,
  `libelle` char(20) default null,
  `montant` decimal(5,2) default null
) engine=innodb default charset=latin1;

--
-- dumping data for table `fraisforfait`
--

insert into `fraisforfait` (`id`, `libelle`, `montant`) values
('etp', 'forfait etape', '110.00'),
('km', 'frais kilométrique', '0.62'),
('nui', 'nuitée hôtel', '80.00'),
('rep', 'repas restaurant', '25.00');

-- --------------------------------------------------------

--
-- table structure for table `lignefraisforfait`
--

create table `lignefraisforfait` (
  `idvisiteur` char(4) not null,
  `mois` char(6) not null,
  `idfraisforfait` char(3) not null,
  `quantite` int(11) default null
) engine=innodb default charset=latin1;

--
-- dumping data for table `lignefraisforfait`
--

insert into `lignefraisforfait` (`idvisiteur`, `mois`, `idfraisforfait`, `quantite`) values
('a12', '201609', 'etp', 20),
('a12', '201609', 'km', 43),
('a12', '201609', 'nui', 342),
('a12', '201609', 'rep', 343),
('a131', '201609', 'etp', 45),
('a131', '201609', 'km', 34),
('a131', '201609', 'nui', 500),
('a131', '201609', 'rep', 5344),
('a17', '201609', 'etp', 122),
('a17', '201609', 'km', 8793),
('a17', '201609', 'nui', 132),
('a17', '201609', 'rep', 62),
('a55', '201609', 'etp', 0),
('a55', '201609', 'km', 0),
('a55', '201609', 'nui', 0),
('a55', '201609', 'rep', 0),
('a945', '201609', 'etp', 40),
('a945', '201609', 'km', 30),
('a945', '201609', 'nui', 34),
('a945', '201609', 'rep', 55);

-- --------------------------------------------------------

--
-- table structure for table `lignefraishorsforfait`
--

create table `lignefraishorsforfait` (
  `id` int(11) not null,
  `idvisiteur` char(4) not null,
  `mois` char(6) not null,
  `libelle` varchar(100) default null,
  `date` date default null,
  `montant` decimal(10,2) default null
) engine=innodb default charset=latin1;

--
-- dumping data for table `lignefraishorsforfait`
--

insert into `lignefraishorsforfait` (`id`, `idvisiteur`, `mois`, `libelle`, `date`, `montant`) values
(1, 'a17', '201609', 'nai', '2015-09-22', '23.00'),
(2, 'a17', '201609', 'bai', '2015-12-21', '199.00'),
(5, 'a17', '201609', 'exces de vitesse', '2016-09-04', '135.00'),
(7, 'a17', '201609', 'test', '2016-08-04', '135.00'),
(8, 'a945', '201609', 'exces de vitesse', '2016-09-03', '135.00'),
(11, 'a945', '201609', 'test', '2016-08-31', '10.00'),
(13, 'a945', '201609', 'exces de vitesse', '2016-09-03', '135.87'),
(14, 'a131', '201609', 'cadeau', '2016-09-04', '135.87'),
(15, 'a131', '201609', 'exces de vitesse', '2016-08-04', '232.00'),
(16, 'a131', '201609', 'test', '2016-08-04', '100.00'),
(17, 'a131', '201609', 'dejeuner pour investisseur', '2016-09-04', '90.00'),
(20, 'a945', '201609', 'test', '2016-09-03', '232.00'),
(21, 'a945', '201609', 'abcd', '2016-07-09', '30.00'),
(24, 'a17', '201609', 'maj', '2016-09-13', '232.00'),
(25, 'a17', '201609', 'dejeuner pour investisseur', '2016-08-04', '20.00');

-- --------------------------------------------------------

--
-- table structure for table `typecompte`
--

create table `typecompte` (
  `id` int(11) not null,
  `type` char(50) not null
) engine=innodb default charset=latin1;

--
-- dumping data for table `typecompte`
--

insert into `typecompte` (`id`, `type`) values
(1, 'visiteur'),
(2, 'comptable');

-- --------------------------------------------------------

--
-- table structure for table `visiteur`
--

create table `visiteur` (
  `id` char(4) not null,
  `nom` char(30) default null,
  `prenom` char(30) default null,
  `login` char(20) default null,
  `mdp` char(20) default null,
  `adresse` char(30) default null,
  `cp` char(5) default null,
  `ville` char(30) default null,
  `dateembauche` date default null,
  `typecompte` int(11) not null default '0'
) engine=innodb default charset=latin1;

--
-- dumping data for table `visiteur`
--

insert into `visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateembauche`, `typecompte`) values
('a12', 'adama', 'traore', 'atraore', '123', '43 rue des couronnes', '75020', 'paris', '2015-09-22', 2),
('a131', 'villechalane', 'louis', 'lvillachane', 'jux7g', '8 rue des charmes', '46000', 'cahors', '2005-12-21', 1),
('a17', 'andre', 'david', 'dandre', 'oppg5', '1 rue petit', '46200', 'lalbenque', '1998-11-23', 1),
('a55', 'bedos', 'christian', 'cbedos', 'gmhxd', '1 rue peranud', '46250', 'montcuq', '1995-01-12', 1),
('a93', 'tusseau', 'louis', 'ltusseau', 'ktp3s', '22 rue des ternes', '46123', 'gramat', '2000-05-01', 1),
('a945', 'manzola', 'gael', 'gmanzola', 'test', '11 rue danton', '94270', 'kremlin-bicetre', '2016-01-01', 2),
('b13', 'bentot', 'pascal', 'pbentot', 'doyw1', '11 allée des cerises', '46512', 'bessines', '1992-07-09', 1),
('b16', 'bioret', 'luc', 'lbioret', 'hrjfs', '1 avenue gambetta', '46000', 'cahors', '1998-05-11', 1),
('b19', 'bunisset', 'francis', 'fbunisset', '4vbnd', '10 rue des perles', '93100', 'montreuil', '1987-10-21', 1),
('b25', 'bunisset', 'denise', 'dbunisset', 's1y1r', '23 rue manin', '75019', 'paris', '2010-12-05', 1),
('b28', 'cacheux', 'bernard', 'bcacheux', 'uf7r3', '114 rue blanche', '75017', 'paris', '2009-11-12', 1),
('b34', 'cadic', 'eric', 'ecadic', '6u8dc', '123 avenue de la république', '75011', 'paris', '2008-09-23', 1),
('b4', 'charoze', 'catherine', 'ccharoze', 'u817o', '100 rue petit', '75019', 'paris', '2005-11-12', 1),
('b50', 'clepkens', 'christophe', 'cclepkens', 'bw1us', '12 allée des anges', '93230', 'romainville', '2003-08-11', 1),
('b59', 'cottin', 'vincenne', 'vcottin', '2hoh9', '36 rue des roches', '93100', 'monteuil', '2001-11-18', 1),
('c14', 'daburon', 'françois', 'fdaburon', '7oqpv', '13 rue de chanzy', '94000', 'créteil', '2002-02-11', 1),
('c3', 'de', 'philippe', 'pde', 'gk9kx', '13 rue barthes', '94000', 'créteil', '2010-12-14', 1),
('c54', 'debelle', 'michel', 'mdebelle', 'od5rt', '181 avenue barbusse', '93210', 'rosny', '2006-11-23', 1),
('d13', 'debelle', 'jeanne', 'jdebelle', 'nvwqq', '134 allée des joncs', '44000', 'nantes', '2000-05-11', 1),
('d51', 'debroise', 'michel', 'mdebroise', 'sghkb', '2 bld jourdain', '44000', 'nantes', '2001-04-17', 1),
('e22', 'desmarquest', 'nathalie', 'ndesmarquest', 'f1fob', '14 place d arc', '45000', 'orléans', '2005-11-12', 1),
('e24', 'desnost', 'pierre', 'pdesnost', '4k2o5', '16 avenue des cèdres', '23200', 'guéret', '2001-02-05', 1),
('e39', 'dudouit', 'frédéric', 'fdudouit', '44im8', '18 rue de l église', '23120', 'grandbourg', '2000-08-01', 1),
('e49', 'duncombe', 'claude', 'cduncombe', 'qf77j', '19 rue de la tour', '23100', 'la souteraine', '1987-10-10', 1),
('e5', 'enault-pascreau', 'céline', 'cenault', 'y2qdu', '25 place de la gare', '23200', 'gueret', '1995-09-01', 1),
('e52', 'eynde', 'valérie', 'veynde', 'i7sn3', '3 grand place', '13015', 'marseille', '1999-11-01', 1),
('f21', 'finck', 'jacques', 'jfinck', 'mpb3t', '10 avenue du prado', '13002', 'marseille', '2001-11-10', 1),
('f39', 'frémont', 'fernande', 'ffremont', 'xs5tq', '4 route de la mer', '13012', 'allauh', '1998-10-01', 1),
('f4', 'gest', 'alain', 'agest', 'dywvt', '30 avenue de la mer', '13025', 'berre', '1985-11-01', 1);

--
-- indexes for dumped tables
--

--
-- indexes for table `etat`
--
alter table `etat`
  add primary key (`id`);

--
-- indexes for table `fichefrais`
--
alter table `fichefrais`
  add primary key (`idvisiteur`,`mois`),
  add key `idetat` (`idetat`);

--
-- indexes for table `fraisforfait`
--
alter table `fraisforfait`
  add primary key (`id`);

--
-- indexes for table `lignefraisforfait`
--
alter table `lignefraisforfait`
  add primary key (`idvisiteur`,`mois`,`idfraisforfait`),
  add key `idfraisforfait` (`idfraisforfait`);

--
-- indexes for table `lignefraishorsforfait`
--
alter table `lignefraishorsforfait`
  add primary key (`id`),
  add key `idvisiteur` (`idvisiteur`,`mois`);

--
-- indexes for table `typecompte`
--
alter table `typecompte`
  add primary key (`id`);

--
-- indexes for table `visiteur`
--
alter table `visiteur`
  add primary key (`id`),
  add key `fk_visiteur_typecompte` (`typecompte`);

--
-- auto_increment for dumped tables
--

--
-- auto_increment for table `lignefraishorsforfait`
--
alter table `lignefraishorsforfait`
  modify `id` int(11) not null auto_increment, auto_increment=26;
--
-- auto_increment for table `typecompte`
--
alter table `typecompte`
  modify `id` int(11) not null auto_increment, auto_increment=3;
--
-- constraints for dumped tables
--

--
-- constraints for table `fichefrais`
--
alter table `fichefrais`
  add constraint `fichefrais_ibfk_1` foreign key (`idetat`) references `etat` (`id`),
  add constraint `fichefrais_ibfk_2` foreign key (`idvisiteur`) references `visiteur` (`id`);

--
-- constraints for table `lignefraisforfait`
--
alter table `lignefraisforfait`
  add constraint `lignefraisforfait_ibfk_1` foreign key (`idvisiteur`,`mois`) references `fichefrais` (`idvisiteur`, `mois`),
  add constraint `lignefraisforfait_ibfk_2` foreign key (`idfraisforfait`) references `fraisforfait` (`id`);

--
-- constraints for table `lignefraishorsforfait`
--
alter table `lignefraishorsforfait`
  add constraint `lignefraishorsforfait_ibfk_1` foreign key (`idvisiteur`,`mois`) references `fichefrais` (`idvisiteur`, `mois`);

--
-- constraints for table `visiteur`
--
alter table `visiteur`
  add constraint `fk_visiteur_typecompte` foreign key (`typecompte`) references `typecompte` (`id`);

/*!40101 set character_set_client=@old_character_set_client */;
/*!40101 set character_set_results=@old_character_set_results */;
/*!40101 set collation_connection=@old_collation_connection */;
