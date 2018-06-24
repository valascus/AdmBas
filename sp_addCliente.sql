CREATE PROCEDURE `adicionar_cliente`(IN `nome` VARCHAR(60), IN `email` varchar(70), IN `nif` int(12), IN `ncc` INT(12), IN `morada` VARCHAR(100), IN telefone int(12), IN numCartao INT, IN saldo FLOAT )
BEGIN
    INSERT INTO Cliente ( nome, email, nif, ncc, morada, telefone, numCartao, saldo)
   VALUES
   ( `nome`, `email`, `nif`, `ncc`, `morada`, `telefone`, `numCartao`, `saldo`);
END
