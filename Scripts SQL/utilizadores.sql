-- Criação de utilizadores da base de dados
USE agenciaDetetivesDB;

-- Criar o cargo secretário na base de dados
CREATE ROLE secretario;

-- Conjunto de permissões dos secretários na base de dados organizados por tabelas:
-- Conjunto de permissões na tabela Reuniao
GRANT SELECT ON  agenciaDetetivesDB.Reuniao TO secretario; -- requisitos 36
GRANT INSERT (Data_reuniao, Hora_inicio, Hora_fim, Custo_total, 
Data_de_pagamento, Cliente, Secretario, Detetive, Homicidio) ON agenciaDetetivesDB.Reuniao TO secretario; -- requisito 70
GRANT UPDATE (Data_reuniao, Hora_inicio, Hora_fim, Custo_total, Data_de_pagamento) ON agenciaDetetivesDB.Reuniao TO secretario; -- requisito 35
-- Conjunto de permissões na tabela Cliente
GRANT SELECT ON  agenciaDetetivesDB.Cliente TO secretario; -- requisitos 36
GRANT INSERT (Nome,Email,Telefone) ON agenciaDetetivesDB.Cliente TO secretario; -- requisito 70
GRANT UPDATE (Nome,Email,Telefone) ON agenciaDetetivesDB.Cliente TO secretario; -- requisito 73
-- Conjunto de permissões na tabela Homicidio
GRANT SELECT (Investigacao_encerrada, Custo_total) ON agenciadetetivesDB.Homicidio TO secretario; -- requisito 37

-- Criar o cargo detetive na base de dados
CREATE ROLE detetive;

-- Conjunto de permissões dos detetives na base de dados organizados por tabelas:
-- Conjunto de permissões na tabela Reuniao
GRANT SELECT (Data_reuniao, Hora_inicio, Hora_fim, Homicidio) ON agenciaDetetivesDB.Reuniao TO detetive; -- requisito 74
-- Conjunto de permissões na tabela Homicidio
GRANT SELECT ON agenciadetetivesdb.Homicidio TO detetive; -- requisito 60
GRANT INSERT (Descricao, Local_homicidio, Data_homicidio, Hora,
Investigacao_encerrada, Nome_vitima, Genero_vitima, 
Data_de_nascimento_vitima, Descricao_vitima, Estado_civil_vitima, 
Ocupacao_vitima) ON agenciadetetivesdb.Homicidio TO detetive; -- requisito 71
GRANT UPDATE (Descricao, Local_homicidio, Data_homicidio, Hora,
Investigacao_encerrada, Nome_vitima, Genero_vitima, 
Data_de_nascimento_vitima, Descricao_vitima, Estado_civil_vitima, 
Ocupacao_vitima) ON agenciadetetivesdb.Homicidio TO detetive; -- requisito 60
-- Conjunto de permissões na tabela Testemunha
GRANT SELECT ON agenciadetetivesdb.Testemunha TO detetive; -- requisito 67
GRANT INSERT (Nome, Telefone) ON agenciadetetivesdb.Testemunha TO detetive; -- requisito 71
GRANT UPDATE (Nome, Telefone) ON agenciadetetivesdb.Testemunha TO detetive; -- requisito 67
-- Conjunto de permissões na tabela Testemunha_de_Homicidio
GRANT SELECT ON agenciadetetivesdb.Testemunha_de_Homicidio TO detetive; -- requisito 77
GRANT INSERT (Testemunha, Homicidio, Resumo_testemunho, Link_testemunho) ON agenciadetetivesdb.Testemunha_de_Homicidio TO detetive; -- requisito 77
GRANT UPDATE (Resumo_testemunho, Link_testemunho) ON agenciadetetivesdb.Testemunha_de_Homicidio TO detetive; -- requisito 77
-- Conjunto de permissões na tabela Suspeito
GRANT SELECT ON agenciadetetivesdb.Suspeito TO detetive; -- requisito 67
GRANT INSERT (Nome, Genero, Data_nascimento, Ocupacao, Historico_criminal, Rua, Localidade, Codigo_postal, Telefone, Descricao)
	ON agenciadetetivesdb.Suspeito TO detetive; -- requisito 71
GRANT UPDATE (Nome, Genero, Data_nascimento, Ocupacao, Historico_criminal, Rua, Localidade, Codigo_postal, Telefone, Descricao)
	ON agenciadetetivesdb.Suspeito TO detetive; -- requisito 67
