-- Implementação do Sitema de Bases de Dados da agência "Detetives do Minho"
-- Grupo 33
-- Vistas

-- Indicar qual a base de dados a utilizar
USE agenciaDetetivesDB ;

-- Vista das reuniões que ainda não foram pagas das mais antigas para mais recentes - requisito 26
DROP VIEW IF EXISTS vw_reunioes_nao_pagas; -- remoção da vista
CREATE VIEW vw_reunioes_nao_pagas AS
  SELECT Numero_reuniao, Data_reuniao, Hora_inicio, Hora_fim, Custo_total, Cliente FROM reuniao
  WHERE Data_de_pagamento IS NULL -- não foi paga
	AND Data_reuniao < CURDATE()  -- já foi realizada
    AND Hora_inicio != Hora_fim -- não foi cancelada
  ORDER BY Data_reuniao ASC;

-- Vista clientes com dívidas à empresa por ordem decrescente da dívida - requisito 27
DROP VIEW IF EXISTS vw_clientes_em_divida; -- remoção da vista
CREATE VIEW vw_clientes_em_divida AS
  SELECT * FROM cliente
  WHERE Divida > 0.00 -- tem dívida
  ORDER BY Divida DESC;
