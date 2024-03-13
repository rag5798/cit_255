-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flower_shop
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `flower_shop` ;

-- -----------------------------------------------------
-- Schema flower_shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flower_shop` DEFAULT CHARACTER SET utf8 ;
USE `flower_shop` ;

-- -----------------------------------------------------
-- Table `flower_shop`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`state` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`state` (
  `state_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `state_abv` CHAR(2) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`address` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`address` (
  `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `house_number` VARCHAR(45) NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) BINARY NOT NULL,
  `state_id` INT UNSIGNED NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_customer_state1_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `address_fk1`
    FOREIGN KEY (`state_id`)
    REFERENCES `flower_shop`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`store` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`store` (
  `store_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(20) NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `fk_store_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `store_fk1`
    FOREIGN KEY (`address_id`)
    REFERENCES `flower_shop`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`customer` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`customer` (
  `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `store_id` INT UNSIGNED NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_customer_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `customer_fk1`
    FOREIGN KEY (`address_id`)
    REFERENCES `flower_shop`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_fk2`
    FOREIGN KEY (`store_id`)
    REFERENCES `flower_shop`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`role` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`role` (
  `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`employee` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`employee` (
  `employee_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_role_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_employee_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `employee_fk1`
    FOREIGN KEY (`role_id`)
    REFERENCES `flower_shop`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_fk3`
    FOREIGN KEY (`address_id`)
    REFERENCES `flower_shop`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`order` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`order` (
  `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_id` INT UNSIGNED NOT NULL,
  `employee_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `date` DATETIME NOT NULL,
  `total` DOUBLE(10,2) UNSIGNED NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_transaction_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_transaction_store1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_order_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `order_fk1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `flower_shop`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_fk2`
    FOREIGN KEY (`store_id`)
    REFERENCES `flower_shop`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_fk3`
    FOREIGN KEY (`employee_id`)
    REFERENCES `flower_shop`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`occation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`occation` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`occation` (
  `occation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `occation_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`occation_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`item_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`item_type` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`item_type` (
  `item_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`item_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`product` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`product` (
  `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `price` DOUBLE(10,2) NULL,
  `occation_id` INT UNSIGNED NOT NULL,
  `item_type_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_occation1_idx` (`occation_id` ASC) VISIBLE,
  INDEX `fk_product_item_type1_idx` (`item_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_occation1`
    FOREIGN KEY (`occation_id`)
    REFERENCES `flower_shop`.`occation` (`occation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_item_type1`
    FOREIGN KEY (`item_type_id`)
    REFERENCES `flower_shop`.`item_type` (`item_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`truck`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`truck` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`truck` (
  `truck_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `license_plate` VARCHAR(45) NOT NULL,
  `make` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`truck_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`delivery` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`delivery` (
  `delivery_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` INT UNSIGNED NOT NULL,
  `truck_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `fk_delivery_order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_delivery_truck1_idx` (`truck_id` ASC) VISIBLE,
  CONSTRAINT `delivery_fk1`
    FOREIGN KEY (`order_id`)
    REFERENCES `flower_shop`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `delivery_fk2`
    FOREIGN KEY (`truck_id`)
    REFERENCES `flower_shop`.`truck` (`truck_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`inventory` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`inventory` (
  `inventory_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_inventory_store1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_inventory_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `flower_shop`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `flower_shop`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`order_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`order_line` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`order_line` (
  `order_line_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_line_id`),
  INDEX `fk_order_line_order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_line_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_line_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `flower_shop`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_line_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `flower_shop`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`store_employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`store_employee` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`store_employee` (
  `store_employee_id` INT NOT NULL,
  `employee_id` INT UNSIGNED NOT NULL,
  `store_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`store_employee_id`),
  INDEX `fk_store_employee_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_store_employee_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_employee_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `flower_shop`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_employee_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `flower_shop`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`discount` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`discount` (
  `discount_id` INT NOT NULL,
  `discount` DECIMAL(2,2) NOT NULL,
  PRIMARY KEY (`discount_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`customer_employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`customer_employee` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`customer_employee` (
  `customer_employee_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT UNSIGNED NOT NULL,
  `employee_id` INT UNSIGNED NOT NULL,
  `discount_id` INT NOT NULL,
  PRIMARY KEY (`customer_employee_id`),
  INDEX `fk_customer_employee_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_customer_employee_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_customer_employee_discount1_idx` (`discount_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_employee_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `flower_shop`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_employee_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `flower_shop`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_employee_discount1`
    FOREIGN KEY (`discount_id`)
    REFERENCES `flower_shop`.`discount` (`discount_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
