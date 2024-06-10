-- Implementação do Sitema de Bases de Dados da agência "Detetives do Minho"
-- Grupo 33
-- Queries

-- Indicar qual a base de dados a utilizar
USE agenciaDetetivesDB ;

-- Homicídios em investigação - requisito 3
SELECT * FROM homicidio
  WHERE Investigacao_encerrada = FALSE;

-- Lista das reuniões que ainda não foram pagas - requisito 26
SELECT * FROM reuniao
  WHERE Data_de_pagamento IS NULL;

-- Lista clientes com dívidas à empresa - requisito 27
SELECT * FROM cliente
  WHERE Divida > 0;

-- Reuniôes agendadas para uma dada altura - requisito 30
SET @data_data = '2024-04-20';
-- Reuniões agendadas para um dado dia
SELECT * FROM Reuniao
  WHERE Data_reuniao = @data_dada;

-- Reuniões agendadas para uma dada semana
SELECT * FROM reuniao
  WHERE WEEK(Data_reuniao) = WEEK(@data_dada)
    AND YEAR(Data_reuniao) = YEAR(@data_dada);

-- Reuniões agendadas para um dado mês
SELECT * FROM reuniao
  WHERE MONTH(Data_reuniao) = MONTH(@data_dada)
    AND YEAR(Data_reuniao) = YEAR(@data_dada);

-- Lista provas associadas a um homicídio e um 
-- suspeito desse homicídio - requisito 55
SET @num_suspeito_dado = 1;
SET @num_homicidio_dado = 1;
SELECT p.* FROM prova p
  INNER JOIN prova_esta_associada_suspeito ps
  ON p.Numero_prova = ps.Prova
    INNER JOIN homicidio_tem_prova hp
    ON hp.Prova = ps.Prova
  WHERE hp.Homicidio = @num_homicidio_dado
    AND ps.Suspeito = @num_suspeito_dado;
