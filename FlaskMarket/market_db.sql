-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 26-Jun-2021 às 22:41
-- Versão do servidor: 10.4.19-MariaDB
-- versão do PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `market`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `buy`
--

CREATE TABLE `buy` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id_item` int(10) UNSIGNED NOT NULL,
  `fk_id_user` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `items`
--

CREATE TABLE `items` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `barcode` char(12) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `description` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `items`
--

INSERT INTO `items` (`id`, `name`, `barcode`, `price`, `description`) VALUES
(1, 'Keyboard', '1147483647', '200.00', ''),
(2, 'Romance Book', '1987589012', '20.00', 'This is a Romance book\r\n\r\n'),
(3, 'Pen', '2890764829', '1.00', 'Blue pen'),
(4, 'Black Mask', '1928304583', '5.45', 'Black mask\r\n'),
(5, 'Iphone', '8947236522', '1000.00', ''),
(6, 'Harry Potter - Book', '8947236522', '10.00', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(80) NOT NULL,
  `budget` decimal(7,2) NOT NULL DEFAULT 1000.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `budget`) VALUES
(1, 'oioi', 'Aaaaaaaaa11', 'teste@gmail.com', '0.00'),
(2, '20171010870304', 'Aaaaaaaaaa1', 'iagoago@jota.com', '0.00'),
(3, 'iago159aa', 'A1112121212aa', 'iago1591@hotmail.com', '0.00'),
(4, '06301462173a', 'Aaaa12121234a', 'josiasago31@gmail.com', '0.00'),
(5, '1212', 'Iago1234', 'email@dominio.com', '1000.00');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `buy`
--
ALTER TABLE `buy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_item` (`fk_id_item`),
  ADD KEY `fk_id_user` (`fk_id_user`);

--
-- Índices para tabela `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `buy`
--
ALTER TABLE `buy`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `items`
--
ALTER TABLE `items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `buy`
--
ALTER TABLE `buy`
  ADD CONSTRAINT `buy_ibfk_1` FOREIGN KEY (`fk_id_item`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `buy_ibfk_2` FOREIGN KEY (`fk_id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
