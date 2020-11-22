-- MySQL Script generated by MySQL Workbench
-- Fri Nov 13 12:49:55 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema catastro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema catastro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `catastro` DEFAULT CHARACTER SET utf8 ;
USE `catastro` ;

-- -----------------------------------------------------
-- Table `catastro`.`Zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`Zona` (
  `nombre` VARCHAR(45) NOT NULL,
  `area` VARCHAR(45) NOT NULL,
  `concejal` VARCHAR(45) NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`Vivienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`Vivienda` (
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `numero_personas` INT NULL,
  `Zona_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`calle`, `numero`, `Zona_nombre`),
  INDEX `fk_Vivienda_Zona1_idx` (`Zona_nombre` ASC) ,
  CONSTRAINT `fk_Vivienda_Zona1`
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `catastro`.`Zona` (`nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`Bloque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`Bloque` (
  `calle` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `numero_personas` INT NOT NULL ,
  `Zona_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`calle`, `numero`, `Zona_nombre`),
  INDEX `fk_Bloque_Zona1_idx` (`Zona_nombre` ASC) ,
  CONSTRAINT `fk_Bloque_Zona1`
  /*PRIMARY KEY (`calle`, `numero`,`Zona_nombre`),*/
    FOREIGN KEY (`Zona_nombre`)
    REFERENCES `catastro`.`Zona` (`nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`Piso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`Piso` (
  `planta` INT NOT NULL,
  `letra` VARCHAR(3) NOT NULL,
  `Bloque_calle` VARCHAR(45) NOT NULL,
  `Bloque_numero` INT NOT NULL,
  `Bloque_Zona_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`planta`, `letra`, `Bloque_calle`, `Bloque_numero`, `Bloque_Zona_nombre`),
  INDEX `fk_Piso_Bloque1_idx` (`Bloque_calle` ASC, `Bloque_numero` ASC, `Bloque_Zona_nombre` ASC) ,
  CONSTRAINT `fk_Piso_Bloque1`
  /*PRIMARY KEY (`planta`, `letra`, `Bloque_calle`, `Bloque_numero`, `Bloque_Zona_nombre`),*/
    FOREIGN KEY (`Bloque_calle` , `Bloque_numero` , `Bloque_Zona_nombre`)
    REFERENCES `catastro`.`Bloque` (`calle` , `numero` , `Zona_nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catastro`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catastro`.`Persona` (
  `DNI` VARCHAR(9) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `dni_cabeza` VARCHAR(9) NOT NULL,
  `Vivienda_calle` VARCHAR(45) NOT NULL,
  `Vivienda_numero` INT NOT NULL,
  `Vivienda_Zona_nombre` VARCHAR(45) NOT NULL,
  `Piso_planta` INT NOT NULL,
  `Piso_letra` VARCHAR(3) NOT NULL,
  `Piso_Bloque_calle` VARCHAR(45) NOT NULL,
  `Piso_Bloque_numero` INT NOT NULL,
  `Piso_Bloque_Zona_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DNI`, `Vivienda_calle`, `Vivienda_numero`, `Vivienda_Zona_nombre`, `Piso_planta`, `Piso_letra`, `Piso_Bloque_calle`, `Piso_Bloque_numero`, `Piso_Bloque_Zona_nombre`),
  INDEX `fk_Persona_Vivienda1_idx` (`Vivienda_calle` ASC, `Vivienda_numero` ASC, `Vivienda_Zona_nombre` ASC) ,
  INDEX `fk_Persona_Piso1_idx` (`Piso_planta` ASC, `Piso_letra` ASC, `Piso_Bloque_calle` ASC, `Piso_Bloque_numero` ASC, `Piso_Bloque_Zona_nombre` ASC) ,
  CONSTRAINT `fk_Persona_Vivienda1`
    FOREIGN KEY (`Vivienda_calle` , `Vivienda_numero` , `Vivienda_Zona_nombre`)
    REFERENCES `catastro`.`Vivienda` (`calle` , `numero` , `Zona_nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT `fk_Persona_Piso1`
    FOREIGN KEY (`Piso_planta` , `Piso_letra` , `Piso_Bloque_calle` , `Piso_Bloque_numero` , `Piso_Bloque_Zona_nombre`)
    REFERENCES `catastro`.`Piso` (`planta` , `letra` , `Bloque_calle` , `Bloque_numero` , `Bloque_Zona_nombre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