-- Conjunto de permissões na tabela Suspeito_de_Homicidio
GRANT SELECT ON agenciadetetivesdb.Suspeito_de_Homicidio TO detetive; -- requisito 77
GRANT INSERT (Suspeito, Homicidio, Relacao_vitima, Observacoes) ON agenciadetetivesdb.Suspeito_de_Homicidio TO detetive; -- requisito 77
GRANT UPDATE (Relacao_vitima, Observacoes) ON agenciadetetivesdb.Suspeito_de_Homicidio TO detetive; -- requisito 77
-- Conjunto de permissões na tabela Homicidio_e_investigado_Detetive
CREATE VIEW agenciadetetivesdb.Homicidio_Deste_Detetive AS
SELECT * FROM agenciadetetivesdb.Homicidio_e_investigado_Detetive WHERE Detetive = CONVERT(SUBSTRING(SUBSTRING_INDEX(USER(),'@',1),2), UNSIGNED);
GRANT SELECT ON agenciadetetivesdb.Homicidio_Deste_Detetive TO detetive; -- requisito 75
GRANT UPDATE (Horas) ON agenciadetetivesdb.Homicidio_Deste_Detetive TO detetive; -- requisito 76
-- Conjunto de permissões na tabela Homicidio_tem_Prova
GRANT SELECT ON Homicidio_tem_Prova TO detetive;  -- requisito 77
GRANT INSERT (Homicidio, Prova) ON Homicidio_tem_Prova TO detetive; -- requisito 77
-- Conjunto de permissões na tabela Prova_esta_associada_Suspeito
GRANT SELECT ON Prova_esta_associada_Suspeito TO detetive;  -- requisito 78
GRANT INSERT (Prova, Suspeito, Observacoes) ON Prova_esta_associada_Suspeito TO detetive;  -- requisito 78
GRANT UPDATE (Observacoes) ON Prova_esta_associada_Suspeito TO detetive;  -- requisito 78
-- Conjunto de permissões na tabela Prova
CREATE VIEW agenciadetetivesdb.Prova_Deste_Detetive AS
SELECT * FROM agenciadetetivesdb.Prova WHERE Numero_prova IN
(SELECT Prova FROM agenciadetetivesdb.Prova_e_recolhida_Detetive 
WHERE Detetive = CONVERT(SUBSTRING(SUBSTRING_INDEX(USER(),'@',1),2), UNSIGNED));
GRANT SELECT ON agenciadetetivesdb.Prova TO detetive; -- requisito 63
GRANT INSERT (Descricao, Link, Local_prova, Data_hora, Custo) ON agenciadetetivesdb.Prova TO detetive; -- requisito 65
GRANT UPDATE (Descricao, Link, Local_prova, Data_hora, Custo) ON agenciadetetivesdb.Prova_Deste_Detetive TO detetive; -- requisito 65
-- Conjunto de permissões na tabela Prova_e_recolhida_Detetive
GRANT SELECT ON agenciadetetivesdb.Prova_e_recolhida_Detetive TO detetive; -- requisito 79
GRANT INSERT (Detetive, Prova) ON agenciadetetivesdb.Prova_e_recolhida_Detetive TO detetive; -- requisito 79

-- Criar utilizador Fernando Oliveira
CREATE USER 'd2'@'%';
SET PASSWORD FOR 'd2'@'%' = 'root'; -- palavra-passe do utilizador
GRANT detetive TO 'd2'@'%'; -- concede o cargo detetive ao utilizador
SET DEFAULT ROLE detetive TO 'd2'@'%'; -- define o cargo detetive como padrão para o utilizador

-- Criar utilizador João Costa
CREATE USER 'd3'@'%';
SET PASSWORD FOR 'd3'@'%' = '123456'; -- palavra-passe do utilizador
GRANT detetive TO 'd3'@'%';  -- concede o cargo detetive ao utilizador
SET DEFAULT ROLE detetive TO 'd3'@'%'; -- define o cargo detetive como padrão para o utilizador

-- Criar utilizador Joana Amorim
CREATE USER 's1'@'%';
SET PASSWORD FOR 's1'@'%' = 'password'; -- palavra-passe do utilizador
GRANT secretario TO 's1'@'%';  -- concede o cargo secretário ao utilizador
SET DEFAULT ROLE secretario TO 's1'@'%'; -- define o cargo secretário como padrão para o utilizador

FLUSH PRIVILEGES; -- esvazia o buffer de permissões, forçando-as a ser aplicadas mesmo que o buffer não esteja cheio

-- DROP ROLE IF EXISTS secretario;
-- DROP ROLE IF EXISTS detetive;
-- DROP VIEW IF EXISTS Homicidio_Deste_Detetive;
-- DROP VIEW IF EXISTS Prova_Deste_Detetive;
-- DROP USER IF EXISTS 'd2'@'%';
-- DROP USER IF EXISTS 'd3'@'%';
-- DROP USER IF EXISTS 's1'@'%';

--
-- <fim>
