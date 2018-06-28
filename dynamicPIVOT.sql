SELECT YEAR(data) AS Ano,
	SUM( IF( MONTH(data) = 1 ,valorTotal, 0) ) AS janeiro,
	SUM( IF( MONTH(data) = 2 , valorTotal, 0) ) AS fevereiro,
	SUM( IF( MONTH(data) = 3 , valorTotal, 0) ) AS março,
	SUM( IF( MONTH(data) = 4 , valorTotal, 0) ) AS abril,
	SUM( IF( MONTH(data) = 5 , valorTotal, 0) ) AS maio,
	SUM( IF( MONTH(data) = 6 , valorTotal, 0) ) AS junho,
	SUM( IF( MONTH(data) = 7 , valorTotal, 0) ) AS julho,
	SUM( IF( MONTH(data) = 8 , valorTotal, 0) ) AS agosto,
	SUM( IF( MONTH(data) = 9 , valorTotal, 0) ) AS setembro,
	SUM( IF( MONTH(data) = 10 , valorTotal, 0) ) AS outubro,
	SUM( IF( MONTH(data) = 11 , valorTotal, 0) ) AS novembro,
	SUM( IF( MONTH(data) = 12 , valorTotal, 0) ) AS dezembro,
	SUM( valorTotal  ) AS total
FROM fatura
GROUP BY data
