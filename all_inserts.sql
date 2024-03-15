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
  `date` DATE NOT NULL,
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
  `store_employee_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` INT UNSIGNED NOT NULL,
  `store_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`store_employee_id`),
  INDEX `fk_store_employee_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_store_employee_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `store_employee_fk1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `flower_shop`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `store_employee_fk2`
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
  `discount_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `discount_id` INT UNSIGNED NOT NULL,
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





use flower_shop;
-- ------------------------------------------------ -- 
--    Needs Inserts put in as of March 08 2024      --
-- ------------------------------------------------- -- 
-- SELECT * FROM delivery; -- still needs to insert
-- SELECT * FROM discount; -- Still needs to insert
-- SELECT * FROM inventory; -- Still need to insert 
-- SELECT * FROM item_type; -- Still need to insert
-- SELECT * FROM occation;-- Still needs insert
-- SELECT * FROM order_line; -- Still needs insert 
-- SELECT * FROM product; -- Still need to insert
-- SELECT * FROM store_employee; -- Still need to insert 
-- SELECT * FROM truck; -- Still need to insert



-- --------------------------------------------------- --
-- 		double check the table name is okay to use	   --
-- --------------------------------------------------- --
-- SELECT * FROM role;

-- -------------- --
-- Tables work --
-- -------------- --
-- SELECT * FROM employee;


-- -------------------
-- Playing around --
-- -------------- –

-- —------------------------
-- Cayleigh's attempt at inserts —--
-- —------------------------------
INSERT INTO discount (discount) VALUES (0.05);

INSERT INTO discount (discount) VALUES (0.10);

INSERT INTO discount (discount) VALUES (0.15);

SELECT * FROM discount;




INSERT INTO state VALUES (default, 'PA');

INSERT INTO state VALUES (default, 'ID');

INSERT INTO state VALUES (default, 'AZ');

SELECT * FROM state;


INSERT INTO address VALUES (default, 36, 'Random Street', 'Pittsburgh', (SELECT state_id FROM state WHERE state_abv = 'PA'), '15009');

INSERT INTO address VALUES (default, 6, 'Anonymous Avenue', 'Rexburgh', (SELECT state_id FROM state WHERE state_abv = 'ID'), '84430');

INSERT INTO address VALUES (default, 6, 'Default Boulevard', 'Phoenix', (SELECT state_id FROM state WHERE state_abv = 'AZ'), '85001');

INSERT INTO address VALUES (default, 6, 'Big Boulevard', 'Rexburgh', (SELECT state_id FROM state WHERE state_abv = 'ID'), '84430');

INSERT INTO address VALUES (default, 6, 'Google Street', 'Phoenix', (SELECT state_id FROM state WHERE state_abv = 'AZ'), '85001');

INSERT INTO address VALUES (default, 6, 'Clemente Street', 'Pittsburgh', (SELECT state_id FROM state WHERE state_abv = 'PA'), '85001');

INSERT INTO address VALUES (default, '2802', 'Johnathan Junction', 'Alexville', (SELECT state_id FROM state WHERE state_abv = 'PA'),'18555');

INSERT INTO address VALUES (default, '26497', 'Angela Walk', 'North Cole', (SELECT state_id FROM state WHERE state_abv = 'ID'),'79892');

INSERT INTO address VALUES (default, '2648', 'Laura Prairie', 'Gonzalezchester', (SELECT state_id FROM state WHERE state_abv = 'AZ'),'46796');

SELECT * FROM address;



INSERT INTO store VALUES (default, '724-890-9190', (SELECT address_id FROM address WHERE city = 'Rexburgh' and street_name = 'Anonymous Avenue'));

INSERT INTO store VALUES (default, '800-192-7392', (SELECT address_id FROM address WHERE city = 'Phoenix' and street_name = 'Default Boulevard'));

INSERT INTO store VALUES (default, '724-890-9190', (SELECT address_id FROM address WHERE city = 'Pittsburgh' and street_name = 'Random Street'));

