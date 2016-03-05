--
-- Tablo için tablo yapısı `Category`
--

CREATE TABLE IF NOT EXISTS `Category` (
  `idCategory` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `uri` varchar(10) NOT NULL,
  `isActive` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`idCategory`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Tablo döküm verisi `Category`
--

INSERT INTO `Category` (`idCategory`, `name`, `uri`, `isActive`) VALUES
(1, 'Vasıta', 'vasita', 'Y'),
(2, 'Emlak', 'emlak', 'Y');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Content`
--

CREATE TABLE IF NOT EXISTS `Content` (
  `idContent` int(11) NOT NULL AUTO_INCREMENT,
  `subCategory3Id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `isActive` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`idContent`),
  KEY `fk_subcat3_content_idx` (`subCategory3Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `Detail`
--

CREATE TABLE IF NOT EXISTS `Detail` (
  `idDetail` int(11) NOT NULL AUTO_INCREMENT,
  `contentId` int(11) NOT NULL,
  `price` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `district` varchar(45) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `fromWhom` varchar(15) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `isActive` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`idDetail`),
  KEY `fk_content_detail_idx` (`contentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `SubCategory`
--

CREATE TABLE IF NOT EXISTS `SubCategory` (
  `idSubCategory` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `uri` varchar(45) NOT NULL,
  `url` varchar(255) NOT NULL,
  `isActive` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`idSubCategory`),
  KEY `fk_cat_subcat_idx` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `SubCategory2`
--

CREATE TABLE IF NOT EXISTS `SubCategory2` (
  `idSubCategory2` int(11) NOT NULL AUTO_INCREMENT,
  `subCategoryId` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `uri` varchar(45) NOT NULL,
  `url` varchar(255) NOT NULL,
  `isActive` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`idSubCategory2`),
  KEY `fk_subcat_subcat2_idx` (`subCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `SubCategory3`
--

CREATE TABLE IF NOT EXISTS `SubCategory3` (
  `idSubCategory3` int(11) NOT NULL AUTO_INCREMENT,
  `subCategory2Id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `uri` varchar(45) NOT NULL,
  `url` varchar(255) NOT NULL,
  `isActive` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`idSubCategory3`),
  KEY `fk_subcat2_subcat3_idx` (`subCategory2Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `Content`
--
ALTER TABLE `Content`
  ADD CONSTRAINT `fk_subcat3_content` FOREIGN KEY (`subCategory3Id`) REFERENCES `SubCategory3` (`idSubCategory3`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `Detail`
--
ALTER TABLE `Detail`
  ADD CONSTRAINT `fk_content_detail` FOREIGN KEY (`contentId`) REFERENCES `Content` (`idContent`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `SubCategory`
--
ALTER TABLE `SubCategory`
  ADD CONSTRAINT `fk_cat_subcat` FOREIGN KEY (`categoryId`) REFERENCES `Category` (`idCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `SubCategory2`
--
ALTER TABLE `SubCategory2`
  ADD CONSTRAINT `fk_subcat_subcat2` FOREIGN KEY (`subCategoryId`) REFERENCES `SubCategory` (`idSubCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Tablo kısıtlamaları `SubCategory3`
--
ALTER TABLE `SubCategory3`
  ADD CONSTRAINT `fk_subcat2_subcat3` FOREIGN KEY (`subCategory2Id`) REFERENCES `SubCategory2` (`idSubCategory2`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
