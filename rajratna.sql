-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 26, 2020 at 05:37 PM
-- Server version: 5.5.16
-- PHP Version: 5.4.0beta2-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rajratna`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customername` varchar(30) NOT NULL,
  `customermobile` bigint(15) NOT NULL,
  PRIMARY KEY (`customermobile`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customername`, `customermobile`) VALUES
('asasa', 2323),
('erere', 1232323),
('Anshul', 1234343),
('asdasa', 22334455),
('Dheru', 44545454),
('kaka', 102938475),
('Rajat', 7777777777),
('Ankit', 9922113344),
('asasasasasa', 43434343434);

-- --------------------------------------------------------

--
-- Table structure for table `customerpurchasedetail`
--

CREATE TABLE IF NOT EXISTS `customerpurchasedetail` (
  `billno` bigint(20) NOT NULL,
  `itemcode` varchar(20) NOT NULL,
  `itemname` varchar(30) NOT NULL,
  `size` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `price` int(10) NOT NULL,
  PRIMARY KEY (`billno`,`itemcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customerpurchasedetail`
--

INSERT INTO `customerpurchasedetail` (`billno`, `itemcode`, `itemname`, `size`, `quantity`, `price`) VALUES
(136, '101', 'jeans', 34, 2, 3000),
(136, '105', 'Trousers', 36, 1, 2250),
(137, '102', 'Shirt', 44, 1, 1500),
(137, '103', 'Pant', 36, 1, 1850);

-- --------------------------------------------------------

--
-- Table structure for table `dealers`
--

CREATE TABLE IF NOT EXISTS `dealers` (
  `companyname` varchar(30) NOT NULL,
  `address` varchar(60) NOT NULL,
  `contact` bigint(15) NOT NULL,
  `accountno` bigint(20) NOT NULL,
  `bankname` varchar(30) NOT NULL,
  `ifsc` varchar(20) NOT NULL,
  PRIMARY KEY (`companyname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dealers`
--

INSERT INTO `dealers` (`companyname`, `address`, `contact`, `accountno`, `bankname`, `ifsc`) VALUES
('Anshu', 'Scheme No 71 Sector A 123 K1 Gumashta Nagar', 8008152931, 34454545673433, 'icici', 'uu889'),
('Anshul Corp Indore', 'karahi', 9144655062, 500122343434, 'hdfc', 'icic002323'),
('Anshul Corp l', 'karahi', 9144655062, 500122343434, 'hdfc', 'icic002323');

-- --------------------------------------------------------

--
-- Table structure for table `emp`
--

CREATE TABLE IF NOT EXISTS `emp` (
  `EMPID` varchar(30) NOT NULL,
  `EMPNAME` varchar(30) NOT NULL,
  `EMPLOCN` varchar(30) NOT NULL,
  `EMPSALARY` varchar(15) NOT NULL,
  PRIMARY KEY (`EMPID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp`
--

INSERT INTO `emp` (`EMPID`, `EMPNAME`, `EMPLOCN`, `EMPSALARY`) VALUES
('101', 'Anshul', 'Indore', '10000'),
('102', 'Ansh', 'Karhi', '20000'),
('103', 'Dhairya', 'Karhi', '20000'),
('104', 'Bani', 'Karhi', '20000');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `ItemType` varchar(30) NOT NULL,
  `ItemCode` varchar(10) NOT NULL,
  PRIMARY KEY (`ItemCode`),
  UNIQUE KEY `ItemType` (`ItemType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`ItemType`, `ItemCode`) VALUES
