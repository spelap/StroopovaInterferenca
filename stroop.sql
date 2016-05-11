-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema p12015stroop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema p12015stroop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `p12015stroop` DEFAULT CHARACTER SET utf8 ;
USE `p12015stroop` ;

-- -----------------------------------------------------
-- Table `p12015stroop`.`eksperiment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p12015stroop`.`eksperiment` (
  `id_eksperiment` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `ime` VARCHAR(200) NOT NULL COMMENT '',
  `uvodni_pozdrav` VARCHAR(1000) NOT NULL COMMENT '',
  `navodilo` VARCHAR(1000) NOT NULL COMMENT '',
  `zahvala` VARCHAR(1000) NOT NULL COMMENT '',
  `st_ponovitev` VARCHAR(10) NOT NULL COMMENT '',
  `beseda_1` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `beseda_2` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `beseda_3` VARCHAR(50) NULL DEFAULT NULL COMMENT '',
  `beseda_4` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  `beseda_5` VARCHAR(20) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`id_eksperiment`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `p12015stroop`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p12015stroop`.`student` (
  `id_student` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `geslo` VARCHAR(50) NOT NULL COMMENT '',
  `email` VARCHAR(45) NOT NULL COMMENT '',
  `ime` VARCHAR(45) NOT NULL COMMENT '',
  `priimek` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`id_student`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `p12015stroop`.`izdelava`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p12015stroop`.`izdelava` (
  `id_izdelava` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `STUDENT_id_student` INT(11) NOT NULL COMMENT '',
  `EKSPERIMENT_id_eksperiment` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`id_izdelava`)  COMMENT '',
  INDEX `fk_IZDELAVA_STUDENT_idx` (`STUDENT_id_student` ASC)  COMMENT '',
  INDEX `fk_IZDELAVA_EKSPERIMENT1_idx` (`EKSPERIMENT_id_eksperiment` ASC)  COMMENT '',
  CONSTRAINT `fk_IZDELAVA_EKSPERIMENT1`
    FOREIGN KEY (`EKSPERIMENT_id_eksperiment`)
    REFERENCES `p12015stroop`.`eksperiment` (`id_eksperiment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IZDELAVA_STUDENT`
    FOREIGN KEY (`STUDENT_id_student`)
    REFERENCES `p12015stroop`.`student` (`id_student`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `p12015stroop`.`uporabnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p12015stroop`.`uporabnik` (
  `id_uporabnik` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `sifra` VARCHAR(45) NOT NULL COMMENT '',
  `starost` INT(11) NOT NULL COMMENT '',
  `spol` VARCHAR(10) NOT NULL COMMENT '',
  PRIMARY KEY (`id_uporabnik`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 150
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `p12015stroop`.`izvedba`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p12015stroop`.`izvedba` (
  `id_izvedba` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `datum` DATE NULL DEFAULT NULL COMMENT '',
  `EKSPERIMENT_id_eksperiment` INT(11) NOT NULL COMMENT '',
  `UPORABNIK_id_uporabnik` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`id_izvedba`)  COMMENT '',
  INDEX `fk_IZVEDBA_EKSPERIMENT1_idx` (`EKSPERIMENT_id_eksperiment` ASC)  COMMENT '',
  INDEX `fk_IZVEDBA_UPORABNIK1_idx` (`UPORABNIK_id_uporabnik` ASC)  COMMENT '',
  CONSTRAINT `fk_IZVEDBA_EKSPERIMENT1`
    FOREIGN KEY (`EKSPERIMENT_id_eksperiment`)
    REFERENCES `p12015stroop`.`eksperiment` (`id_eksperiment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IZVEDBA_UPORABNIK1`
    FOREIGN KEY (`UPORABNIK_id_uporabnik`)
    REFERENCES `p12015stroop`.`uporabnik` (`id_uporabnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `p12015stroop`.`user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p12015stroop`.`user_roles` (
  `email` VARCHAR(30) NOT NULL COMMENT '',
  `role_name` VARCHAR(15) NOT NULL COMMENT '',
  PRIMARY KEY (`email`, `role_name`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `p12015stroop`.`vprasanje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p12015stroop`.`vprasanje` (
  `id_vprasanje` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `pravilnost` TINYINT(1) NOT NULL COMMENT '',
  `cas` INT(80) NOT NULL COMMENT '',
  `IZVEDBA_id_izvedba` INT(11) NOT NULL COMMENT '',
  `tip` VARCHAR(45) NOT NULL COMMENT '',
  `vnesena_barva` VARCHAR(45) NOT NULL COMMENT '',
  `pravilna_barva` VARCHAR(45) NOT NULL COMMENT '',
  `beseda` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`id_vprasanje`)  COMMENT '',
  INDEX `fk_VPRASANJE_IZVEDBA1_idx` (`IZVEDBA_id_izvedba` ASC)  COMMENT '',
  CONSTRAINT `fk_VPRASANJE_IZVEDBA1`
    FOREIGN KEY (`IZVEDBA_id_izvedba`)
    REFERENCES `p12015stroop`.`izvedba` (`id_izvedba`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1941
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