SELECT * FROM store;



INSERT INTO customer (first_name, last_name, store_id, address_id) VALUES ('Emily', 'Levy', (SELECT store_id FROM store s LEFT OUTER JOIN address a ON a.address_id = s.address_id WHERE city = 'Pittsburgh'), (SELECT address_id FROM address WHERE city = 'Pittsburgh' and street_name = 'Clemente Street'));

INSERT INTO customer (first_name, last_name, store_id, address_id) VALUES ('Douglas', 'Young', (SELECT store_id FROM store s LEFT OUTER JOIN address a ON a.address_id = s.address_id WHERE city = 'Phoenix'), (SELECT address_id FROM address WHERE city = 'Phoenix' and street_name = 'Google Street'));


INSERT INTO customer (first_name, last_name, store_id, address_id) VALUES ('Cesar', 'Moyer', (SELECT store_id FROM store s LEFT OUTER JOIN address a ON a.address_id = s.address_id WHERE city = 'Rexburgh'),(SELECT address_id FROM address WHERE city = 'Rexburgh' and street_name = 'Big Boulevard'));

INSERT INTO customer (first_name, last_name, store_id, address_id)
VALUES ('Jason', 'Murray', (SELECT store_id FROM store WHERE address_id = (SELECT address_id FROM address WHERE city = 'Phoenix' and street_name = 'Default Boulevard')), (SELECT address_id FROM address WHERE city = 'Gonzalezchester' and street_name = 'Laura Prairie'));

INSERT INTO customer (first_name, last_name, store_id, address_id)
VALUES ('Alex', 'Jackson', (SELECT store_id FROM store WHERE address_id = (SELECT address_id FROM address WHERE city = 'Rexburgh' and street_name = 'Anonymous Avenue')), (SELECT address_id FROM address WHERE city = 'North Cole' and street_name = 'Angela Walk'));

INSERT INTO customer (first_name, last_name, store_id, address_id)
VALUES ('Heather', 'Washington', (SELECT store_id FROM store WHERE address_id = (SELECT address_id FROM address WHERE city = 'Pittsburgh' and street_name = 'Random Street')), (SELECT address_id FROM address WHERE city = 'Alexville' and street_name = 'Johnathan Junction'));

SELECT * FROM customer;




INSERT INTO role (role_name) VALUES ('Cashier');

INSERT INTO role (role_name) VALUES ('Manager');

INSERT INTO role (role_name) VALUES ('Floral Designer');

SELECT * FROM role;



INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
VALUES ('Heather', 'Washington', (SELECT role_id FROM role WHERE role_name = 'Cashier'), '2022-06-10', '2022-09-23', (SELECT address_id FROM address WHERE city = 'Alexville' and street_name = 'Johnathan Junction'));


INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
VALUES ('Alex', 'Jackson', (SELECT role_id FROM role WHERE role_name = 'Manager'), '2023-11-28', '2024-11-09', (SELECT address_id FROM address WHERE city = 'North Cole' and street_name = 'Angela Walk'));


INSERT INTO employee (first_name, last_name, role_id, start_date, end_date, address_id)
VALUES ('Jason', 'Murray', (SELECT role_id FROM role WHERE role_name = 'Floral Designer'), '2015-01-02', '2015-10-15', (SELECT address_id FROM address WHERE city = 'Gonzalezchester' and street_name = 'Laura Prairie'));

SELECT * FROM employee;


INSERT INTO store_employee (employee_id, store_id) VALUES ((SELECT employee_id FROM employee WHERE first_name = 'Heather' and last_name = 'Washington' and role_id = (SELECT role_id FROM role WHERE role_name = 'Cashier')), (SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.address_id INNER JOIN state st ON st.state_id = a.state_id WHERE state_abv = (SELECT state_abv FROM employee e INNER JOIN address a ON e.address_id = a.address_id INNER JOIN state st ON st.state_id = a.state_id WHERE e.first_name = 'Heather')));

