-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`brand` ;

CREATE TABLE IF NOT EXISTS `mydb`.`brand` (
  `brand_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`brand_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bat_size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bat_size` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bat_size` (
  `bat_size_id` INT NOT NULL AUTO_INCREMENT,
  `length` TINYINT(2) NOT NULL,
  `weight` TINYINT(2) NOT NULL,
  PRIMARY KEY (`bat_size_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bbcor_bats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bbcor_bats` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bbcor_bats` (
  `bat_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `brand_id` INT UNSIGNED NOT NULL,
  `model_num` VARCHAR(25) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `bat_size_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `fk_bbcor_bats_brand_idx` (`brand_id` ASC) VISIBLE,
  INDEX `fk_bbcor_bats_bat_size1_idx` (`bat_size_id` ASC) VISIBLE,
  PRIMARY KEY (`bat_id`),
  CONSTRAINT `fk_bbcor_bats_brand`
    FOREIGN KEY (`brand_id`)
    REFERENCES `mydb`.`brand` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bbcor_bats_bat_size1`
    FOREIGN KEY (`bat_size_id`)
    REFERENCES `mydb`.`bat_size` (`bat_size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2000
KEY_BLOCK_SIZE = 2;


-- -----------------------------------------------------
-- Table `mydb`.`type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`type` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wood_bats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`wood_bats` ;

CREATE TABLE IF NOT EXISTS `mydb`.`wood_bats` (
  `bat_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `brand_id` INT UNSIGNED NOT NULL,
  `model_num` VARCHAR(25) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `bat_size_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `fk_bbcor_bats_brand_idx` (`brand_id` ASC) VISIBLE,
  INDEX `fk_bbcor_bats_bat_size1_idx` (`bat_size_id` ASC) VISIBLE,
  PRIMARY KEY (`bat_id`),
  CONSTRAINT `fk_bbcor_bats_brand00`
    FOREIGN KEY (`brand_id`)
    REFERENCES `mydb`.`brand` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bbcor_bats_bat_size100`
    FOREIGN KEY (`bat_size_id`)
    REFERENCES `mydb`.`bat_size` (`bat_size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usssa_bats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`usssa_bats` ;

CREATE TABLE IF NOT EXISTS `mydb`.`usssa_bats` (
  `bat_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `brand_id` INT UNSIGNED NOT NULL,
  `model_num` VARCHAR(25) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `bat_size_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `fk_bbcor_bats_brand_idx` (`brand_id` ASC) VISIBLE,
  INDEX `fk_bbcor_bats_bat_size1_idx` (`bat_size_id` ASC) VISIBLE,
  PRIMARY KEY (`bat_id`),
  CONSTRAINT `fk_bbcor_bats_brand0`
    FOREIGN KEY (`brand_id`)
    REFERENCES `mydb`.`brand` (`brand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bbcor_bats_bat_size10`
    FOREIGN KEY (`bat_size_id`)
    REFERENCES `mydb`.`bat_size` (`bat_size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `mydb`.`bats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bats` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bats` (
  `bat_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  INDEX `fk_bats_type1_idx` (`type_id` ASC) VISIBLE,
  PRIMARY KEY (`bat_id`),
  CONSTRAINT `fk_bats_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `mydb`.`type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bats_bbcor_bats1`
    FOREIGN KEY (`bat_id`)
    REFERENCES `mydb`.`bbcor_bats` (`bat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bats_wood_bats1`
    FOREIGN KEY (`bat_id`)
    REFERENCES `mydb`.`wood_bats` (`bat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bats_usssa_bats1`
    FOREIGN KEY (`bat_id`)
    REFERENCES `mydb`.`usssa_bats` (`bat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
