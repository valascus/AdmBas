CREATE FUNCTION RetornaGasto (id int, d1 DATE, d2 DATE) 
RETURNS float
DETERMINISTIC
BEGIN 
  
SELECT sum (valorTotal) AS gastos FROM fatura where Venda_Cliente_idCliente = id AND data between d1 and d2;
  
  RETURN gastos;
END
