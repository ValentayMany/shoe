-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2025 at 01:56 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tuvsport_v3`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `Activity_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Activity_Type` varchar(50) NOT NULL,
  `Activity_Description` text DEFAULT NULL,
  `Related_ID` int(11) DEFAULT NULL,
  `IP_Address` varchar(45) DEFAULT NULL,
  `User_Agent` varchar(255) DEFAULT NULL,
  `Created_At` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `Address_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Address_line` varchar(255) NOT NULL,
  `Village` varchar(100) DEFAULT NULL,
  `District` varchar(100) DEFAULT NULL,
  `Province` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `Cart_ID` int(11) NOT NULL,
  `CID` varchar(20) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Size` varchar(20) DEFAULT NULL,
  `Color` varchar(30) DEFAULT NULL,
  `Quantity` int(11) NOT NULL DEFAULT 1,
  `Unit_Price` decimal(10,2) NOT NULL,
  `Added_at` datetime DEFAULT current_timestamp(),
  `Added_Date` datetime DEFAULT current_timestamp(),
  `Last_Modified` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`Cart_ID`, `CID`, `User_ID`, `Product_ID`, `Size`, `Color`, `Quantity`, `Unit_Price`, `Added_at`, `Added_Date`, `Last_Modified`) VALUES
(2, 'C250501', 1, 12, '32', 'purple', 2, 2500.00, '2025-05-09 23:53:34', '2025-05-09 23:53:34', '2025-05-09 23:53:34');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `Inventory_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Size` varchar(20) DEFAULT NULL,
  `Color` varchar(30) DEFAULT NULL,
  `Quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`Inventory_ID`, `Product_ID`, `Size`, `Color`, `Quantity`) VALUES
(1, 10, '42', 'red', 3),
(2, 8, '35', 'green', 2),
(3, 12, '42', 'purple', 4),
(4, 9, '43', 'red', 2),
(5, 7, '35', 'green', 3),
(6, 11, '43', 'red', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Order_ID` int(11) NOT NULL,
  `OID` varchar(255) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Address_ID` int(11) NOT NULL,
  `Payment_ID` varchar(50) DEFAULT NULL,
  `Shipment_ID` int(11) DEFAULT NULL,
  `Order_Date` datetime DEFAULT current_timestamp(),
  `Order_Status` varchar(20) NOT NULL,
  `Subtotal` decimal(10,2) NOT NULL,
  `Shipping_Fee` decimal(10,2) NOT NULL,
  `Tax` decimal(10,2) NOT NULL,
  `Discount` decimal(10,2) DEFAULT 0.00,
  `Total_Amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `Product_ID` int(11) NOT NULL,
  `PID` varchar(20) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Brand` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Description` text DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `productType_ID` int(11) NOT NULL,
  `Shop_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Product_ID`, `PID`, `Name`, `Brand`, `Price`, `Description`, `Status`, `Image`, `productType_ID`, `Shop_ID`) VALUES