INSERT INTO store_employee (employee_id, store_id) VALUES ((SELECT employee_id FROM employee WHERE first_name = 'Alex' and last_name = 'Jackson' and role_id = (SELECT role_id FROM role WHERE role_name = 'Manager')), (SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.address_id INNER JOIN state st ON st.state_id = a.state_id WHERE state_abv = (SELECT state_abv FROM employee e INNER JOIN address a ON e.address_id = a.address_id INNER JOIN state st ON st.state_id = a.state_id WHERE e.first_name = 'Alex')));

INSERT INTO store_employee (employee_id, store_id) VALUES ((SELECT employee_id FROM employee WHERE first_name = 'Jason' and last_name = 'Murray' and role_id = (SELECT role_id FROM role WHERE role_name = 'Floral Designer')), (SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.address_id INNER JOIN state st ON st.state_id = a.state_id WHERE state_abv = (SELECT state_abv FROM employee e INNER JOIN address a ON e.address_id = a.address_id INNER JOIN state st ON st.state_id = a.state_id WHERE e.first_name = 'Jason')));

SELECT * FROM store_employee;


INSERT INTO customer_employee (customer_id, employee_id, discount_id) VALUES ((SELECT customer_id FROM customer WHERE first_name = 'Heather' and first_name IN (SELECT first_name FROM employee)), (SELECT employee_id FROM employee WHERE first_name = 'Heather' and last_name = 'Washington'), (SELECT discount_id FROM discount d CROSS JOIN employee e WHERE role_id = (SELECT role_id FROM role WHERE role_name = 'Cashier') and discount = 0.05));

INSERT INTO customer_employee (customer_id, employee_id, discount_id) VALUES ((SELECT customer_id FROM customer WHERE first_name = 'Heather' and first_name IN (SELECT first_name FROM employee)), (SELECT employee_id FROM employee WHERE first_name = 'Heather' and last_name = 'Washington'), (SELECT discount_id FROM discount d CROSS JOIN employee e WHERE role_id = (SELECT role_id FROM role WHERE role_name = 'Manager') and discount = 0.10));

INSERT INTO customer_employee (customer_id, employee_id, discount_id) VALUES ((SELECT customer_id FROM customer WHERE first_name = 'Heather' and first_name IN (SELECT first_name FROM employee)), (SELECT employee_id FROM employee WHERE first_name = 'Heather' and last_name = 'Washington'), (SELECT discount_id FROM discount d CROSS JOIN employee e WHERE role_id = (SELECT role_id FROM role WHERE role_name = 'Floral Designer') and discount = 0.15));

SELECT * FROM customer_employee;



INSERT INTO occation (occation_name) VALUES ('Birthday');

INSERT INTO occation (occation_name) VALUES ('Valintine');

INSERT INTO occation (occation_name) VALUES ('Anniversary');

SELECT * FROM occation;



INSERT INTO item_type (item_name) VALUES ('Flower');

INSERT INTO item_type (item_name) VALUES ('Ballon');

INSERT INTO item_type (item_name) VALUES ('Valintine\'s Bouquet');

SELECT * FROM item_type;



INSERT INTO product (name, price, occation_id, item_type_id) VALUES ('Helium Ballon', 12.99, (SELECT occation_id FROM occation WHERE occation_name = 'Birthday'), (SELECT item_type_id FROM item_type WHERE item_name = 'Ballon'));

INSERT INTO product (name, price, occation_id, item_type_id) VALUES ('Roses', 3.99, (SELECT occation_id FROM occation WHERE occation_name = 'Anniversary'), (SELECT item_type_id FROM item_type WHERE item_name = 'Flower'));

INSERT INTO product (name, price, occation_id, item_type_id) VALUES ('Roses with Gypsophila', 19.99, (SELECT occation_id FROM occation WHERE occation_name = 'Anniversary'), (SELECT item_type_id FROM item_type WHERE item_name = 'Valintine\'s Bouquet'));

SELECT * FROM product;


