-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema admbas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema admbas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `admbas` DEFAULT CHARACTER SET utf8 ;
USE `admbas` ;

-- -----------------------------------------------------
-- Table `admbas`.`TipoProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`TipoProduto` (
  `tipoProduto` INT NOT NULL,
  `valorIVA` INT NOT NULL,
  PRIMARY KEY (`tipoProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Categorias` (
  `idCategorias` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Produto` (
  `idItem` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `preco` FLOAT NOT NULL,
  `precoSIva` FLOAT NOT NULL,
  `eComposto` BIT(1) NOT NULL DEFAULT 0,
  `TipoProduto_tipoProduto` INT NOT NULL,
  `Categorias_idCategorias` INT NOT NULL,
  PRIMARY KEY (`idItem`, `TipoProduto_tipoProduto`, `Categorias_idCategorias`),
  INDEX `fk_Produto_TipoProduto1_idx` (`TipoProduto_tipoProduto` ASC),
  INDEX `fk_Produto_Categorias1_idx` (`Categorias_idCategorias` ASC),
  CONSTRAINT `fk_Produto_TipoProduto1`
    FOREIGN KEY (`TipoProduto_tipoProduto`)
    REFERENCES `admbas`.`TipoProduto` (`tipoProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Categorias1`
    FOREIGN KEY (`Categorias_idCategorias`)
    REFERENCES `admbas`.`Categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Artigo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Artigo` (
  `idArtigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `stock` FLOAT NOT NULL,
  `dataValidade` DATE NULL,
  `Produto_idItem` INT NOT NULL,
  PRIMARY KEY (`idArtigo`, `Produto_idItem`),
  INDEX `fk_Artigo_Produto_idx` (`Produto_idItem` ASC),
  CONSTRAINT `fk_Artigo_Produto`
    FOREIGN KEY (`Produto_idItem`)
    REFERENCES `admbas`.`Produto` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `email` VARCHAR(70) NOT NULL,
  `nif` INT(12) NULL,
  `ncc` INT(12) NOT NULL,
  `morada` VARCHAR(100) NULL,
  `telefone` INT(12) NULL,
  `numCartao` INT NOT NULL,
  `saldo` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`ProdutosVendidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`ProdutosVendidos` (
  `quantidade` INT NOT NULL,
  `Produto_idItem` INT NOT NULL,
  `Produto_TipoProduto_tipoProduto` INT NOT NULL,
  `Produto_Categorias_idCategorias` INT NOT NULL,
  PRIMARY KEY (`Produto_idItem`, `Produto_TipoProduto_tipoProduto`, `Produto_Categorias_idCategorias`),
  CONSTRAINT `fk_ProdutosVendidos_Produto1`
    FOREIGN KEY (`Produto_idItem` , `Produto_TipoProduto_tipoProduto` , `Produto_Categorias_idCategorias`)
    REFERENCES `admbas`.`Produto` (`idItem` , `TipoProduto_tipoProduto` , `Categorias_idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Venda` (
  `idVenda` INT NOT NULL,
  `ProdutosVendidos_Produto_idItem` INT NOT NULL,
  `ProdutosVendidos_Produto_TipoProduto_tipoProduto` INT NOT NULL,
  `ProdutosVendidos_Produto_Categorias_idCategorias` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVenda`, `ProdutosVendidos_Produto_idItem`, `ProdutosVendidos_Produto_TipoProduto_tipoProduto`, `ProdutosVendidos_Produto_Categorias_idCategorias`, `Cliente_idCliente`),
  INDEX `fk_Venda_ProdutosVendidos1_idx` (`ProdutosVendidos_Produto_idItem` ASC, `ProdutosVendidos_Produto_TipoProduto_tipoProduto` ASC, `ProdutosVendidos_Produto_Categorias_idCategorias` ASC),
  INDEX `fk_Venda_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Venda_ProdutosVendidos1`
    FOREIGN KEY (`ProdutosVendidos_Produto_idItem` , `ProdutosVendidos_Produto_TipoProduto_tipoProduto` , `ProdutosVendidos_Produto_Categorias_idCategorias`)
    REFERENCES `admbas`.`ProdutosVendidos` (`Produto_idItem` , `Produto_TipoProduto_tipoProduto` , `Produto_Categorias_idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `admbas`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Fatura` (
  `idFatura` INT NOT NULL,
  `data` DATE NOT NULL,
  `Venda_idVenda` INT NOT NULL,
  `Venda_ProdutosVendidos_Produto_idItem` INT NOT NULL,
  `Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto` INT NOT NULL,
  `Venda_ProdutosVendidos_Produto_Categorias_idCategorias` INT NOT NULL,
  `Venda_Cliente_idCliente` INT NOT NULL,
  `valorTotal` FLOAT NULL,
  PRIMARY KEY (`idFatura`, `Venda_idVenda`, `Venda_ProdutosVendidos_Produto_idItem`, `Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto`, `Venda_ProdutosVendidos_Produto_Categorias_idCategorias`, `Venda_Cliente_idCliente`),
  INDEX `fk_Fatura_Venda1_idx` (`Venda_idVenda` ASC, `Venda_ProdutosVendidos_Produto_idItem` ASC, `Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto` ASC, `Venda_ProdutosVendidos_Produto_Categorias_idCategorias` ASC, `Venda_Cliente_idCliente` ASC),
  CONSTRAINT `fk_Fatura_Venda1`
    FOREIGN KEY (`Venda_idVenda` , `Venda_ProdutosVendidos_Produto_idItem` , `Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto` , `Venda_ProdutosVendidos_Produto_Categorias_idCategorias` , `Venda_Cliente_idCliente`)
    REFERENCES `admbas`.`Venda` (`idVenda` , `ProdutosVendidos_Produto_idItem` , `ProdutosVendidos_Produto_TipoProduto_tipoProduto` , `ProdutosVendidos_Produto_Categorias_idCategorias` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Movimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Movimentos` (
  `idmovimento` INT NOT NULL,
  `tipo` BIT(1) NOT NULL,
  `valor` FLOAT NULL,
  `Fatura_idFatura` INT NOT NULL,
  `Fatura_Venda_idVenda` INT NOT NULL,
  `Fatura_Venda_ProdutosVendidos_Produto_idItem` INT NOT NULL,
  `Fatura_Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto` INT NOT NULL,
  `Fatura_Venda_ProdutosVendidos_Produto_Categorias_idCategorias` INT NOT NULL,
  `Fatura_Venda_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idmovimento`, `Fatura_idFatura`, `Fatura_Venda_idVenda`, `Fatura_Venda_ProdutosVendidos_Produto_idItem`, `Fatura_Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto`, `Fatura_Venda_ProdutosVendidos_Produto_Categorias_idCategorias`, `Fatura_Venda_Cliente_idCliente`),
  INDEX `fk_Movimentos_Fatura1_idx` (`Fatura_idFatura` ASC, `Fatura_Venda_idVenda` ASC, `Fatura_Venda_ProdutosVendidos_Produto_idItem` ASC, `Fatura_Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto` ASC, `Fatura_Venda_ProdutosVendidos_Produto_Categorias_idCategorias` ASC, `Fatura_Venda_Cliente_idCliente` ASC),
  CONSTRAINT `fk_Movimentos_Fatura1`
    FOREIGN KEY (`Fatura_idFatura` , `Fatura_Venda_idVenda` , `Fatura_Venda_ProdutosVendidos_Produto_idItem` , `Fatura_Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto` , `Fatura_Venda_ProdutosVendidos_Produto_Categorias_idCategorias` , `Fatura_Venda_Cliente_idCliente`)
    REFERENCES `admbas`.`Fatura` (`idFatura` , `Venda_idVenda` , `Venda_ProdutosVendidos_Produto_idItem` , `Venda_ProdutosVendidos_Produto_TipoProduto_tipoProduto` , `Venda_ProdutosVendidos_Produto_Categorias_idCategorias` , `Venda_Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Email` (
  `idEmail` INT NOT NULL,
  `assunto` VARCHAR(45) NULL,
  `mensagem` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmail`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `admbas`.`Artigo_has_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `admbas`.`Artigo_has_Produto` (
  `Artigo_idArtigo` INT NOT NULL,
  `Artigo_Produto_idItem` INT NOT NULL,
  `Produto_idItem` INT NOT NULL,
  `quantidade` FLOAT NULL,
  PRIMARY KEY (`Artigo_idArtigo`, `Artigo_Produto_idItem`, `Produto_idItem`),
  INDEX `fk_Artigo_has_Produto_Produto1_idx` (`Produto_idItem` ASC),
  INDEX `fk_Artigo_has_Produto_Artigo1_idx` (`Artigo_idArtigo` ASC, `Artigo_Produto_idItem` ASC),
  CONSTRAINT `fk_Artigo_has_Produto_Artigo1`
    FOREIGN KEY (`Artigo_idArtigo` , `Artigo_Produto_idItem`)
    REFERENCES `admbas`.`Artigo` (`idArtigo` , `Produto_idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artigo_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idItem`)
    REFERENCES `admbas`.`Produto` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