(7, 'P001', 'Nike Air Zoom Pegasus', 'Nike', 2500.00, 'ເກີບແລ່ນມືອາຊີບ', 'ມີຂາຍ', 'nike_pegasus.jpg', 1, NULL),
(8, 'P002', 'Clarks Tilden Cap', 'Clarks', 1800.00, 'ເກີບເຮັດວຽກສຳລັບຊາຍ', 'ມີຂາຍ', 'clarks_tilden.jpg', 2, NULL),
(9, 'P003', 'Gucci Ace Sneaker', 'Gucci', 5500.00, 'ເກີບແຟຊັ່ນດັ່ງ', 'ສິ້ນສຸດ', 'gucci_ace.jpg', 3, NULL),
(10, 'P004', 'Adidas Adilette Slides', 'Adidas', 600.00, 'ເກີບໃສ່ທຸກມື້', 'ມີຂາຍ', 'adidas_slides.jpg', 1, NULL),
(11, 'P005', 'Timberland PRO Work Boots', 'Timberland', 3200.00, 'ເກີບສຳລັບການເຮັດວຽກ', 'ມີຂາຍ', 'timberland_pro.jpg', 5, NULL),
(12, 'P006', 'Cozy Home Slippers', 'Cozy', 400.00, 'ເກີບໃສ່ໃນເຮືອນ', 'ມີຂາຍ', 'cozy_home.jpg', 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

CREATE TABLE `product_types` (
  `productType_ID` int(11) NOT NULL,
  `productType_Name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_types`
--

INSERT INTO `product_types` (`productType_ID`, `productType_Name`) VALUES
(1, 'ເກີບກິລາ'),
(2, 'ເກີບເຮັດວຽກ\r\n'),
(3, 'ເກີບແຟຊັ່ນ'),
(4, 'ເກີບໃສ່ເຮືອນ'),
(5, 'ເກີບບູດ');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `Review_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Comment` text DEFAULT NULL,
  `Review_Date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `Role_id` int(11) NOT NULL,
  `Role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`Role_id`, `Role_name`) VALUES
(1, 'admin'),
(2, 'manager'),
(3, 'customer'),
(4, 'seller');

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

CREATE TABLE `shipment` (
  `Shipment_ID` int(11) NOT NULL,
  `Courier` varchar(50) NOT NULL,
  `Tracking_Number` varchar(50) NOT NULL,
  `Ship_Status` varchar(20) NOT NULL,
  `Ship_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `Shop_ID` int(11) NOT NULL,
  `SID` varchar(20) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Shop_Name` varchar(100) NOT NULL,
  `Description` text DEFAULT NULL,
  `Logo` varchar(255) DEFAULT NULL,
  `Banner` varchar(255) DEFAULT NULL,
  `Contact_Email` varchar(100) DEFAULT NULL,
  `Contact_Phone` varchar(20) DEFAULT NULL,
  `Status` varchar(20) NOT NULL DEFAULT 'active',
  `Created_At` datetime DEFAULT current_timestamp(),
  `Updated_At` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shop_applications`
--

CREATE TABLE `shop_applications` (
  `Application_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Shop_Name` varchar(100) NOT NULL,
  `Business_Type` varchar(50) NOT NULL,
  `Description` text DEFAULT NULL,
  `Contact_Email` varchar(100) NOT NULL,
  `Contact_Phone` varchar(20) NOT NULL,
  `ID_Card_Number` varchar(50) DEFAULT NULL,
  `Business_License` varchar(255) DEFAULT NULL,
  `Status` varchar(20) NOT NULL DEFAULT 'pending',
  `Admin_Notes` text DEFAULT NULL,
  `Submitted_At` datetime DEFAULT current_timestamp(),
  `Processed_At` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `User_ID` int(11) NOT NULL,
  `UID` varchar(20) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Datebirth` date DEFAULT NULL,
  `Sex` varchar(10) DEFAULT NULL,
  `Password` varchar(255) NOT NULL,
  `Images` varchar(255) DEFAULT NULL,
  `Registration_Date` datetime DEFAULT current_timestamp(),
  `Role_id` int(11) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_ID`, `UID`, `FirstName`, `LastName`, `Email`, `Phone`, `Datebirth`, `Sex`, `Password`, `Images`, `Registration_Date`, `Role_id`, `reset_token`, `reset_token_expires`) VALUES
(1, 'U250501', 'Admin', 'naja', 'admin@user.com', '00000000', '1990-01-01', 'M', '$2b$10$bzMhuR9PnkGTt0sn9IspH.Skb6JzmS6tshjwEV.DzL9btuppcPTe.', NULL, '2025-05-09 23:32:57', 1, NULL, NULL),
(2, 'U2505502', 'Manager', 'naja', 'manager@user.com', '00000001', '1990-01-01', 'M', '$2b$10$CMIBUotmzSxyzQchCPw5FuhPTehkU88llKEsQ3mJ6T5n3nWr2G4ZG', NULL, '2025-05-10 08:16:35', 2, NULL, NULL),
(41, 'U25055503', 'Customer', 'naja', 'customer@user.com', '00000001', '1990-01-01', 'M', '$2b$10$aQzjtl/KlFZqrKjUYah98uXcsYwHTL3M1Cf6oAJUmiaxIp5lT2tsa', NULL, '2025-05-10 08:23:32', 3, NULL, NULL),
(44, 'U250555504', 'Customer', 'naja', 'custo4mer@user.com', '00000004', '1990-01-01', 'M', '$2b$10$TP1NgIfb8p1kRLAM8TrmDuSu2lVQxypPykImg9yRCoxCTEg94vREi', NULL, '2025-05-10 10:56:38', 3, NULL, NULL),
(45, 'U2505555505', 'Teng', 'SP', 'Teng@gmail.com', '02093348466', '2004-09-20', 'Male', '$2b$10$CAWdnkG0Li/1Az8djNuqpe3IgtUiHmXLbttvOryCaRoE48WuSo/Q6', NULL, '2025-05-10 14:05:00', 3, NULL, NULL),
(46, 'U25055555506', 'T', 'S', 'Teng1@gmail.com', '2093348477', '2004-09-20', 'Male', '$2b$10$3MHV5cJNXAr8t6L7ppKfE.mPLWINfWoVunTng2y6A0JI.wJZf6bK2', NULL, '2025-05-10 14:30:32', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `Wishlist_ID` int(11) NOT NULL,
  `User_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Date_Added` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`Wishlist_ID`, `User_ID`, `Product_ID`, `Date_Added`) VALUES
(3, 2, 7, '2025-05-10 14:45:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`Activity_ID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Activity_Type` (`Activity_Type`);

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`Address_ID`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`Cart_ID`),
  ADD UNIQUE KEY `CID` (`CID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`Inventory_ID`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Order_ID`),
  ADD UNIQUE KEY `OID` (`OID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Address_ID` (`Address_ID`),
  ADD KEY `Shipment_ID` (`Shipment_ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Product_ID`),
  ADD UNIQUE KEY `PID` (`PID`),
  ADD KEY `fk_pdType` (`productType_ID`),
  ADD KEY `Shop_ID` (`Shop_ID`);

--
-- Indexes for table `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`productType_ID`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`Review_ID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Role_id`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`Shipment_ID`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`Shop_ID`),
  ADD KEY `shops_ibfk_1` (`User_ID`);

--
-- Indexes for table `shop_applications`
--
ALTER TABLE `shop_applications`
  ADD KEY `shop_applications_ibfk_1` (`User_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `UID` (`UID`),
  ADD KEY `Role_id` (`Role_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`Wishlist_ID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `Activity_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `Address_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `Cart_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `Inventory_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_types`
--
ALTER TABLE `product_types`
  MODIFY `productType_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `Review_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `Role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shipment`
--
ALTER TABLE `shipment`
  MODIFY `Shipment_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `Shop_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `Wishlist_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `products` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`Product_ID`) REFERENCES `products` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`Shipment_ID`) REFERENCES `shipment` (`Shipment_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_pdType` FOREIGN KEY (`productType_ID`) REFERENCES `product_types` (`productType_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`Shop_ID`) REFERENCES `shops` (`Shop_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `products` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `shops_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shop_applications`
--
ALTER TABLE `shop_applications`
  ADD CONSTRAINT `shop_applications_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Role_id`) REFERENCES `roles` (`Role_id`) ON UPDATE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `products` (`Product_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