INSERT INTO inventory (store_id, product_id, quantity) VALUES ((SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.store_id INNER JOIN state st ON st.state_id = a.state_id WHERE state_abv = 'PA'), (SELECT product_id FROM product WHERE name = 'Helium Ballon'), 5);

INSERT INTO inventory (store_id, product_id, quantity) VALUES ((SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.store_id INNER JOIN state st ON st.state_id = a.state_id WHERE state_abv = 'ID'), (SELECT product_id FROM product WHERE name = 'Roses'), 10);

INSERT INTO inventory (store_id, product_id, quantity) VALUES ((SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.store_id INNER JOIN state st ON st.state_id = a.state_id WHERE state_abv = 'AZ'), (SELECT product_id FROM product WHERE name = 'Roses with Gypsophila'), 3);

SELECT * FROM inventory;


INSERT INTO flower_shop.order (store_id, employee_id, customer_id, date, total) VALUES ((SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.address_id WHERE city = 'Rexburgh'), (SELECT employee_id FROM employee WHERE first_name = 'Heather' and last_name = 'Washington'), (SELECT customer_id FROM customer WHERE first_name = 'Emily' and last_name = 'Levy'), '2024-01-13', 100.00);

INSERT INTO flower_shop.order (store_id, employee_id, customer_id, date, total) VALUES ((SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.address_id WHERE city = 'Phoenix'), (SELECT employee_id FROM employee WHERE first_name = 'Alex' and last_name = 'Jackson'), (SELECT customer_id FROM customer WHERE first_name = 'Douglas' and last_name = 'Young'), '2024-01-14', 100.00);

INSERT INTO flower_shop.order (store_id, employee_id, customer_id, date, total) VALUES ((SELECT store_id FROM store s INNER JOIN address a ON a.address_id = s.address_id WHERE city = 'Pittsburgh'), (SELECT employee_id FROM employee WHERE first_name = 'Jason' and last_name = 'Murray'), (SELECT customer_id FROM customer WHERE first_name = 'Cesar' and last_name = 'Moyer'), '2024-01-15', 100.00);

SELECT * FROM flower_shop.order;


INSERT INTO order_line (order_id, product_id) VALUES ((SELECT order_id FROM flower_shop.order WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'Emily' and last_name = 'Levy')), (SELECT product_id FROM product WHERE name = 'Roses'));

INSERT INTO order_line (order_id, product_id) VALUES ((SELECT order_id FROM flower_shop.order WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'Douglas' and last_name = 'Young')), (SELECT product_id FROM product WHERE name = 'Roses with Gypsophila'));

INSERT INTO order_line (order_id, product_id) VALUES ((SELECT order_id FROM flower_shop.order WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'Cesar' and last_name = 'Moyer')), (SELECT product_id FROM product WHERE name = 'Helium Ballon'));

SELECT * FROM order_line;



INSERT INTO truck (license_plate, make, model) VALUES ('WZB-123', 'Zephyr', 'Stellar Cruiser');

INSERT INTO truck (license_plate, make, model) VALUES ('YGT-789', 'Quasar', 'Quantum Velocity');

INSERT INTO truck (license_plate, make, model) VALUES ('KLM-456', 'Nebula', 'Nimbus X');

SELECT * FROM truck;



INSERT INTO delivery (order_id, truck_id) VALUES ((SELECT order_id FROM flower_shop.order WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'Emily' and last_name = 'Levy')), (SELECT truck_id FROM truck WHERE license_plate = 'WZB-123'));

INSERT INTO delivery (order_id, truck_id) VALUES ((SELECT order_id FROM flower_shop.order WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'Douglas' and last_name = 'Young')), (SELECT truck_id FROM truck WHERE license_plate = 'YGT-789'));

INSERT INTO delivery (order_id, truck_id) VALUES ((SELECT order_id FROM flower_shop.order WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'Cesar' and last_name = 'Moyer')), (SELECT truck_id FROM truck WHERE license_plate = 'KLM-456'));

SELECT * FROM delivery;
