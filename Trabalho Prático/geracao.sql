-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Clinica_Testes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Clinica_Testes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Clinica_Testes` DEFAULT CHARACTER SET utf8 ;
USE `Clinica_Testes` ;

-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Codigo_Postal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Codigo_Postal` (
  `Codigo_Postal` VARCHAR(8) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Codigo_Postal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Clube`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Clube` (
  `idClube` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Morada` VARCHAR(45) NOT NULL,
  `Data_Fundacao` DATE NOT NULL,
  `Codigo_Postal` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`idClube`),
  INDEX `fk_Clube_Codigo_Postal1_idx` (`Codigo_Postal` ASC),
  CONSTRAINT `fk_Clube_Codigo_Postal1`
    FOREIGN KEY (`Codigo_Postal`)
    REFERENCES `Clinica_Testes`.`Codigo_Postal` (`Codigo_Postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Contacto_Clube`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Contacto_Clube` (
  `idContacto_Clube` INT NOT NULL AUTO_INCREMENT,
  `Contacto` VARCHAR(45) NOT NULL,
  `idClube` INT NOT NULL,
  PRIMARY KEY (`idContacto_Clube`, `idClube`),
  INDEX `fk_Contacto_Clube_idx` (`idClube` ASC),
  CONSTRAINT `fk_Contacto_Clube`
    FOREIGN KEY (`idClube`)
    REFERENCES `Clinica_Testes`.`Clube` (`idClube`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `Designacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Atleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Atleta` (
  `idAtleta` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
  `Peso` DECIMAL(5,2) NOT NULL,
  `Altura` DECIMAL(3,2) NOT NULL,
  `Morada` VARCHAR(45) NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `idClube` INT NOT NULL,
  `idCategoria` INT NOT NULL,
  `Codigo_Postal` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`idAtleta`),
  INDEX `fk_Atleta_Clube1_idx` (`idClube` ASC),
  INDEX `fk_Atleta_Categoria1_idx` (`idCategoria` ASC),
  INDEX `fk_Atleta_Codigo_Postal1_idx` (`Codigo_Postal` ASC),
  CONSTRAINT `fk_Atleta_Clube1`
    FOREIGN KEY (`idClube`)
    REFERENCES `Clinica_Testes`.`Clube` (`idClube`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Atleta_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `Clinica_Testes`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Atleta_Codigo_Postal1`
    FOREIGN KEY (`Codigo_Postal`)
    REFERENCES `Clinica_Testes`.`Codigo_Postal` (`Codigo_Postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Contacto_Atleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Contacto_Atleta` (
  `idContacto_Atleta` INT NOT NULL AUTO_INCREMENT,
  `Contacto` VARCHAR(45) NOT NULL,
  `idAtleta` INT NOT NULL,
  PRIMARY KEY (`idContacto_Atleta`, `idAtleta`),
  INDEX `fk_Contacto_copy1_Atleta1_idx` (`idAtleta` ASC),
  CONSTRAINT `fk_Contacto_copy1_Atleta1`
    FOREIGN KEY (`idAtleta`)
    REFERENCES `Clinica_Testes`.`Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Modalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Modalidade` (
  `idModalidade` INT NOT NULL AUTO_INCREMENT,
  `Designacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idModalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Modalidade_Atleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Modalidade_Atleta` (
  `idModalidade` INT NOT NULL,
  `idAtleta` INT NOT NULL,
  `Horas_Treino_Semanal` INT NOT NULL,
  `Anos_Pratica` INT NOT NULL,
  PRIMARY KEY (`idModalidade`, `idAtleta`),
  INDEX `fk_Modalidade_has_Atleta_Atleta1_idx` (`idAtleta` ASC),
  INDEX `fk_Modalidade_has_Atleta_Modalidade1_idx` (`idModalidade` ASC),
  CONSTRAINT `fk_Modalidade_has_Atleta_Modalidade1`
    FOREIGN KEY (`idModalidade`)
    REFERENCES `Clinica_Testes`.`Modalidade` (`idModalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Modalidade_has_Atleta_Atleta1`
    FOREIGN KEY (`idAtleta`)
    REFERENCES `Clinica_Testes`.`Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Especialidade` (
  `idEspecialidade` INT NOT NULL AUTO_INCREMENT,
  `Designacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEspecialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Medico` (
  `idMedico` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Morada` VARCHAR(45) NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `Data_Inicio_Servico` DATE NOT NULL,
  `idEspecialidade` INT NOT NULL,
  `Codigo_Postal` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`idMedico`),
  INDEX `fk_Médico_Especialidade1_idx` (`idEspecialidade` ASC),
  INDEX `fk_Médico_Codigo_Postal1_idx` (`Codigo_Postal` ASC),
  CONSTRAINT `fk_Médico_Especialidade1`
    FOREIGN KEY (`idEspecialidade`)
    REFERENCES `Clinica_Testes`.`Especialidade` (`idEspecialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Médico_Codigo_Postal1`
    FOREIGN KEY (`Codigo_Postal`)
    REFERENCES `Clinica_Testes`.`Codigo_Postal` (`Codigo_Postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Teste_Clinico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Teste_Clinico` (
  `idTeste_Clinico` INT NOT NULL AUTO_INCREMENT,
  `Estado` CHAR(1) NOT NULL,
  `Preco` DECIMAL(6,2) NOT NULL,
  `Data_Inicio` DATETIME NOT NULL,
  `Data_Fim` DATETIME NULL,
  `idAtleta` INT NOT NULL,
  `idMedico` INT NOT NULL,
  PRIMARY KEY (`idTeste_Clinico`, `idMedico`, `idAtleta`),
  INDEX `fk_Teste_clinico_Atleta1_idx` (`idAtleta` ASC),
  INDEX `fk_Teste_clinico_Médico1_idx` (`idMedico` ASC),
  CONSTRAINT `fk_Teste_clinico_Atleta1`
    FOREIGN KEY (`idAtleta`)
    REFERENCES `Clinica_Testes`.`Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teste_clinico_Médico1`
    FOREIGN KEY (`idMedico`)
    REFERENCES `Clinica_Testes`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clinica_Testes`.`Contacto_medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clinica_Testes`.`Contacto_medico` (
  `idContacto_medico` INT NOT NULL AUTO_INCREMENT,
  `Contacto` VARCHAR(45) NOT NULL,
  `idMedico` INT NOT NULL,
  PRIMARY KEY (`idContacto_medico`, `idMedico`),
  INDEX `fk_Contacto_medico_Médico1_idx` (`idMedico` ASC),
  CONSTRAINT `fk_Contacto_medico_Médico1`
    FOREIGN KEY (`idMedico`)
    REFERENCES `Clinica_Testes`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
