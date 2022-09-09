-- MySQL Script generated by MySQL Workbench
-- Fri Sep  9 00:00:35 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`os` (
  `idos` INT NOT NULL,
  `status` TINYINT NULL,
  `datainicio` DATETIME NULL,
  `datafim` DATETIME NULL,
  `valortotal` FLOAT NULL,
  PRIMARY KEY (`idos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idcliente` INT NOT NULL,
  `nome_cliente` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `numero` INT NULL,
  `endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mecanicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mecanicos` (
  `idmecanicos` INT NOT NULL,
  `salario` FLOAT NULL,
  `nome` VARCHAR(45) NULL,
  `endereço` VARCHAR(45) NULL,
  `especialidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idmecanicos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servico` (
  `idservico` INT NOT NULL,
  `mecanicos_idmecanicos` INT NOT NULL,
  `type_service` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idservico`, `mecanicos_idmecanicos`),
  INDEX `fk_servico_mecanicos1_idx` (`mecanicos_idmecanicos` ASC) VISIBLE,
  CONSTRAINT `fk_servico_mecanicos1`
    FOREIGN KEY (`mecanicos_idmecanicos`)
    REFERENCES `mydb`.`mecanicos` (`idmecanicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`veiculo` (
  `idveiculo` INT NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `placa` VARCHAR(45) NULL,
  `objetivo` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  PRIMARY KEY (`idveiculo`, `cliente_idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente possui veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente possui veiculo` (
  `cliente_idcliente` INT NOT NULL,
  `veiculo_idveiculo` INT NOT NULL,
  PRIMARY KEY (`cliente_idcliente`, `veiculo_idveiculo`),
  INDEX `fk_cliente_has_veiculo_veiculo1_idx` (`veiculo_idveiculo` ASC) VISIBLE,
  INDEX `fk_cliente_has_veiculo_cliente1_idx` (`cliente_idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_has_veiculo_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_veiculo_veiculo1`
    FOREIGN KEY (`veiculo_idveiculo`)
    REFERENCES `mydb`.`veiculo` (`idveiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gera OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gera OS` (
  `veiculo_idveiculo` INT NOT NULL,
  `os_idos` INT NOT NULL,
  PRIMARY KEY (`veiculo_idveiculo`, `os_idos`),
  INDEX `fk_veiculo_has_os_os1_idx` (`os_idos` ASC) VISIBLE,
  INDEX `fk_veiculo_has_os_veiculo1_idx` (`veiculo_idveiculo` ASC) VISIBLE,
  CONSTRAINT `fk_veiculo_has_os_veiculo1`
    FOREIGN KEY (`veiculo_idveiculo`)
    REFERENCES `mydb`.`veiculo` (`idveiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_veiculo_has_os_os1`
    FOREIGN KEY (`os_idos`)
    REFERENCES `mydb`.`os` (`idos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`peça` (
  `idpeça` INT NOT NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`idpeça`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`peça para os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`peça para os` (
  `os_idos` INT NOT NULL,
  `peça_idpeça` INT NOT NULL,
  PRIMARY KEY (`os_idos`, `peça_idpeça`),
  INDEX `fk_os_has_peça_peça1_idx` (`peça_idpeça` ASC) VISIBLE,
  INDEX `fk_os_has_peça_os1_idx` (`os_idos` ASC) VISIBLE,
  CONSTRAINT `fk_os_has_peça_os1`
    FOREIGN KEY (`os_idos`)
    REFERENCES `mydb`.`os` (`idos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_has_peça_peça1`
    FOREIGN KEY (`peça_idpeça`)
    REFERENCES `mydb`.`peça` (`idpeça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Serviço da OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Serviço da OS` (
  `os_idos` INT NOT NULL,
  `servico_idservico` INT NOT NULL,
  PRIMARY KEY (`os_idos`, `servico_idservico`),
  INDEX `fk_os_has_servico_servico1_idx` (`servico_idservico` ASC) VISIBLE,
  INDEX `fk_os_has_servico_os1_idx` (`os_idos` ASC) VISIBLE,
  CONSTRAINT `fk_os_has_servico_os1`
    FOREIGN KEY (`os_idos`)
    REFERENCES `mydb`.`os` (`idos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_has_servico_servico1`
    FOREIGN KEY (`servico_idservico`)
    REFERENCES `mydb`.`servico` (`idservico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;