('Cap', '302'),
('Jeans', '304'),
('Jeansaa', '3041'),
('Trouser', '303');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE IF NOT EXISTS `purchase` (
  `companyname` varchar(30) NOT NULL,
  `purchaseid` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `purchasebilldetail`
--

CREATE TABLE IF NOT EXISTS `purchasebilldetail` (
  `customername` varchar(60) NOT NULL,
  `customermobile` bigint(15) NOT NULL,
  `billno` bigint(20) NOT NULL,
  `itempurchased` int(10) NOT NULL DEFAULT '0',
  `totalprice` int(10) NOT NULL DEFAULT '0',
  `discount` int(10) NOT NULL DEFAULT '10',
  `discountamount` int(10) NOT NULL DEFAULT '0',
  `adjustamount` int(10) NOT NULL DEFAULT '0',
  `amountpaid` int(10) NOT NULL DEFAULT '0',
  `Date` date NOT NULL,
  PRIMARY KEY (`billno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchasebilldetail`
--

INSERT INTO `purchasebilldetail` (`customername`, `customermobile`, `billno`, `itempurchased`, `totalprice`, `discount`, `discountamount`, `adjustamount`, `amountpaid`, `Date`) VALUES
('Anshul Chhajed', 8008152936, 136, 3, 8250, 10, 825, 0, 7425, '2020-08-26'),
('Yash Chhajed', 9165710200, 137, 2, 3350, 10, 335, 0, 3015, '2020-08-26');

-- --------------------------------------------------------

--
-- Table structure for table `purchasebook`
--

CREATE TABLE IF NOT EXISTS `purchasebook` (
  `voucherno` bigint(15) NOT NULL,
  `companyname` varchar(30) NOT NULL,
  `paymenttype` varchar(20) NOT NULL,
  `itemcode` varchar(20) NOT NULL,
  `itemname` varchar(30) NOT NULL,
  `rate` int(10) NOT NULL,
  `designcode` varchar(20) NOT NULL,
  `color` varchar(10) NOT NULL,
  `profit` int(10) NOT NULL,
  `ratediff` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `amount` bigint(15) NOT NULL,
  `date` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchasebook`
--

INSERT INTO `purchasebook` (`voucherno`, `companyname`, `paymenttype`, `itemcode`, `itemname`, `rate`, `designcode`, `color`, `profit`, `ratediff`, `quantity`, `amount`, `date`) VALUES
(123456, 'Anshul', 'Credit', '304', 'Jeans', 100, '9920099', 'Mix', 10, 100, 1, 2000, '25/08/2020'),
(123456, 'Anshul', 'Credit', '304', 'Jeans', 100, '9920099', 'Mix', 10, 10, 3, 330, '25/08/2020'),
(123456, 'company1', 'Cash', '304', 'Jeans', 100, '9920099', 'Mix', 10, 10, 2, 220, '25/08/2020'),
(123456, 'Dealer', 'Credit', '302', 'Cap', 100, '9920099', 'Mix', 10, 10, 2, 220, '26/08/2020'),
(123456, 'Dealer', 'Credit', '304', 'Jeans', 200, '9940099', 'Mix', 20, 20, 2, 480, '26/08/2020'),
(123456, 'Anshul Corp l', 'Cash', '304', 'Jeans', 100, '9920099', 'Mix', 15, 15, 2, 230, '26/08/2020'),
(123456, 'Dealer', 'Credit', '304', 'Jeans', 200, '9940099', 'Mix', 10, 10, 2, 440, '26/08/2020'),
(123456, 'Dealer', 'Credit', '303', 'Trouser', 185, '9937099', 'Mix', 10, 10, 2, 407, '26/08/2020'),
(123456, 'Dealer', 'Credit', '304', 'Jeans', 230, '9946099', 'Mix', 10, 10, 2, 506, '26/08/2020'),
(123456, 'Dealer', 'Credit', '304', 'Jeans', 100, '9920099', 'Mix', 10, 10, 2, 220, '26/08/2020');

-- --------------------------------------------------------

--
-- Table structure for table `purchaseentry`
--

CREATE TABLE IF NOT EXISTS `purchaseentry` (
  `voucherno` bigint(15) NOT NULL,
  `itemcode` varchar(10) NOT NULL,
  `itemname` varchar(20) NOT NULL,
  `size` varchar(10) NOT NULL,
  `quantity` int(5) NOT NULL,
  `purchaserate` int(11) NOT NULL,
  `profit` int(11) NOT NULL,
  `sellingrate` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchaseentry`
--

INSERT INTO `purchaseentry` (`voucherno`, `itemcode`, `itemname`, `size`, `quantity`, `purchaserate`, `profit`, `sellingrate`) VALUES
(123456, '304', 'Jeans', '100', 2, 200, 10, '28'),
(123456, '303', 'Trouser', '120', 2, 185, 10, '38'),
(123456, '304', 'Jeans', '170', 2, 230, 10, '30'),
(123456, '304', 'Jeans', '100', 2, 100, 10, '28');

-- --------------------------------------------------------

--
-- Table structure for table `recentactivity`
--

CREATE TABLE IF NOT EXISTS `recentactivity` (
  `lastbillno` bigint(20) NOT NULL,
  `tempbillno` bigint(20) NOT NULL,
  `UsedFlag` varchar(6) NOT NULL DEFAULT 'false',
  `openFlag` varchar(10) NOT NULL,
  `customername` varchar(30) NOT NULL,
  `customermobile` bigint(15) NOT NULL,
  `Date` date NOT NULL,
  `tinno` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recentactivity`
--

INSERT INTO `recentactivity` (`lastbillno`, `tempbillno`, `UsedFlag`, `openFlag`, `customername`, `customermobile`, `Date`, `tinno`) VALUES
(143, 143, 'false', 'false', 'NA', 0, '2020-08-26', 1223456678);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
  `itemcode` varchar(50) NOT NULL,
  `itemname` varchar(50) NOT NULL,
  `size` int(15) NOT NULL,
  `quantity` int(15) NOT NULL,
  `price` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`itemcode`, `itemname`, `size`, `quantity`, `price`) VALUES
('j101', 'Jeans', 34, 6, 1024),
('j102', 'Shirt', 40, 3, 1050);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE IF NOT EXISTS `stock` (
  `itemcode` varchar(20) NOT NULL,
  `purchaseid` varchar(20) NOT NULL,
  `categoryid` varchar(20) NOT NULL,
  `itemtype` varchar(20) NOT NULL,
  `color` varchar(20) NOT NULL,
  `size` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`itemcode`, `purchaseid`, `categoryid`, `itemtype`, `color`, `size`, `quantity`, `price`) VALUES
('101', 'p121', 'c101', 'jeans', 'blue', 34, 3, 3000),
('102', 'p102', 'c102', 'Shirt', 'Black', 44, 4, 1500),
('103', 'p103', 'c103', 'Pant', 'Brown', 36, 4, 1850),
('104', 'p104', 'c104', 'Saree', 'Blue', 36, 5, 4000),
('105', 'p104', 'c104', 'Trousers', 'Brown', 36, 4, 2250),
('106', 'p106', 'c106', 'ParleG', 'Brown', 36, 5, 850),
('107', 'p107', 'c107', 'KrackJack', 'Brown', 36, 5, 450);

-- --------------------------------------------------------

--
-- Table structure for table `tempstock`
--

CREATE TABLE IF NOT EXISTS `tempstock` (
  `billno` bigint(20) NOT NULL,
  `itemcode` varchar(20) NOT NULL,
  `purchaseid` varchar(20) NOT NULL,
  `categoryid` varchar(20) NOT NULL,
  `itemtype` varchar(20) NOT NULL,
  `color` varchar(20) NOT NULL,
  `size` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `currQuantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `currPrice` int(11) NOT NULL,
  PRIMARY KEY (`billno`,`itemcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userlogin`
--

CREATE TABLE IF NOT EXISTS `userlogin` (
  `login_id` varchar(50) NOT NULL,
  `login_password` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userlogin`
--

INSERT INTO `userlogin` (`login_id`, `login_password`, `user_name`, `user_type`) VALUES
('anshul19', '123456', 'Anshul', 'Administrator'),
('bani02', 'bani', 'Bani Chhajed', 'Administrator'),
('ansh04', 'anshu', 'Ansh Chhajed', 'Administrator'),
('dhairya11', '123456', 'Dhairya', 'Administrator');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
