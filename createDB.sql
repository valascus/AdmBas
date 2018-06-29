CREATE SCHEMA IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha` DEFAULT CHARACTER SET utf8 ;
USE `SuperNew_DBv20.1.0.3alpha` ;

-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`artigo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`artigo` (
  `idArtigo` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `stock` FLOAT NOT NULL,
  `dataValidade` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idArtigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`categorias` (
  `idCategorias` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategorias`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`tipoproduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`tipoproduto` (
  `tipoProduto` INT(11) NOT NULL AUTO_INCREMENT,
  `valorIVA` INT(11) NOT NULL,
  PRIMARY KEY (`tipoProduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`produto` (
  `idItem` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `preco` FLOAT NULL,
  `precoSIva` FLOAT NOT NULL,
  `eComposto` BIT(1) NOT NULL DEFAULT b'0',
  `TipoProduto_tipoProduto` INT(11) NOT NULL,
  `Categorias_idCategorias` INT(11) NOT NULL,
  PRIMARY KEY (`idItem`, `TipoProduto_tipoProduto`, `Categorias_idCategorias`),
  INDEX `fk_Produto_TipoProduto1_idx` (`TipoProduto_tipoProduto` ASC),
  INDEX `fk_Produto_Categorias1_idx` (`Categorias_idCategorias` ASC),
  CONSTRAINT `fk_Produto_Categorias1`
    FOREIGN KEY (`Categorias_idCategorias`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_TipoProduto1`
    FOREIGN KEY (`TipoProduto_tipoProduto`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`tipoproduto` (`tipoProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`artigo_has_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`artigo_has_produto` (
  `Artigo_idArtigo` INT(11) NOT NULL,
  `Produto_idItem` INT(11) NOT NULL,
  `quantidade` FLOAT NOT NULL,
  PRIMARY KEY (`Artigo_idArtigo`, `Produto_idItem`),
  INDEX `fk_Artigo_has_Produto_Produto1_idx` (`Produto_idItem` ASC),
  INDEX `fk_Artigo_has_Produto_Artigo1_idx` (`Artigo_idArtigo` ASC),
  CONSTRAINT `fk_Artigo_has_Produto_Artigo1`
    FOREIGN KEY (`Artigo_idArtigo`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`artigo` (`idArtigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Artigo_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idItem`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`produto` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`cliente` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `email` VARCHAR(70) NOT NULL,
  `nif` INT(12) NOT NULL DEFAULT 999999999,
  `ncc` INT(12) NULL,
  `morada` VARCHAR(100) NULL DEFAULT NULL,
  `telefone` INT(12) NULL DEFAULT NULL,
  `numCartao` INT(11) NOT NULL,
  `saldo` FLOAT NOT NULL DEFAULT '0',
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`email` (
  `idEmail` INT(11) NOT NULL AUTO_INCREMENT,
  `assunto` VARCHAR(45) NULL,
  `mensagem` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT(11) NOT NULL,
  PRIMARY KEY (`idEmail`, `Cliente_idCliente`),
  INDEX `fk_Email_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Email_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`venda` (
  `idVenda` INT(11) NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` INT(11) NOT NULL,
  `precoCIva` FLOAT NULL,
  `precoSIva` FLOAT NULL,
  PRIMARY KEY (`idVenda`, `Cliente_idCliente`),
  INDEX `fk_Venda_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`fatura` (
  `idFatura` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `Venda_idVenda` INT(11) NOT NULL,
  `Venda_Cliente_idCliente` INT(11) NOT NULL,
  `valorTotal` FLOAT NULL,
  `precoSIva` FLOAT NULL,
  PRIMARY KEY (`idFatura`, `Venda_idVenda`, `Venda_Cliente_idCliente`),
  INDEX `fk_Fatura_Venda1_idx` (`Venda_idVenda` ASC, `Venda_Cliente_idCliente` ASC),
  CONSTRAINT `fk_Fatura_Venda1`
    FOREIGN KEY (`Venda_idVenda` , `Venda_Cliente_idCliente`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`venda` (`idVenda` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`movimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`movimentos` (
  `idmovimento` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` BIT(1) NOT NULL,
  `valor` FLOAT NULL,
  `Fatura_idFatura` INT(11) NOT NULL,
  `cliente_idCliente` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`idmovimento`, `Fatura_idFatura`, `cliente_idCliente`),
  INDEX `fk_Movimentos_Fatura1_idx` (`Fatura_idFatura` ASC),
  INDEX `fk_movimentos_cliente1_idx` (`cliente_idCliente` ASC),
  CONSTRAINT `fk_Movimentos_Fatura1`
    FOREIGN KEY (`Fatura_idFatura`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`fatura` (`idFatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimentos_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SuperNew_DBv20.1.0.3alpha`.`produto_has_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SuperNew_DBv20.1.0.3alpha`.`produto_has_venda` (
  `produto_idItem` INT(11) NOT NULL,
  `venda_idVenda` INT(11) NOT NULL,
  `quantidade` FLOAT NOT NULL,
  PRIMARY KEY (`produto_idItem`, `venda_idVenda`),
  INDEX `fk_produto_has_venda_venda1_idx` (`venda_idVenda` ASC),
  INDEX `fk_produto_has_venda_produto1_idx` (`produto_idItem` ASC),
  CONSTRAINT `fk_produto_has_venda_produto1`
    FOREIGN KEY (`produto_idItem`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`produto` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_venda_venda1`
    FOREIGN KEY (`venda_idVenda`)
    REFERENCES `SuperNew_DBv20.1.0.3alpha`.`venda` (`idVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
