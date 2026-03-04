-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 03 mars 2026 à 13:14
-- Version du serveur : 11.8.3-MariaDB-0+deb13u1 from Debian
-- Version de PHP : 8.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pizzapinos`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `login` varchar(100) NOT NULL,
  `mdp` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id`, `login`, `mdp`) VALUES
(1, 'admin', 'a48622b535728587fd351763d1296c7ec9cb5bc6743d5f22b011d5b5c3ef688f');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `ID_commande` int(11) NOT NULL,
  `nom_prenom` varchar(100) NOT NULL,
  `date_heure` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`ID_commande`, `nom_prenom`, `date_heure`) VALUES
(4, 'david bikalou', '2026-02-28 20:37:36'),
(6, 'rayan boo', '2026-02-28 20:45:34');

-- --------------------------------------------------------

--
-- Structure de la table `commandes_pizzas`
--

CREATE TABLE `commandes_pizzas` (
  `ID_commande` int(100) NOT NULL,
  `ID_pizza` int(100) NOT NULL,
  `quantite` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `commandes_pizzas`
--

INSERT INTO `commandes_pizzas` (`ID_commande`, `ID_pizza`, `quantite`) VALUES
(4, 1, 2),
(4, 3, 1),
(6, 7, 2),
(6, 5, 1);

-- --------------------------------------------------------

--
-- Structure de la table `pizzas`
--

CREATE TABLE `pizzas` (
  `ID` int(11) NOT NULL,
  `ingrédient` text NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `pizzas`
--

INSERT INTO `pizzas` (`ID`, `ingrédient`, `prix`, `nom`, `image`) VALUES
(1, 'Tomate, mozzarella, basilic', 8.50, 'Marguerita', 'margherita.jpg'),
(2, 'Base crème fraîche, Fromage de chèvre, Figues fraîches, Miel, Roquette, Noix', 12.50, 'Figues & Chèvre', 'Figues.jpg'),
(3, 'Base crème citronnée, Saumon fumé, Avocat en tranches, Oignon rouge, Aneth, Zeste de citron', 12.50, 'Saumon & Avocat', 'Saumon.jpg'),
(4, 'Base sauce tomate, Poulet mariné tandoori, Poivrons, Oignon rouge, Mozzarella, Coriandre fraîche', 12.50, 'Poulet Tandoori', 'Tandoori.jpg'),
(5, 'Base crème, Gorgonzola, Poires en fines tranches, Noix, Miel, Roquette', 8.50, 'Poire & Gorgonzola', 'Gorgonzola.jpg'),
(6, 'Base sauce burger, Bœuf haché, Cheddar, Cornichons, Oignon émincé, Graines de sésame', 15.00, 'Burger', 'Burger.jpg'),
(7, 'Base crème, Lardons, Mozzarella, Jaune d’œuf, Parmesan râpé, Poivre noir', 12.50, 'Carbonara', 'Carbonara.jpg'),
(8, 'Base sauce cacahuète, Poulet grillé, Carottes râpées, Poivrons, Coriandre fraîche, Cacahuètes concassées', 15.00, 'Thaï Poulet & Cacahuète', 'Thaï-Poulet.jpg'),
(9, 'Base sucrée, Chocolat fondu, Rondelles de banane, Noisettes concassées, Sucre glace', 6.00, 'Chocolat & Banane', 'Chocolat-Banane.jpg'),
(10, 'Base mystère , Viande mystère qualité A5', 20.00, 'SPECIALE D&E', 'Mystère.jpg');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`ID_commande`);

--
-- Index pour la table `commandes_pizzas`
--
ALTER TABLE `commandes_pizzas`
  ADD KEY `ID_commande` (`ID_commande`,`ID_pizza`),
  ADD KEY `ID_pizza` (`ID_pizza`);

--
-- Index pour la table `pizzas`
--
ALTER TABLE `pizzas`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `ID_commande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `pizzas`
--
ALTER TABLE `pizzas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commandes_pizzas`
--
ALTER TABLE `commandes_pizzas`
  ADD CONSTRAINT `commandes_pizzas_ibfk_1` FOREIGN KEY (`ID_pizza`) REFERENCES `pizzas` (`ID`),
  ADD CONSTRAINT `commandes_pizzas_ibfk_2` FOREIGN KEY (`ID_commande`) REFERENCES `commandes` (`ID_commande`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
