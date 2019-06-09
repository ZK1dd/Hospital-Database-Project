-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FinalProject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FinalProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FinalProject` DEFAULT CHARACTER SET utf8 ;
USE `FinalProject` ;

-- -----------------------------------------------------
-- Table `FinalProject`.`Ward`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Ward` (
  `wardNo` INT NOT NULL,
  `Name` VARCHAR(25) NULL,
  `loc` VARCHAR(10) NULL,
  `telNo` INT NULL,
  `numBeds` VARCHAR(45) NULL,
  `chargeNurseID` INT NOT NULL,
  PRIMARY KEY (`wardNo`),
  INDEX `staffID_idx` (`chargeNurseID` ASC) VISIBLE,
  CONSTRAINT `staffID`
    FOREIGN KEY (`chargeNurseID`)
    REFERENCES `FinalProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Staff` (
  `staffID` INT NOT NULL,
  `fName` VARCHAR(10) NULL,
  `lName` VARCHAR(10) NULL,
  `address` VARCHAR(45) NULL,
  `tellNo` INT NULL,
  `DOB` DATETIME NULL,
  `gender` VARCHAR(1) NULL,
  `Salary` INT NULL,
  `Position` VARCHAR(10) NULL,
  `wardNo` INT NOT NULL,
  PRIMARY KEY (`staffID`),
  INDEX `wardNo_idx` (`wardNo` ASC) VISIBLE,
  CONSTRAINT `wardNo`
    FOREIGN KEY (`wardNo`)
    REFERENCES `FinalProject`.`Ward` (`wardNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Patient` (
  `patientID` INT NOT NULL,
  `Fname` VARCHAR(10) NULL,
  `lName` VARCHAR(10) NULL,
  `address` VARCHAR(45) NULL,
  `telNo` INT NULL,
  `DOB` DATETIME NULL,
  `gender` VARCHAR(1) NULL,
  `marStatus` VARCHAR(10) NULL,
  `dateRegistered` DATETIME NULL,
  `docID` INT NOT NULL,
  `clinicNO` INT NOT NULL,
  PRIMARY KEY (`patientID`),
  INDEX `staffID_idx` (`docID` ASC) VISIBLE,
  INDEX `clinicID_idx` (`clinicNO` ASC) VISIBLE,
  CONSTRAINT `staffID`
    FOREIGN KEY (`docID`)
    REFERENCES `FinalProject`.`Doctor` (`staffNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `clinicID`
    FOREIGN KEY (`clinicNO`)
    REFERENCES `FinalProject`.`Clinic` (`clinicNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Appointments` (
  `appID` INT NOT NULL,
  `staffNo` INT NOT NULL,
  `PatientNo` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `room` VARCHAR(5) NULL,
  PRIMARY KEY (`appID`),
  INDEX `staffID_idx` (`staffNo` ASC) VISIBLE,
  INDEX `patientNo_idx` (`PatientNo` ASC) VISIBLE,
  CONSTRAINT `staffID`
    FOREIGN KEY (`staffNo`)
    REFERENCES `FinalProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patientNo`
    FOREIGN KEY (`PatientNo`)
    REFERENCES `FinalProject`.`Patient` (`patientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Clinic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Clinic` (
  `clinicNo` INT NOT NULL,
  `date` DATETIME NULL,
  `time` DATETIME NULL,
  `appNo` INT NOT NULL,
  PRIMARY KEY (`clinicNo`),
  INDEX `appID_idx` (`appNo` ASC) VISIBLE,
  CONSTRAINT `appID`
    FOREIGN KEY (`appNo`)
    REFERENCES `FinalProject`.`Appointments` (`appID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Doctor` (
  `staffNo` INT NOT NULL,
  `Name` VARCHAR(30) NULL,
  `clinicNo` INT NOT NULL,
  `telNo` INT NULL,
  PRIMARY KEY (`staffNo`),
  INDEX `clinicNo_idx` (`clinicNo` ASC) VISIBLE,
  CONSTRAINT `clinicNo`
    FOREIGN KEY (`clinicNo`)
    REFERENCES `FinalProject`.`Clinic` (`clinicNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Suppliers` (
  `supplierID` INT NOT NULL,
  `Name` VARCHAR(25) NULL,
  `address` VARCHAR(45) NULL,
  `email` VARCHAR(25) NULL,
  `telNo` INT NULL,
  `faxNo` INT NULL,
  PRIMARY KEY (`supplierID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Items` (
  `itemNo` INT NOT NULL,
  `supplierNo` INT NOT NULL,
  `name` VARCHAR(25) NULL,
  `description` VARCHAR(45) NULL,
  `QTY` INT NULL,
  `reOrderTime` DATETIME NULL,
  `unitCost` INT NULL,
  PRIMARY KEY (`itemNo`),
  INDEX `supplierNo_idx` (`supplierNo` ASC) VISIBLE,
  CONSTRAINT `supplierNo`
    FOREIGN KEY (`supplierNo`)
    REFERENCES `FinalProject`.`Suppliers` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Drugs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Drugs` (
  `drugNo` INT NOT NULL,
  `supplierNo` INT NOT NULL,
  `name` VARCHAR(25) NULL,
  `Description` VARCHAR(45) NULL,
  `Dosage` VARCHAR(45) NULL,
  `QTY` INT NULL,
  `reOrderTime` DATETIME NULL,
  `unitCost` INT NULL,
  PRIMARY KEY (`drugNo`),
  INDEX `supplierNo_idx` (`supplierNo` ASC) VISIBLE,
  CONSTRAINT `supplierNo`
    FOREIGN KEY (`supplierNo`)
    REFERENCES `FinalProject`.`Suppliers` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`PurchaseReqs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`PurchaseReqs` (
  `reqID` INT NOT NULL,
  `chargeNurseID` INT NOT NULL,
  `wardNo` INT NOT NULL,
  `drugNo` INT NOT NULL,
  `reqQuant` INT NULL,
  `dateOrdered` DATETIME NULL,
  `dateRecieved` DATETIME NULL,
  PRIMARY KEY (`reqID`),
  INDEX `staffID_idx` (`chargeNurseID` ASC) VISIBLE,
  INDEX `wardNo_idx` (`wardNo` ASC) VISIBLE,
  CONSTRAINT `staffID`
    FOREIGN KEY (`chargeNurseID`)
    REFERENCES `FinalProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `wardNo`
    FOREIGN KEY (`wardNo`)
    REFERENCES `FinalProject`.`Ward` (`wardNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `drugNo`
    FOREIGN KEY ()
    REFERENCES `FinalProject`.`Drugs` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Beds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Beds` (
  `bedNo` INT NOT NULL,
  `patientNo` INT NOT NULL,
  `wardNo` INT NOT NULL,
  PRIMARY KEY (`bedNo`),
  INDEX `wardNO_idx` (`wardNo` ASC) VISIBLE,
  INDEX `patientNO_idx` (`patientNo` ASC) VISIBLE,
  CONSTRAINT `wardNO`
    FOREIGN KEY (`wardNo`)
    REFERENCES `FinalProject`.`Ward` (`wardNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patientNO`
    FOREIGN KEY (`patientNo`)
    REFERENCES `FinalProject`.`Patient` (`patientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`NoK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`NoK` (
  `patientNo` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  `nokID` INT NOT NULL,
  `address` VARCHAR(45) NULL,
  `relation` VARCHAR(10) NULL,
  PRIMARY KEY (`nokID`),
  INDEX `patientID_idx` (`patientNo` ASC) VISIBLE,
  CONSTRAINT `patientID`
    FOREIGN KEY (`patientNo`)
    REFERENCES `FinalProject`.`Patient` (`patientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
