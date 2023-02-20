-- MySQL Script generated by MySQL Workbench
-- Sun Sep 19 23:01:09 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DW211_SRINIVASAN_SalesOrders
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DW211_SRINIVASAN_SalesOrders
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders` DEFAULT CHARACTER SET utf8 ;
USE `DW211_SRINIVASAN_SalesOrders` ;

-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`CUSTOMERTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`CUSTOMERTYPE` (
  `custTypeID` CHAR(1) NOT NULL,
  `typeName` VARCHAR(20) NULL,
  PRIMARY KEY (`custTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`CUSTOMER` (
  `customerID` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  `addr1` VARCHAR(50) NULL,
  `addr2` VARCHAR(50) NULL,
  `city` VARCHAR(30) NULL,
  `state` CHAR(2) NULL,
  `zip` CHAR(5) NULL,
  `custTypeID` CHAR(1) NOT NULL,
  PRIMARY KEY (`customerID`, `custTypeID`),
  INDEX `custTypeID_idx` (`custTypeID` ASC) VISIBLE,
  CONSTRAINT `custTypeID`
    FOREIGN KEY (`custTypeID`)
    REFERENCES `DW211_SRINIVASAN_SalesOrders`.`CUSTOMERTYPE` (`custTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`INVOICEHDR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`INVOICEHDR` (
  `invoiceID` INT NOT NULL,
  `customerID` INT NOT NULL,
  `saleDate` DATE NULL,
  PRIMARY KEY (`invoiceID`),
  INDEX `customerID_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `customerID`
    FOREIGN KEY (`customerID`)
    REFERENCES `DW211_SRINIVASAN_SalesOrders`.`CUSTOMER` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`BUSINESSUNIT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`BUSINESSUNIT` (
  `BUID` CHAR(1) NOT NULL,
  `name` VARCHAR(25) NULL,
  `abbrev` VARCHAR(10) NULL,
  PRIMARY KEY (`BUID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`PRODTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`PRODTYPE` (
  `prodTypeID` INT NOT NULL,
  `typeDescription` VARCHAR(25) NULL,
  `BUID` CHAR(1) NULL,
  PRIMARY KEY (`prodTypeID`),
  INDEX `BUID_idx` (`BUID` ASC) VISIBLE,
  CONSTRAINT `BUID`
    FOREIGN KEY (`BUID`)
    REFERENCES `DW211_SRINIVASAN_SalesOrders`.`BUSINESSUNIT` (`BUID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`SUPPLIER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`SUPPLIER` (
  `supplierID` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  `addr1` VARCHAR(50) NULL,
  `addr2` VARCHAR(50) NULL,
  `city` VARCHAR(30) NULL,
  `state` CHAR(2) NULL,
  `zip` CHAR(5) NULL,
  PRIMARY KEY (`supplierID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`PRODUCT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`PRODUCT` (
  `prodID` INT NOT NULL,
  `description` VARCHAR(50) NULL,
  `price1` DECIMAL(10,2) NULL,
  `price2` DECIMAL(10,2) NULL,
  `prodTypeID` INT NULL,
  `unitCost` DECIMAL(10,2) NULL,
  `supplierID` INT NOT NULL,
  PRIMARY KEY (`prodID`),
  INDEX `prodTypeID_idx` (`prodTypeID` ASC) VISIBLE,
  INDEX `supplierID_idx` (`supplierID` ASC) VISIBLE,
  CONSTRAINT `prodTypeID`
    FOREIGN KEY (`prodTypeID`)
    REFERENCES `DW211_SRINIVASAN_SalesOrders`.`PRODTYPE` (`prodTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `supplierID`
    FOREIGN KEY (`supplierID`)
    REFERENCES `DW211_SRINIVASAN_SalesOrders`.`SUPPLIER` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW211_SRINIVASAN_SalesOrders`.`INVOICEDTL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW211_SRINIVASAN_SalesOrders`.`INVOICEDTL` (
  `invoiceID` INT NOT NULL,
  `prodID` INT NOT NULL,
  `amt` DECIMAL(10,2) NULL,
  `qty` DECIMAL(8,2) NULL,
  `discounted` TINYINT NULL,
  INDEX `invoiceID_idx` (`invoiceID` ASC) VISIBLE,
  INDEX `prodID_idx` (`prodID` ASC) VISIBLE,
  PRIMARY KEY (`invoiceID`, `prodID`),
  CONSTRAINT `invoiceID`
    FOREIGN KEY (`invoiceID`)
    REFERENCES `DW211_SRINIVASAN_SalesOrders`.`INVOICEHDR` (`invoiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prodID`
    FOREIGN KEY (`prodID`)
    REFERENCES `DW211_SRINIVASAN_SalesOrders`.`PRODUCT` (`prodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
