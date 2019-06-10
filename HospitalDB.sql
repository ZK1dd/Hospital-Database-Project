
-- -----------------------------------------------------
-- Schema FinalProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FinalProject` DEFAULT CHARACTER SET utf8 ;
USE `FinalProject` ;

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
-- Table `FinalProject`.`Ward`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Ward` (
  `wardNo` INT NOT NULL,
  `Name` VARCHAR(25) NULL,
  `loc` VARCHAR(10) NULL,
  `telNo` INT NULL,
  `numBeds` VARCHAR(45) NULL,
  `chargeNurseID` INT NOT NULL,
  PRIMARY KEY (`wardNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Supplies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`Supplies` (
  `itemNo` INT NOT NULL,
  `supplierNo` INT NOT NULL,
  `name` VARCHAR(25) NULL,
  `description` VARCHAR(45) NULL,
  `QTY` INT NULL,
  `reOrderTime` DATETIME NULL,
  `unitCost` INT NULL,
  `wardNo` INT NOT NULL,
  PRIMARY KEY (`itemNo`),
  INDEX `supplierNo_idx` (`supplierNo` ASC) VISIBLE,
  INDEX `wardNo_idx` (`wardNo` ASC) VISIBLE,
  CONSTRAINT `supplierNo`
    FOREIGN KEY (`supplierNo`)
    REFERENCES `FinalProject`.`Suppliers` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `wardNo`
    FOREIGN KEY (`wardNo`)
    REFERENCES `FinalProject`.`Ward` (`wardNo`)
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
  CONSTRAINT `wardNO`
    FOREIGN KEY (`wardNo`)
    REFERENCES `FinalProject`.`Ward` (`wardNo`)
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
  PRIMARY KEY (`clinicNo`))
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
  PRIMARY KEY (`nokID`))
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
  `wardNo` INT NOT NULL,
  PRIMARY KEY (`drugNo`),
  INDEX `supplierNo_idx` (`supplierNo` ASC) VISIBLE,
  INDEX `wardNo_idx` (`wardNo` ASC) VISIBLE,
  CONSTRAINT `supplierNo`
    FOREIGN KEY (`supplierNo`)
    REFERENCES `FinalProject`.`Suppliers` (`supplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
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
  `staffID` INT NOT NULL,
  `clinicNO` INT NOT NULL,
  `nokID` INT NOT NULL,
  `allergies` VARCHAR(45) NULL,
  `drugNo` INT NULL,
  `medicine` VARCHAR(45) NULL,
  `unitsperDay` INT NULL,
  PRIMARY KEY (`patientID`),
  INDEX `clinicID_idx` (`clinicNO` ASC) VISIBLE,
  INDEX `fk_Patient_NoK1_idx` (`nokID` ASC) VISIBLE,
  INDEX `staffID_idx` (`staffID` ASC) VISIBLE,
  INDEX `drugNo_idx` (`drugNo` ASC) VISIBLE,
  CONSTRAINT `clinicID`
    FOREIGN KEY (`clinicNO`)
    REFERENCES `FinalProject`.`Clinic` (`clinicNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_NoK1`
    FOREIGN KEY (`nokID`)
    REFERENCES `FinalProject`.`NoK` (`nokID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `staffID`
    FOREIGN KEY (`staffID`)
    REFERENCES `FinalProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `drugNo`
    FOREIGN KEY (`drugNo`)
    REFERENCES `FinalProject`.`Drugs` (`drugNo`)
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
  `clinicNo` INT NOT NULL,
  PRIMARY KEY (`appID`),
  INDEX `staffID_idx` (`staffNo` ASC) VISIBLE,
  INDEX `patientNo_idx` (`PatientNo` ASC) VISIBLE,
  INDEX `fk_Appointments_Clinic1_idx` (`clinicNo` ASC) VISIBLE,
  CONSTRAINT `staffID`
    FOREIGN KEY (`staffNo`)
    REFERENCES `FinalProject`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patientNo`
    FOREIGN KEY (`PatientNo`)
    REFERENCES `FinalProject`.`Patient` (`patientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointments_Clinic1`
    FOREIGN KEY (`clinicNo`)
    REFERENCES `FinalProject`.`Clinic` (`clinicNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `FinalProject` ;

-- -----------------------------------------------------
-- Placeholder table for view `FinalProject`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`view1` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `FinalProject`.`view2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FinalProject`.`view2` (`id` INT);

-- -----------------------------------------------------
-- View `FinalProject`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`view1`;
USE `FinalProject`;
CREATE  OR REPLACE VIEW `view1` AS Select *;

-- -----------------------------------------------------
-- View `FinalProject`.`view2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`view2`;
USE `FinalProject`;
CREATE  OR REPLACE VIEW `view2` AS Select * From Appointments,Beds,Clinic,Drugs,NoK,Patient,PurchaseReqs,Staff,Suppliers,Supplies,Ward
Where Staff.wardNo = Ward.wardNo
IF Staff.position = "ChargeNurse"
END IF;
USE `FinalProject`;

DELIMITER $$
USE `FinalProject`$$
CREATE DEFINER = CURRENT_USER TRIGGER `FinalProject`.`Patient_AFTER_UPDATE` AFTER UPDATE ON `Patient` FOR EACH ROW
BEGIN
if patient.allergies = patient.medicine
THEN
	Delete patient.medicine From patient;
End if;
END$$


DELIMITER ;

