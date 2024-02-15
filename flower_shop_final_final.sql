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
  `house_number` VARCHAR(45) NULL,
  `street_name` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state_id` INT UNSIGNED NULL,
  `zip_code` VARCHAR(45) NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_customer_state1_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_state10`
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
  `phone` VARCHAR(45) NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `fk_store_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_address1`
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
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `store_id` INT UNSIGNED NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_customer_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `flower_shop`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_store1`
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
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `role_id` INT UNSIGNED NOT NULL,
  `store_id` INT UNSIGNED NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_role_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_employee_store1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_employee_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `flower_shop`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `flower_shop`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_address1`
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
  CONSTRAINT `fk_transaction_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `flower_shop`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `flower_shop`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_employee1`
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
  CONSTRAINT `fk_delivery_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `flower_shop`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_truck1`
    FOREIGN KEY (`truck_id`)
    REFERENCES `flower_shop`.`truck` (`truck_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`order_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`order_details` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`order_details` (
  `order_product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_product_id`),
  INDEX `fk_order_has_product_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_order_has_product_order1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_has_product_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `flower_shop`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `flower_shop`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flower_shop`.`store_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `flower_shop`.`store_product` ;

CREATE TABLE IF NOT EXISTS `flower_shop`.`store_product` (
  `store_product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`store_product_id`),
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
            VALUES ('2802', 'Johnathan Junction', 'Alexville', 6,'18555');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('26497', 'Angela Walk', 'North Cole', 48,'79892');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2648', 'Laura Prairie', 'Gonzalezchester', 13,'46796');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('30735', 'Anthony Knoll', 'Roberthaven', 8,'02700');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9726', 'Schmitt Port', 'South Mariamouth', 48,'65396');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1806', 'Turner Ville', 'Randolphhaven', 18,'07569');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4021', 'Bradley Curve', 'North Emilyberg', 35,'65432');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('752', 'Andrea Flats', 'North Brittanyton', 35,'95989');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('7147', 'Kathleen Extensions', 'Flynnstad', 45,'33722');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6949', 'Donald Plain', 'Brownberg', 25,'20183');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('456', 'Contreras Dale', 'Lake Sharon', 27,'37249');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('33084', 'Sutton Valley', 'New Cherylside', 26,'71530');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('507', 'Lawrence Expressway', 'Gomezville', 50,'81975');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('356', 'Janice Route', 'East Jacqueline', 33,'65522');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('253', 'Leonard Pass', 'Moorefurt', 25,'92564');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2859', 'Sue Burgs', 'Lake Kimberlyville', 47,'92086');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('85124', 'Clarke Garden', 'Justinview', 9,'01368');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('06399', 'Jennifer Pines', 'Charlesview', 37,'66977');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('854', 'Zachary Turnpike', 'Stevensonfort', 21,'40398');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0532', 'Cesar Branch', 'Johnsontown', 27,'70198');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5731', 'Karla Island', 'Lake Jasmineside', 35,'63044');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('87505', 'Jennifer Glen', 'West Markton', 41,'38883');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2388', 'Sharp Greens', 'Pattersonborough', 17,'62755');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('794', 'Karen Orchard', 'Johnhaven', 4,'37220');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('19333', 'Tran Gardens', 'Meredithburgh', 16,'03510');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6239', 'Jacqueline Forest', 'Johnside', 11,'20092');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('211', 'Marsh Hills', 'New Sarastad', 32,'46377');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('8936', 'George Ports', 'Rachelberg', 6,'48628');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1695', 'Freeman Tunnel', 'New Gregorymouth', 1,'21323');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1764', 'Michele Knoll', 'Ashleyberg', 2,'73163');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('521', 'Joseph Springs', 'Baileybury', 41,'24854');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('58114', 'Reeves Mount', 'Port Amberhaven', 35,'67647');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6633', 'Davila Dale', 'Port Samuelton', 17,'29684');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('853', 'Eugene Estates', 'North Andrewborough', 16,'99292');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('952', 'Hector Forge', 'Fergusonview', 14,'32496');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('25774', 'Ian Square', 'Henryshire', 22,'44741');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0233', 'Haynes Shore', 'South Michael', 32,'78431');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('80994', 'Patricia Centers', 'East Shannonborough', 32,'90333');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('8372', 'Daniel Unions', 'Devinburgh', 11,'56834');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('8662', 'Fuller Lakes', 'West James', 13,'08318');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('372', 'Morgan Ford', 'Carterville', 50,'07062');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('697', 'Jones Street', 'Whitetown', 37,'37831');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9614', 'Derrick Extensions', 'Cervantesmouth', 46,'89048');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('67191', 'Hanna Loaf', 'North Wyattfort', 26,'22740');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('857', 'Harper Court', 'Higginsshire', 32,'81202');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5747', 'Powell Curve', 'West Amber', 18,'54502');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('81715', 'Duane Street', 'Derrickhaven', 33,'92176');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('79374', 'Nicholas Ville', 'West Laurie', 34,'72386');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('399', 'Aaron Roads', 'Boydberg', 42,'93260');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9375', 'Gonzalez Overpass', 'Sweeneyborough', 30,'36403');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3860', 'Yang Summit', 'Courtneyhaven', 10,'09612');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('44120', 'Stuart Green', 'North Glen', 5,'54224');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9149', 'Davis Corner', 'North Joshuamouth', 48,'29164');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('606', 'Morris Underpass', 'Schroederburgh', 11,'22070');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('48176', 'Daniel Pike', 'New Glentown', 5,'99014');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6025', 'Tony Causeway', 'Port Christinechester', 6,'56760');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6958', 'Pugh Gateway', 'Lake Hannah', 14,'08042');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('966', 'Hector Skyway', 'Lynnbury', 24,'80237');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4905', 'Kirsten Island', 'Sarahfort', 22,'02976');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('254', 'Julie Flat', 'Port Kaylee', 31,'81552');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('501', 'Hodge Inlet', 'West Judyhaven', 10,'64817');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('671', 'Simmons Mews', 'South Rebekahside', 10,'72770');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0650', 'Cassandra Views', 'New Joseph', 9,'04697');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2368', 'William Spur', 'New Ashley', 3,'63285');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('63704', 'Anna Land', 'New Gloria', 25,'22692');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('640', 'Jennifer Garden', 'Michelleborough', 16,'56253');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('51594', 'Sanchez Field', 'South Aprilburgh', 29,'74234');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0566', 'Guerra Center', 'Campbellmouth', 7,'82867');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('392', 'Poole Shores', 'South Caleb', 41,'14828');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('068', 'Lawson Lodge', 'Robinsonfort', 40,'37664');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4858', 'Garcia Views', 'East Andrewborough', 11,'72626');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4918', 'Nancy Isle', 'South Jason', 13,'38703');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('698', 'Chad Squares', 'West Tonimouth', 5,'99479');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('39418', 'Nelson Squares', 'Bruceshire', 13,'82540');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('948', 'Johnson Loop', 'Port Anthony', 21,'40410');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('302', 'Michelle Streets', 'Nicholeburgh', 30,'08733');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('198', 'Jordan Bridge', 'South Kimberly', 23,'55191');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('63268', 'Sanders Pine', 'North Benjamin', 29,'47769');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('560', 'Jackson Valleys', 'East Joseph', 5,'11469');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('07448', 'Brian Pass', 'South Courtneybury', 40,'72636');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3757', 'Caldwell Place', 'Shannonborough', 34,'56189');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('739', 'Thomas Harbor', 'Alexanderton', 44,'07928');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('205', 'Wolf Loop', 'Lake Christinachester', 12,'13143');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('174', 'Mary Islands', 'North Mariabury', 29,'26035');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('02821', 'Wagner Garden', 'North Melissa', 11,'58094');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('638', 'Wells Roads', 'West Michaelburgh', 25,'77882');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9918', 'Mallory Fork', 'South Carlos', 33,'91528');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9670', 'Crawford Springs', 'South Tammy', 16,'98516');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('794', 'Cindy Ports', 'North Nicholas', 38,'44354');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0252', 'Johnson Rue', 'Lake Chelsea', 39,'77112');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('0034', 'Ryan Keys', 'Lake Janicechester', 18,'68704');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('30670', 'Andrew Islands', 'Walkerborough', 36,'46969');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('33548', 'Guerrero Alley', 'West Jennifer', 4,'50905');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1621', 'Charles Island', 'New Erinport', 13,'38764');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('4855', 'Barnes Lodge', 'Shawnport', 6,'89462');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('248', 'Johnson Ranch', 'Port James', 19,'20769');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('72643', 'Middleton Hollow', 'Moratown', 47,'36406');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9364', 'Olsen Walk', 'Lynnmouth', 10,'35145');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('65177', 'Kristen Mill', 'Brendaland', 36,'26380');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('48986', 'Katie Island', 'South Randy', 35,'97445');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('90446', 'Marie Roads', 'New Tiffany', 27,'37114');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('93328', 'Alex Motorway', 'New Michaelfort', 5,'86371');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('13028', 'Burke Common', 'South Michaelberg', 19,'18469');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('386', 'Bennett Ferry', 'Perezburgh', 23,'90031');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('780', 'Travis Mountain', 'Scottburgh', 28,'39077');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6203', 'Tara Creek', 'Lake Matthewborough', 24,'33974');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1445', 'Shaw Mission', 'Romeroshire', 8,'71947');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('165', 'Riley Crest', 'North Haleychester', 50,'31584');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('572', 'Anderson Crest', 'Ramosmouth', 18,'32589');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('919', 'Payne Station', 'New Jay', 24,'25830');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2457', 'Alexis Gateway', 'Amandabury', 6,'37270');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3717', 'Schultz Islands', 'Moodyborough', 13,'84693');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('80174', 'Sheila Bypass', 'East Brendaport', 11,'92914');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('738', 'Buckley Squares', 'North Erin', 45,'22107');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('196', 'Eric Locks', 'Pottsfort', 10,'38377');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('22497', 'Thomas Garden', 'West Jennifertown', 37,'59445');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('41955', 'Susan Hill', 'Port Jamesville', 9,'31916');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('781', 'Moore Unions', 'New Gloriachester', 19,'10203');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3608', 'Ricky Station', 'Port Blakechester', 41,'39545');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('605', 'Kelley Vista', 'Williamville', 49,'34433');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('437', 'Leslie Walk', 'East Christopher', 24,'53171');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5046', 'Lynn Plaza', 'Amberborough', 28,'57163');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('88289', 'Michelle Forks', 'West Jodibury', 37,'50259');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5142', 'Cabrera Village', 'West Allison', 47,'75327');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3246', 'Perry Island', 'Lake Amy', 29,'55853');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9897', 'Lonnie Glens', 'Davisstad', 25,'55426');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5376', 'Kevin Squares', 'Edwardsland', 4,'03247');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('586', 'Chan Fields', 'Rodriguezmouth', 8,'10083');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('937', 'Bryan Crossing', 'Johnsonbury', 44,'90125');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('5865', 'Kenneth Station', 'North Kristen', 3,'52947');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('6004', 'Bethany Wall', 'East Kenneth', 48,'43849');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2693', 'Nicole Common', 'Port Robertburgh', 45,'87971');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('274', 'Chloe Plaza', 'Ruthview', 26,'46587');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('7855', 'Griffin Underpass', 'East Arthur', 49,'03998');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3601', 'Michael Ranch', 'South William', 5,'35002');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1674', 'Tammy Crescent', 'Moranhaven', 43,'05150');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('47600', 'Brown Mission', 'Parkerberg', 44,'92676');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('680', 'Todd Walks', 'Obrienville', 1,'08363');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('93518', 'Turner Expressway', 'Thompsonfurt', 46,'56575');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('9642', 'Best Mountain', 'North Tracishire', 37,'94348');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('906', 'Pierce Mill', 'Lake Shelby', 45,'45217');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('1719', 'Garza Viaduct', 'West Normanshire', 28,'46721');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('12584', 'Cook Lights', 'Shelleyshire', 42,'59499');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('321', 'Marilyn Pine', 'Aaronborough', 34,'16438');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('051', 'Kristina Square', 'South Jamesbury', 45,'13291');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('602', 'Jensen Loop', 'Port Anthonyborough', 27,'49079');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('83764', 'Katherine Mall', 'Port Danielburgh', 37,'63795');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('3147', 'Laura Knolls', 'West Christina', 12,'09142');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('2211', 'Diana Islands', 'South Elaineland', 7,'02240');


            INSERT INTO address (house_number, street_name, city, state_id,zip_code)
            VALUES ('745', 'Caroline Prairie', 'Lake Jessicaborough', 50,'43191');


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
            VALUES ('728-440-3843', 116);


            INSERT INTO store (phone, address_id)
            VALUES ('672-961-5386', 19);


            INSERT INTO store (phone, address_id)
            VALUES ('723-548-2579', 75);


            INSERT INTO store (phone, address_id)
            VALUES ('933-739-3974', 122);


            INSERT INTO store (phone, address_id)
            VALUES ('342-725-1015', 83);


            INSERT INTO store (phone, address_id)
            VALUES ('350-759-5214', 148);


            INSERT INTO store (phone, address_id)
            VALUES ('212-195-9775', 54);


            INSERT INTO store (phone, address_id)
            VALUES ('160-555-6771', 56);


            INSERT INTO store (phone, address_id)
            VALUES ('349-649-8987', 143);


            INSERT INTO store (phone, address_id)
            VALUES ('109-888-5269', 66);


            INSERT INTO store (phone, address_id)
            VALUES ('743-280-7775', 25);


            INSERT INTO store (phone, address_id)
            VALUES ('745-255-1630', 129);


            INSERT INTO store (phone, address_id)
            VALUES ('600-395-2202', 52);


            INSERT INTO store (phone, address_id)
            VALUES ('471-503-9028', 92);


            INSERT INTO store (phone, address_id)
            VALUES ('165-771-8025', 55);


            INSERT INTO store (phone, address_id)
            VALUES ('141-459-3586', 72);


            INSERT INTO store (phone, address_id)
            VALUES ('744-395-2270', 119);


            INSERT INTO store (phone, address_id)
            VALUES ('573-197-2521', 105);


            INSERT INTO store (phone, address_id)
            VALUES ('201-357-1333', 108);


            INSERT INTO store (phone, address_id)
            VALUES ('666-452-4895', 109);


            INSERT INTO store (phone, address_id)
            VALUES ('160-290-4511', 112);


            INSERT INTO store (phone, address_id)
            VALUES ('321-450-2262', 127);


            INSERT INTO store (phone, address_id)
            VALUES ('755-705-5813', 23);


            INSERT INTO store (phone, address_id)
            VALUES ('771-680-1193', 37);


            INSERT INTO store (phone, address_id)
            VALUES ('691-940-4304', 142);


            INSERT INTO store (phone, address_id)
            VALUES ('285-768-9524', 98);


            INSERT INTO store (phone, address_id)
            VALUES ('700-548-5182', 42);


            INSERT INTO store (phone, address_id)
            VALUES ('607-819-6989', 78);


            INSERT INTO store (phone, address_id)
            VALUES ('186-370-3226', 35);


            INSERT INTO store (phone, address_id)
            VALUES ('623-392-5784', 95);


            INSERT INTO store (phone, address_id)
            VALUES ('856-470-4262', 63);


            INSERT INTO store (phone, address_id)
            VALUES ('380-385-6927', 34);


            INSERT INTO store (phone, address_id)
            VALUES ('875-814-6756', 145);


            INSERT INTO store (phone, address_id)
            VALUES ('485-196-6269', 101);


            INSERT INTO store (phone, address_id)
            VALUES ('737-156-3088', 93);


            INSERT INTO store (phone, address_id)
            VALUES ('398-348-6364', 123);


            INSERT INTO store (phone, address_id)
            VALUES ('369-323-6782', 73);


            INSERT INTO store (phone, address_id)
            VALUES ('897-540-3210', 44);


            INSERT INTO store (phone, address_id)
            VALUES ('905-338-3726', 58);


            INSERT INTO store (phone, address_id)
            VALUES ('133-178-9815', 20);


            INSERT INTO store (phone, address_id)
            VALUES ('525-462-7982', 118);


            INSERT INTO store (phone, address_id)
            VALUES ('647-597-5977', 86);


            INSERT INTO store (phone, address_id)
            VALUES ('989-569-1487', 31);


            INSERT INTO store (phone, address_id)
            VALUES ('326-745-4979', 139);


            INSERT INTO store (phone, address_id)
            VALUES ('585-998-8149', 107);


            INSERT INTO store (phone, address_id)
            VALUES ('951-601-6923', 140);


            INSERT INTO store (phone, address_id)
            VALUES ('191-392-7384', 65);


            INSERT INTO store (phone, address_id)
            VALUES ('336-227-1509', 76);


            INSERT INTO store (phone, address_id)
            VALUES ('600-408-9340', 1);


            INSERT INTO store (phone, address_id)
            VALUES ('862-613-6616', 57);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Krista', 'Valenzuela', 1, 27, '2022-02-16', '2022-10-31', 51);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Bob', 'Cobb', 6, 4, '2016-11-08', '2016-12-06', 36);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Veronica', 'King', 3, 20, '2021-04-03', '2021-08-23', 132);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Samantha', 'Johnson', 6, 37, '2019-07-02', '2019-09-01', 70);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Chelsea', 'Watson', 3, 10, '2023-12-19', '2024-05-04', 110);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Manuel', 'Chavez', 2, 47, '2018-07-20', '2018-12-11', 41);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Scott', 'Walton', 1, 47, '2018-03-05', '2018-06-12', 97);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Ashley', 'Rojas', 3, 41, '2020-08-13', '2021-04-01', 106);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Frank', 'Sweeney', 1, 44, '2018-06-26', '2018-07-15', 80);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Wayne', 'Wright', 3, 39, '2014-06-19', '2015-02-21', 125);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Jeffery', 'Holmes', 4, 15, '2017-08-10', '2018-05-18', 81);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Kristina', 'Parker', 1, 12, '2020-07-09', '2021-06-30', 134);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Lisa', 'Schmitt', 5, 4, '2020-11-05', '2021-08-24', 2);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Jasmine', 'Patel', 6, 33, '2023-12-24', '2024-04-01', 120);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Ryan', 'Shaffer', 4, 14, '2022-01-10', '2022-07-10', 69);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Paul', 'Estrada', 1, 11, '2016-04-12', '2016-06-28', 12);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Thomas', 'Wilson', 6, 39, '2018-03-08', '2018-10-02', 111);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Brian', 'Barnett', 6, 22, '2015-06-28', '2016-06-02', 147);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Mary', 'Spears', 2, 32, '2021-12-12', '2022-02-14', 46);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Rebecca', 'Leach', 1, 35, '2015-12-08', '2016-11-28', 138);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Christy', 'Pacheco', 2, 39, '2022-11-12', '2023-03-15', 13);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Ashley', 'Hernandez', 6, 5, '2018-06-28', '2019-03-09', 136);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Nathan', 'Richard', 6, 13, '2019-09-09', '2020-06-11', 104);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Eric', 'Davis', 3, 9, '2017-05-11', '2017-12-08', 28);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Patrick', 'Garcia', 3, 45, '2021-02-08', '2021-11-23', 14);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Anne', 'Miller', 3, 15, '2019-11-03', '2020-04-17', 88);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Seth', 'Rogers', 6, 2, '2016-10-25', '2017-05-23', 89);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Jason', 'Mcmillan', 5, 50, '2018-08-22', '2019-08-12', 113);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Drew', 'Foster', 3, 39, '2023-04-09', '2023-10-08', 47);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Amanda', 'Fernandez', 4, 32, '2021-07-15', '2022-01-12', 94);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Matthew', 'Vaughn', 2, 1, '2014-11-16', '2015-07-21', 149);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Amanda', 'Savage', 6, 27, '2019-02-22', '2020-02-10', 117);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('David', 'Smith', 5, 12, '2018-10-20', '2019-08-22', 67);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Eric', 'Miller', 3, 6, '2016-12-02', '2017-09-09', 7);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Matthew', 'Duarte', 4, 23, '2021-07-20', '2022-05-26', 77);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Logan', 'Espinoza', 4, 44, '2020-09-10', '2021-06-12', 61);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Michele', 'Wagner', 6, 6, '2017-07-14', '2017-12-10', 21);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Blake', 'Benjamin', 5, 36, '2014-03-18', '2014-04-08', 17);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Dale', 'Mckenzie', 1, 46, '2022-02-08', '2023-01-19', 40);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Darren', 'Greene', 2, 1, '2022-04-24', '2023-04-06', 71);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Jonathan', 'Estrada', 1, 36, '2023-04-25', '2023-10-07', 48);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Emily', 'Arnold', 4, 40, '2018-07-26', '2019-01-01', 18);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Michelle', 'Wright', 3, 12, '2021-03-08', '2021-04-25', 124);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Alexandra', 'Stewart', 3, 41, '2017-08-17', '2018-07-20', 3);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Tanya', 'West', 5, 36, '2017-11-01', '2018-06-27', 33);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Justin', 'Baxter', 3, 41, '2019-05-12', '2020-01-02', 130);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Christopher', 'Cooper', 1, 22, '2021-01-01', '2021-07-12', 8);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Heather', 'Washington', 1, 32, '2022-06-10', '2022-09-23', 99);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Alex', 'Jackson', 6, 2, '2023-11-28', '2024-11-09', 150);


            INSERT INTO employee (first_name, last_name, role_id, store_id, start_date, end_date, address_id)
            VALUES ('Jason', 'Murray', 2, 24, '2015-01-02', '2015-10-15', 38);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Emily', 'Levy', 38, 115);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Douglas', 'Young', 12, 24);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Cesar', 'Moyer', 4, 5);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Glenn', 'Garcia', 1, 53);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Holly', 'Castro', 10, 74);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Michelle', 'Robertson', 37, 10);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('John', 'Harris', 11, 9);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Randy', 'Mills', 7, 30);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Laurie', 'Mathews', 37, 121);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jacob', 'Reid', 24, 84);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Erica', 'Luna', 3, 131);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Regina', 'Tanner', 35, 96);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Melissa', 'Sims', 39, 50);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Robin', 'Cantu', 22, 26);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('David', 'Baxter', 14, 87);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Kimberly', 'Thompson', 37, 43);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Preston', 'Stanley', 1, 100);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Christopher', 'Ayala', 37, 15);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Tracy', 'Mendoza', 25, 22);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Dana', 'Taylor', 4, 64);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Diane', 'Rios', 42, 146);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Danielle', 'Herman', 33, 29);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Rachael', 'Johnson', 34, 68);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jessica', 'Hardin', 42, 128);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Teresa', 'Roberts', 18, 135);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Kevin', 'Miller', 5, 82);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Victoria', 'Thomas', 7, 90);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Daniel', 'Gomez', 44, 49);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Melissa', 'Allen', 45, 59);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Anita', 'Boyd', 20, 103);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Tanner', 'Greene', 46, 32);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Megan', 'Wolf', 35, 144);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Frank', 'Hayes', 45, 141);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Kathy', 'Rice', 37, 126);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Todd', 'Vincent', 37, 27);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Juan', 'Rodriguez', 8, 85);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Corey', 'Montgomery', 5, 114);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Christopher', 'Joyce', 37, 39);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Carlos', 'Smith', 27, 45);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('John', 'Hunt', 40, 11);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jonathan', 'Nguyen', 49, 133);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jason', 'Huff', 7, 102);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Morgan', 'Mitchell', 35, 62);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Brandon', 'Rojas', 25, 137);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Danielle', 'May', 9, 4);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Bruce', 'Waller', 38, 91);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Nicole', 'Holmes', 15, 79);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Crystal', 'Henson', 34, 16);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Benjamin', 'Johnston', 17, 60);


            INSERT INTO customer (first_name, last_name, store_id, address_id)
            VALUES ('Jessica', 'Smith', 8, 6);
            
            
