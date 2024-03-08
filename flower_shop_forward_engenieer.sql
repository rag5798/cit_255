-- MySQL Workbench Forward Engineering -- 

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
  `date` DATETIME NULL,
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

INSERT INTO state (state_abv)
            VALUES ('AL');


            INSERT INTO state (state_abv)
            VALUES ('AK');


            INSERT INTO state (state_abv)
            VALUES ('AZ');


            INSERT INTO state (state_abv)
            VALUES ('AR');


            INSERT INTO state (state_abv)
            VALUES ('CA');


            INSERT INTO state (state_abv)
            VALUES ('CO');


            INSERT INTO state (state_abv)
            VALUES ('CT');


            INSERT INTO state (state_abv)
            VALUES ('DE');


            INSERT INTO state (state_abv)
            VALUES ('FL');


            INSERT INTO state (state_abv)
            VALUES ('GA');


            INSERT INTO state (state_abv)
            VALUES ('HI');


            INSERT INTO state (state_abv)
            VALUES ('ID');


            INSERT INTO state (state_abv)
            VALUES ('IL');


            INSERT INTO state (state_abv)
            VALUES ('IN');


            INSERT INTO state (state_abv)
            VALUES ('IA');


            INSERT INTO state (state_abv)
            VALUES ('KS');


            INSERT INTO state (state_abv)
            VALUES ('KY');


            INSERT INTO state (state_abv)
            VALUES ('LA');


            INSERT INTO state (state_abv)
            VALUES ('ME');


            INSERT INTO state (state_abv)
            VALUES ('MD');


            INSERT INTO state (state_abv)
            VALUES ('MA');


            INSERT INTO state (state_abv)
            VALUES ('MI');


            INSERT INTO state (state_abv)
            VALUES ('MN');


            INSERT INTO state (state_abv)
            VALUES ('MS');


            INSERT INTO state (state_abv)
            VALUES ('MO');


            INSERT INTO state (state_abv)
            VALUES ('MT');


            INSERT INTO state (state_abv)
            VALUES ('NE');


            INSERT INTO state (state_abv)
            VALUES ('NV');


            INSERT INTO state (state_abv)
            VALUES ('NH');


            INSERT INTO state (state_abv)
            VALUES ('NJ');


            INSERT INTO state (state_abv)
            VALUES ('NM');


            INSERT INTO state (state_abv)
            VALUES ('NY');


            INSERT INTO state (state_abv)
            VALUES ('NC');


            INSERT INTO state (state_abv)
            VALUES ('ND');


            INSERT INTO state (state_abv)
            VALUES ('OH');


            INSERT INTO state (state_abv)
            VALUES ('OK');


            INSERT INTO state (state_abv)
            VALUES ('OR');


            INSERT INTO state (state_abv)
            VALUES ('PA');


            INSERT INTO state (state_abv)
            VALUES ('RI');


            INSERT INTO state (state_abv)
            VALUES ('SC');


            INSERT INTO state (state_abv)
            VALUES ('SD');


            INSERT INTO state (state_abv)
            VALUES ('TN');


            INSERT INTO state (state_abv)
            VALUES ('TX');


            INSERT INTO state (state_abv)
            VALUES ('UT');


            INSERT INTO state (state_abv)
            VALUES ('VT');


            INSERT INTO state (state_abv)
            VALUES ('VA');


            INSERT INTO state (state_abv)
            VALUES ('WA');


            INSERT INTO state (state_abv)
            VALUES ('WV');


            INSERT INTO state (state_abv)
            VALUES ('WI');


            INSERT INTO state (state_abv)
            VALUES ('WY');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2802', 'Johnathan Junction', 'Alexville', 4,'18555');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('26497', 'Angela Walk', 'North Cole', 32,'79892');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2648', 'Laura Prairie', 'Gonzalezchester', 35,'46796');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('30735', 'Anthony Knoll', 'Roberthaven', 19,'02700');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9726', 'Schmitt Port', 'South Mariamouth', 7,'65396');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1806', 'Turner Ville', 'Randolphhaven', 20,'07569');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4021', 'Bradley Curve', 'North Emilyberg', 18,'65432');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('752', 'Andrea Flats', 'North Brittanyton', 42,'95989');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('7147', 'Kathleen Extensions', 'Flynnstad', 2,'33722');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6949', 'Donald Plain', 'Brownberg', 26,'20183');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('456', 'Contreras Dale', 'Lake Sharon', 35,'37249');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('33084', 'Sutton Valley', 'New Cherylside', 12,'71530');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('507', 'Lawrence Expressway', 'Gomezville', 18,'81975');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('356', 'Janice Route', 'East Jacqueline', 19,'65522');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('253', 'Leonard Pass', 'Moorefurt', 45,'92564');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2859', 'Sue Burgs', 'Lake Kimberlyville', 1,'92086');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('85124', 'Clarke Garden', 'Justinview', 19,'01368');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('06399', 'Jennifer Pines', 'Charlesview', 36,'66977');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('854', 'Zachary Turnpike', 'Stevensonfort', 5,'40398');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0532', 'Cesar Branch', 'Johnsontown', 8,'70198');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5731', 'Karla Island', 'Lake Jasmineside', 24,'63044');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('87505', 'Jennifer Glen', 'West Markton', 24,'38883');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2388', 'Sharp Greens', 'Pattersonborough', 38,'62755');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('794', 'Karen Orchard', 'Johnhaven', 39,'37220');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('19333', 'Tran Gardens', 'Meredithburgh', 34,'03510');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6239', 'Jacqueline Forest', 'Johnside', 19,'20092');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('211', 'Marsh Hills', 'New Sarastad', 10,'46377');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('8936', 'George Ports', 'Rachelberg', 49,'48628');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1695', 'Freeman Tunnel', 'New Gregorymouth', 27,'21323');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1764', 'Michele Knoll', 'Ashleyberg', 17,'73163');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('521', 'Joseph Springs', 'Baileybury', 31,'24854');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('58114', 'Reeves Mount', 'Port Amberhaven', 13,'67647');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6633', 'Davila Dale', 'Port Samuelton', 40,'29684');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('853', 'Eugene Estates', 'North Andrewborough', 49,'99292');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('952', 'Hector Forge', 'Fergusonview', 8,'32496');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('25774', 'Ian Square', 'Henryshire', 50,'44741');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0233', 'Haynes Shore', 'South Michael', 11,'78431');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('80994', 'Patricia Centers', 'East Shannonborough', 50,'90333');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('8372', 'Daniel Unions', 'Devinburgh', 35,'56834');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('8662', 'Fuller Lakes', 'West James', 32,'08318');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('372', 'Morgan Ford', 'Carterville', 1,'07062');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('697', 'Jones Street', 'Whitetown', 18,'37831');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9614', 'Derrick Extensions', 'Cervantesmouth', 38,'89048');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('67191', 'Hanna Loaf', 'North Wyattfort', 11,'22740');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('857', 'Harper Court', 'Higginsshire', 25,'81202');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5747', 'Powell Curve', 'West Amber', 32,'54502');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('81715', 'Duane Street', 'Derrickhaven', 31,'92176');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('79374', 'Nicholas Ville', 'West Laurie', 21,'72386');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('399', 'Aaron Roads', 'Boydberg', 42,'93260');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9375', 'Gonzalez Overpass', 'Sweeneyborough', 49,'36403');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3860', 'Yang Summit', 'Courtneyhaven', 13,'09612');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('44120', 'Stuart Green', 'North Glen', 12,'54224');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9149', 'Davis Corner', 'North Joshuamouth', 39,'29164');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('606', 'Morris Underpass', 'Schroederburgh', 5,'22070');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('48176', 'Daniel Pike', 'New Glentown', 6,'99014');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6025', 'Tony Causeway', 'Port Christinechester', 47,'56760');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6958', 'Pugh Gateway', 'Lake Hannah', 27,'08042');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('966', 'Hector Skyway', 'Lynnbury', 25,'80237');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4905', 'Kirsten Island', 'Sarahfort', 32,'02976');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('254', 'Julie Flat', 'Port Kaylee', 33,'81552');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('501', 'Hodge Inlet', 'West Judyhaven', 12,'64817');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('671', 'Simmons Mews', 'South Rebekahside', 2,'72770');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0650', 'Cassandra Views', 'New Joseph', 14,'04697');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2368', 'William Spur', 'New Ashley', 41,'63285');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('63704', 'Anna Land', 'New Gloria', 36,'22692');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('640', 'Jennifer Garden', 'Michelleborough', 37,'56253');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('51594', 'Sanchez Field', 'South Aprilburgh', 12,'74234');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0566', 'Guerra Center', 'Campbellmouth', 1,'82867');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('392', 'Poole Shores', 'South Caleb', 4,'14828');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('068', 'Lawson Lodge', 'Robinsonfort', 23,'37664');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4858', 'Garcia Views', 'East Andrewborough', 14,'72626');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4918', 'Nancy Isle', 'South Jason', 33,'38703');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('698', 'Chad Squares', 'West Tonimouth', 13,'99479');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('39418', 'Nelson Squares', 'Bruceshire', 31,'82540');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('948', 'Johnson Loop', 'Port Anthony', 46,'40410');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('302', 'Michelle Streets', 'Nicholeburgh', 4,'08733');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('198', 'Jordan Bridge', 'South Kimberly', 43,'55191');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('63268', 'Sanders Pine', 'North Benjamin', 26,'47769');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('560', 'Jackson Valleys', 'East Joseph', 36,'11469');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('07448', 'Brian Pass', 'South Courtneybury', 45,'72636');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3757', 'Caldwell Place', 'Shannonborough', 34,'56189');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('739', 'Thomas Harbor', 'Alexanderton', 45,'07928');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('205', 'Wolf Loop', 'Lake Christinachester', 13,'13143');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('174', 'Mary Islands', 'North Mariabury', 31,'26035');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('02821', 'Wagner Garden', 'North Melissa', 7,'58094');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('638', 'Wells Roads', 'West Michaelburgh', 2,'77882');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9918', 'Mallory Fork', 'South Carlos', 20,'91528');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9670', 'Crawford Springs', 'South Tammy', 18,'98516');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('794', 'Cindy Ports', 'North Nicholas', 10,'44354');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0252', 'Johnson Rue', 'Lake Chelsea', 20,'77112');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0034', 'Ryan Keys', 'Lake Janicechester', 49,'68704');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('30670', 'Andrew Islands', 'Walkerborough', 48,'46969');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('33548', 'Guerrero Alley', 'West Jennifer', 25,'50905');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1621', 'Charles Island', 'New Erinport', 21,'38764');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4855', 'Barnes Lodge', 'Shawnport', 3,'89462');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('248', 'Johnson Ranch', 'Port James', 13,'20769');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('72643', 'Middleton Hollow', 'Moratown', 36,'36406');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9364', 'Olsen Walk', 'Lynnmouth', 32,'35145');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('65177', 'Kristen Mill', 'Brendaland', 28,'26380');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('48986', 'Katie Island', 'South Randy', 3,'97445');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('90446', 'Marie Roads', 'New Tiffany', 17,'37114');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('93328', 'Alex Motorway', 'New Michaelfort', 40,'86371');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('13028', 'Burke Common', 'South Michaelberg', 24,'18469');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('386', 'Bennett Ferry', 'Perezburgh', 1,'90031');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('780', 'Travis Mountain', 'Scottburgh', 37,'39077');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6203', 'Tara Creek', 'Lake Matthewborough', 36,'33974');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1445', 'Shaw Mission', 'Romeroshire', 47,'71947');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('165', 'Riley Crest', 'North Haleychester', 46,'31584');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('572', 'Anderson Crest', 'Ramosmouth', 26,'32589');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('919', 'Payne Station', 'New Jay', 17,'25830');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2457', 'Alexis Gateway', 'Amandabury', 2,'37270');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3717', 'Schultz Islands', 'Moodyborough', 14,'84693');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('80174', 'Sheila Bypass', 'East Brendaport', 10,'92914');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('738', 'Buckley Squares', 'North Erin', 30,'22107');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('196', 'Eric Locks', 'Pottsfort', 34,'38377');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('22497', 'Thomas Garden', 'West Jennifertown', 8,'59445');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('41955', 'Susan Hill', 'Port Jamesville', 42,'31916');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('781', 'Moore Unions', 'New Gloriachester', 12,'10203');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3608', 'Ricky Station', 'Port Blakechester', 8,'39545');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('605', 'Kelley Vista', 'Williamville', 8,'34433');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('437', 'Leslie Walk', 'East Christopher', 42,'53171');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5046', 'Lynn Plaza', 'Amberborough', 48,'57163');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('88289', 'Michelle Forks', 'West Jodibury', 39,'50259');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5142', 'Cabrera Village', 'West Allison', 39,'75327');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3246', 'Perry Island', 'Lake Amy', 34,'55853');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9897', 'Lonnie Glens', 'Davisstad', 12,'55426');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5376', 'Kevin Squares', 'Edwardsland', 39,'03247');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('586', 'Chan Fields', 'Rodriguezmouth', 21,'10083');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('937', 'Bryan Crossing', 'Johnsonbury', 45,'90125');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5865', 'Kenneth Station', 'North Kristen', 27,'52947');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6004', 'Bethany Wall', 'East Kenneth', 50,'43849');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2693', 'Nicole Common', 'Port Robertburgh', 45,'87971');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('274', 'Chloe Plaza', 'Ruthview', 15,'46587');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('7855', 'Griffin Underpass', 'East Arthur', 32,'03998');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3601', 'Michael Ranch', 'South William', 44,'35002');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1674', 'Tammy Crescent', 'Moranhaven', 42,'05150');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('47600', 'Brown Mission', 'Parkerberg', 50,'92676');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('680', 'Todd Walks', 'Obrienville', 10,'08363');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('93518', 'Turner Expressway', 'Thompsonfurt', 32,'56575');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9642', 'Best Mountain', 'North Tracishire', 27,'94348');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('906', 'Pierce Mill', 'Lake Shelby', 11,'45217');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1719', 'Garza Viaduct', 'West Normanshire', 30,'46721');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('12584', 'Cook Lights', 'Shelleyshire', 17,'59499');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('321', 'Marilyn Pine', 'Aaronborough', 6,'16438');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('051', 'Kristina Square', 'South Jamesbury', 29,'13291');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('602', 'Jensen Loop', 'Port Anthonyborough', 29,'49079');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('83764', 'Katherine Mall', 'Port Danielburgh', 29,'63795');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3147', 'Laura Knolls', 'West Christina', 8,'09142');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2211', 'Diana Islands', 'South Elaineland', 28,'02240');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('745', 'Caroline Prairie', 'Lake Jessicaborough', 6,'43191');


            INSERT INTO role (role_name)
            VALUES ('Store Manager');


            INSERT INTO role (role_name)
            VALUES ('Assistant Store Manager');


            INSERT INTO role (role_name)
            VALUES ('Department Manager');


            INSERT INTO role (role_name)
            VALUES ('Cashier');


            INSERT INTO role (role_name)
            VALUES ('Sales Associate');


            INSERT INTO role (role_name)
            VALUES ('Stock Clerk');


            INSERT INTO store (phone, address_id)
            VALUES ('728-440-3843', 35);


            INSERT INTO store (phone, address_id)
            VALUES ('672-961-5386', 25);


            INSERT INTO store (phone, address_id)
            VALUES ('723-548-2579', 12);


            INSERT INTO store (phone, address_id)
            VALUES ('933-739-3974', 36);


            INSERT INTO store (phone, address_id)
            VALUES ('342-725-1015', 128);


            INSERT INTO store (phone, address_id)
            VALUES ('350-759-5214', 96);


            INSERT INTO store (phone, address_id)
            VALUES ('212-195-9775', 15);


            INSERT INTO store (phone, address_id)
            VALUES ('160-555-6771', 117);


            INSERT INTO store (phone, address_id)
            VALUES ('349-649-8987', 50);


            INSERT INTO store (phone, address_id)
            VALUES ('109-888-5269', 146);


            INSERT INTO store (phone, address_id)
            VALUES ('743-280-7775', 100);


            INSERT INTO store (phone, address_id)
            VALUES ('745-255-1630', 32);


            INSERT INTO store (phone, address_id)
            VALUES ('600-395-2202', 58);


            INSERT INTO store (phone, address_id)
            VALUES ('471-503-9028', 137);


            INSERT INTO store (phone, address_id)
            VALUES ('165-771-8025', 29);


            INSERT INTO store (phone, address_id)
            VALUES ('141-459-3586', 112);


            INSERT INTO store (phone, address_id)
            VALUES ('744-395-2270', 17);


            INSERT INTO store (phone, address_id)
            VALUES ('573-197-2521', 51);


            INSERT INTO store (phone, address_id)
            VALUES ('201-357-1333', 136);


            INSERT INTO store (phone, address_id)
            VALUES ('666-452-4895', 37);


            INSERT INTO store (phone, address_id)
            VALUES ('160-290-4511', 90);


            INSERT INTO store (phone, address_id)
            VALUES ('321-450-2262', 119);


            INSERT INTO store (phone, address_id)
            VALUES ('755-705-5813', 55);


            INSERT INTO store (phone, address_id)
            VALUES ('771-680-1193', 3);


            INSERT INTO store (phone, address_id)
            VALUES ('691-940-4304', 131);


            INSERT INTO store (phone, address_id)
            VALUES ('285-768-9524', 59);


            INSERT INTO store (phone, address_id)
            VALUES ('700-548-5182', 135);


            INSERT INTO store (phone, address_id)
            VALUES ('607-819-6989', 113);


            INSERT INTO store (phone, address_id)
            VALUES ('186-370-3226', 105);


            INSERT INTO store (phone, address_id)
            VALUES ('623-392-5784', 126);


            INSERT INTO store (phone, address_id)
            VALUES ('856-470-4262', 48);


            INSERT INTO store (phone, address_id)
            VALUES ('380-385-6927', 4);


            INSERT INTO store (phone, address_id)
            VALUES ('875-814-6756', 72);


            INSERT INTO store (phone, address_id)
            VALUES ('485-196-6269', 104);


            INSERT INTO store (phone, address_id)
            VALUES ('737-156-3088', 52);


            INSERT INTO store (phone, address_id)
            VALUES ('398-348-6364', 67);


            INSERT INTO store (phone, address_id)
            VALUES ('369-323-6782', 97);


            INSERT INTO store (phone, address_id)
            VALUES ('897-540-3210', 118);


            INSERT INTO store (phone, address_id)
            VALUES ('905-338-3726', 103);


            INSERT INTO store (phone, address_id)
            VALUES ('133-178-9815', 109);


            INSERT INTO store (phone, address_id)
            VALUES ('525-462-7982', 132);


            INSERT INTO store (phone, address_id)
            VALUES ('647-597-5977', 111);


            INSERT INTO store (phone, address_id)
            VALUES ('989-569-1487', 53);


            INSERT INTO store (phone, address_id)
            VALUES ('326-745-4979', 142);


            INSERT INTO store (phone, address_id)
            VALUES ('585-998-8149', 80);


            INSERT INTO store (phone, address_id)
            VALUES ('951-601-6923', 148);


            INSERT INTO store (phone, address_id)
            VALUES ('191-392-7384', 130);


            INSERT INTO store (phone, address_id)
            VALUES ('336-227-1509', 85);


            INSERT INTO store (phone, address_id)
            VALUES ('600-408-9340', 140);


            INSERT INTO store (phone, address_id)
            VALUES ('862-613-6616', 8);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Krista', 'Valenzuela', 5, '2022-02-16', '2022-10-31', 123);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Bob', 'Cobb', 4, '2016-11-08', '2016-12-06', 49);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Veronica', 'King', 3, '2021-04-03', '2021-08-23', 133);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Samantha', 'Johnson', 1, '2019-07-02', '2019-09-01', 144);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Chelsea', 'Watson', 4, '2023-12-19', '2024-05-04', 87);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Manuel', 'Chavez', 3, '2018-07-20', '2018-12-11', 95);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Scott', 'Walton', 1, '2018-03-05', '2018-06-12', 86);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Ashley', 'Rojas', 1, '2020-08-13', '2021-04-01', 145);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Frank', 'Sweeney', 4, '2018-06-26', '2018-07-15', 2);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Wayne', 'Wright', 5, '2014-06-19', '2015-02-21', 93);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Jeffery', 'Holmes', 3, '2017-08-10', '2018-05-18', 107);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Kristina', 'Parker', 3, '2020-07-09', '2021-06-30', 138);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Lisa', 'Schmitt', 5, '2020-11-05', '2021-08-24', 31);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Jasmine', 'Patel', 1, '2023-12-24', '2024-04-01', 26);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Ryan', 'Shaffer', 5, '2022-01-10', '2022-07-10', 66);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Paul', 'Estrada', 3, '2016-04-12', '2016-06-28', 27);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Thomas', 'Wilson', 2, '2018-03-08', '2018-10-02', 68);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Brian', 'Barnett', 3, '2015-06-28', '2016-06-02', 143);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Mary', 'Spears', 3, '2021-12-12', '2022-02-14', 84);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Rebecca', 'Leach', 2, '2015-12-08', '2016-11-28', 115);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Christy', 'Pacheco', 3, '2022-11-12', '2023-03-15', 82);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Ashley', 'Hernandez', 4, '2018-06-28', '2019-03-09', 147);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Nathan', 'Richard', 4, '2019-09-09', '2020-06-11', 28);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Eric', 'Davis', 1, '2017-05-11', '2017-12-08', 108);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Patrick', 'Garcia', 6, '2021-02-08', '2021-11-23', 9);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Anne', 'Miller', 5, '2019-11-03', '2020-04-17', 76);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Seth', 'Rogers', 2, '2016-10-25', '2017-05-23', 106);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Jason', 'Mcmillan', 3, '2018-08-22', '2019-08-12', 57);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Drew', 'Foster', 5, '2023-04-09', '2023-10-08', 62);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Amanda', 'Fernandez', 6, '2021-07-15', '2022-01-12', 38);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Matthew', 'Vaughn', 2, '2014-11-16', '2015-07-21', 70);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Amanda', 'Savage', 4, '2019-02-22', '2020-02-10', 149);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('David', 'Smith', 3, '2018-10-20', '2019-08-22', 19);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Eric', 'Miller', 1, '2016-12-02', '2017-09-09', 39);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Matthew', 'Duarte', 6, '2021-07-20', '2022-05-26', 10);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Logan', 'Espinoza', 5, '2020-09-10', '2021-06-12', 77);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Michele', 'Wagner', 3, '2017-07-14', '2017-12-10', 69);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Blake', 'Benjamin', 5, '2014-03-18', '2014-04-08', 13);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Dale', 'Mckenzie', 2, '2022-02-08', '2023-01-19', 129);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Darren', 'Greene', 6, '2022-04-24', '2023-04-06', 40);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Jonathan', 'Estrada', 1, '2023-04-25', '2023-10-07', 24);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Emily', 'Arnold', 3, '2018-07-26', '2019-01-01', 83);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Michelle', 'Wright', 2, '2021-03-08', '2021-04-25', 22);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Alexandra', 'Stewart', 4, '2017-08-17', '2018-07-20', 116);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Tanya', 'West', 5, '2017-11-01', '2018-06-27', 7);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Justin', 'Baxter', 3, '2019-05-12', '2020-01-02', 45);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Christopher', 'Cooper', 3, '2021-01-01', '2021-07-12', 141);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Heather', 'Washington', 3, '2022-06-10', '2022-09-23', 114);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Alex', 'Jackson', 1, '2023-11-28', '2024-11-09', 63);


            INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
            VALUES ('Jason', 'Murray', 3, '2015-01-02', '2015-10-15', 65);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Emily', 'Levy', 36, 1);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Douglas', 'Young', 48, 125);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Cesar', 'Moyer', 2, 91);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Glenn', 'Garcia', 16, 110);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Holly', 'Castro', 48, 5);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Michelle', 'Robertson', 40, 122);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('John', 'Harris', 1, 43);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Randy', 'Mills', 9, 11);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Laurie', 'Mathews', 6, 23);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jacob', 'Reid', 32, 60);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Erica', 'Luna', 15, 92);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Regina', 'Tanner', 7, 127);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Melissa', 'Sims', 26, 71);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Robin', 'Cantu', 42, 33);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('David', 'Baxter', 2, 120);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Kimberly', 'Thompson', 48, 73);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Preston', 'Stanley', 15, 42);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Christopher', 'Ayala', 13, 20);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Tracy', 'Mendoza', 33, 46);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Dana', 'Taylor', 9, 134);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Diane', 'Rios', 37, 56);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Danielle', 'Herman', 45, 6);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Rachael', 'Johnson', 21, 99);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jessica', 'Hardin', 19, 54);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Teresa', 'Roberts', 46, 14);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Kevin', 'Miller', 30, 89);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Victoria', 'Thomas', 21, 44);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Daniel', 'Gomez', 26, 61);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Melissa', 'Allen', 24, 88);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Anita', 'Boyd', 34, 47);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Tanner', 'Greene', 11, 102);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Megan', 'Wolf', 15, 81);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Frank', 'Hayes', 12, 64);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Kathy', 'Rice', 24, 30);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Todd', 'Vincent', 32, 124);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Juan', 'Rodriguez', 31, 34);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Corey', 'Montgomery', 2, 94);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Christopher', 'Joyce', 45, 101);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Carlos', 'Smith', 43, 150);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('John', 'Hunt', 45, 16);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jonathan', 'Nguyen', 42, 121);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jason', 'Huff', 48, 41);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Morgan', 'Mitchell', 12, 98);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Brandon', 'Rojas', 40, 21);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Danielle', 'May', 8, 139);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Bruce', 'Waller', 21, 78);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Nicole', 'Holmes', 33, 74);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Crystal', 'Henson', 12, 75);

            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Benjamin', 'Johnston', 27, 79);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jessica', 'Smith', 36, 18);
      

-- ------------------------------------------------ -- 
--    Needs Inserts put in as of March 08 2024      --
-- ------------------------------------------------- -- 
SELECT * FROM delivery; -- still needs to insert
SELECT * FROM discount; -- Still needs to insert
SELECT * FROM inventory; -- Still need to insert 
SELECT * FROM item_type; -- Still need to insert
SELECT * FROM occation;-- Still needs insert
SELECT * FROM order_line; -- Still needs insert 
SELECT * FROM product; -- Still need to insert
SELECT * FROM store_employee; -- Still need to insert 
SELECT * FROM truck; -- Still need to insert




-- --------------------------------------------------- --
-- 		double check the table name is okay to use	   --
-- --------------------------------------------------- --
SELECT * FROM role;
SELECT * FROM order; 

-- -------------- --
-- Tables work --
-- -------------- --
SELECT * FROM employee;


-- -------------------
-- Playing around --
-- -------------- --




