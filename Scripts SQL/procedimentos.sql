-- Implementação do Sitema de Bases de Dados da agência "Detetives do Minho"
-- Grupo 33
-- Procedimentos

-- Indicar qual a base de dados a utilizar
USE agenciaDetetivesDB ;

-- Homicídios em investigação - requisito 3
DROP PROCEDURE IF EXISTS sp_homicidios_investigacao;
DELIMITER $$
CREATE PROCEDURE sp_homicidios_investigacao()
BEGIN
  SELECT * FROM homicidio
    WHERE Investigacao_encerrada = 0;
END $$
DELIMITER ;

-- Homicídios que um detetive investiga - requisito 14
DROP PROCEDURE IF EXISTS sp_homicidios_detetive;
DELIMITER $$
CREATE PROCEDURE sp_homicidios_detetive(IN pDetetive INT)
BEGIN
  SELECT * FROM homicidio
    INNER JOIN homicidio_e_investigado_detetive
    ON Detetive = pDetetive
    WHERE Numero_homicidio = Homicidio;
END $$
DELIMITER ;

-- Reuniôes agendadas para uma dada altura - requisito 30
-- Reuniões agendadas para um dado dia
DROP PROCEDURE IF EXISTS sp_reunioes_dia;
DELIMITER $$
CREATE PROCEDURE sp_reunioes_dia(IN pData DATE)
BEGIN
  SELECT Numero_reuniao, Hora_inicio, Hora_fim, Cliente, Nome, Email, Telefone FROM reuniao r
	INNER JOIN cliente c ON r.Cliente = c.Numero_cliente
	WHERE Data_reuniao = pData
      AND Hora_inicio != Hora_fim; -- reunião não foi cancelada
END $$
DELIMITER ;

-- Reuniões agendadas para uma dada semana
DROP PROCEDURE IF EXISTS sp_reunioes_semana;
DELIMITER $$
CREATE PROCEDURE sp_reunioes_semana(IN pData DATE)
BEGIN
  SELECT Numero_reuniao, Hora_inicio, Hora_fim, Cliente, Nome, Email, Telefone FROM reuniao r
    INNER JOIN cliente c ON r.Cliente = c.Numero_cliente
    WHERE WEEK(Data_reuniao) = WEEK(pData)
      AND YEAR(Data_reuniao) = YEAR(pData)
      AND Hora_inicio != Hora_fim; -- reunião não foi cancelada
END $$
DELIMITER ;

-- Reuniões agendadas para um dado mês
DROP PROCEDURE IF EXISTS sp_reunioes_mes;
DELIMITER $$
CREATE PROCEDURE sp_reunioes_mes(IN pData DATE)
BEGIN
  SELECT Numero_reuniao, Hora_inicio, Hora_fim, Cliente, Nome, Email, Telefone FROM reuniao r
    INNER JOIN cliente c ON r.Cliente = c.Numero_cliente
    WHERE MONTH(Data_reuniao) = MONTH(pData)
      AND YEAR(Data_reuniao) = YEAR(pData)
      AND Hora_inicio != Hora_fim; -- reunião não foi cancelada
END $$
DELIMITER ;

-- Função que verifica se uma dada data percence a um dado dia, semana ou mes
DROP FUNCTION IF EXISTS f_data_pertence;
DELIMITER $$
CREATE FUNCTION f_data_pertence(fData DATE, fDataComparacao DATE, fDiaSemanaMes CHAR)
  RETURNS BOOLEAN DETERMINISTIC
BEGIN
  DECLARE resultado BOOLEAN DEFAULT 0;
  IF fDiaSemanaMes = 'D'
    THEN SET resultado = fData = fDataComparacao;
  ELSEIF fDiaSemanaMes = 'S'
    THEN SET resultado = WEEK(fData) = WEEK(fDataComparacao) AND YEAR(fData) = YEAR(fDataComparacao);
  ELSEIF fDiaSemanaMes = 'M'
    THEN SET resultado = MONTH(fData) = MONTH(fDataComparacao) AND YEAR(fData) = YEAR(fDataComparacao);
  ELSE RETURN resultado;
  END IF ;
  RETURN resultado;
END $$
DELIMITER ;

-- Reuniões agendadas para uma dada altura
DROP PROCEDURE IF EXISTS sp_reunioes_em;
DELIMITER $$
CREATE PROCEDURE sp_reunioes_em(IN pData DATE, IN pDiaSemanaMes CHAR)
BEGIN
  SELECT Numero_reuniao, Data_reuniao, Hora_inicio, Hora_fim, Cliente, Nome, Email, Telefone FROM reuniao r
    INNER JOIN cliente c ON r.Cliente = c.Numero_cliente
    WHERE f_data_pertence(pData, Data_reuniao, pDiaSemanaMes)
      AND Hora_inicio != Hora_fim;
END $$
DELIMITER ;

-- Reuniões associadas a um cliente - requisito 32
DROP PROCEDURE IF EXISTS sp_reunioes_cliente;
DELIMITER $$
CREATE PROCEDURE sp_reunioes_cliente(IN pCliente INT)
BEGIN
  SELECT * FROM reuniao
    WHERE Cliente = pCliente
      AND Hora_inicio != Hora_fim;
END $$
DELIMITER ;

-- Lista de suspeitos de um homicídio - requisito 44
DROP PROCEDURE IF EXISTS sp_suspeitos_homicidio;
DELIMITER $$
CREATE PROCEDURE sp_suspeitos_homicidio(IN pHomicidio INT)
BEGIN
  SELECT s.* FROM suspeito s -- apenas a informação dos suspeitos
    INNER JOIN suspeito_de_homicidio sh
	ON s.Numero_suspeito = sh.Suspeito
	WHERE sh.Homicidio = pHomicidio;
END $$
DELIMITER ;

-- Lista de homicídios a que um suspeito está relacionado - requisito 44
DROP PROCEDURE IF EXISTS sp_homicidios_suspeito;
DELIMITER $$
CREATE PROCEDURE sp_homicidios_suspeito(IN pSuspeito INT)
BEGIN
  SELECT h.* FROM homicidio h -- apenas a informação dos homicidios
    INNER JOIN suspeito_de_homicidio sh
	ON h.Numero_homicidio = sh.Homicidio
	WHERE sh.Suspeito = pSuspeito;
END $$
DELIMITER ;

-- Lista informação de testemunhas de um homicídio - requisito 51
DROP PROCEDURE IF EXISTS sp_testemunhas_homicidio;
DELIMITER $$
CREATE PROCEDURE sp_testemunhas_homicidio(IN pHomicidio INT)
BEGIN
  SELECT t.* FROM testemunha t -- apenas a informação das testemunhas
    INNER JOIN testemunha_de_homicidio th
	ON t.Numero_testemunha = th.Testemunha
	WHERE th.Homicidio = pHomicidio;
END $$
DELIMITER ;

-- Lista provas associadas a um homicidio e um suspeito desse homicidio - requisito 55
DROP PROCEDURE IF EXISTS sp_provas_homicidio_suspeito;
DELIMITER $$
CREATE PROCEDURE sp_provas_homicidio_suspeito(IN pHomicidio INT, IN pSuspeito INT)
BEGIN
  SELECT p.* FROM prova p -- apenas a informação das provas
    INNER JOIN prova_esta_associada_suspeito ps
	ON p.Numero_prova = ps.Prova
      INNER JOIN homicidio_tem_prova hp
	  ON ps.Prova = hp.Prova
	WHERE hp.Homicidio = pHomicidio
	  AND ps.Suspeito = pSuspeito;
END $$
DELIMITER ;

-- Inserir uma prova de um homicídio recolhida por um detetive que está associada a um suspeito
DROP PROCEDURE IF EXISTS sp_insere_prova;
DELIMITER $$
CREATE PROCEDURE sp_insere_prova(
  IN pDescricao_prova VARCHAR(300),
  IN pLink_prova VARCHAR(150),
  IN pLocal_prova VARCHAR(150),
  IN pData_hora_prova DATETIME,
  IN pCusto_prova DECIMAL(7,2),
  IN pDetetive INT,
  IN pHomicidio INT,
  IN pSuspeito INT,
  IN pObservacoes_suspeito VARCHAR(250),
  OUT pResultado VARCHAR(150)
)
InsereProva:BEGIN
  DECLARE vProva INT DEFAULT 0;
  DECLARE vErro INT DEFAULT 0;
  DECLARE CONTINUE HANDLER
    FOR SQLEXCEPTION
      SET vErro = 1;
  START TRANSACTION;
  INSERT INTO Prova(Descricao, Link, Local_prova, Data_hora, Custo) VALUES
    (pDescricao_prova, pLink_prova, pLocal_prova, pData_hora_prova, pCusto_prova);
  IF vErro = 1 THEN
    ROLLBACK;
    SET pResultado = 'Transação abortada em - Insere Prova';
    LEAVE InsereProva;
  END IF;
  SET vProva = LAST_INSERT_ID();
  INSERT INTO Prova_e_recolhida_detetive(Detetive, Prova) VALUES
    (pDetetive, vProva);
  IF vErro = 1 THEN
    ROLLBACK;
    SET pResultado = 'Transação abortada em - Insere Prova_e_recolhida_detetive';
    LEAVE InsereProva;
  END IF;
  INSERT INTO Homicidio_tem_prova(Homicidio, Prova) VALUES
    (pHomicidio, vProva);
  IF vErro = 1 THEN
    ROLLBACK;
    SET pResultado = 'Transação abortada em - Insere Homicidio_tem_prova';
    LEAVE InsereProva;
  END IF;
  INSERT INTO Prova_esta_associada_suspeito(Prova, Suspeito, Observacoes) VALUES
    (vProva, pSuspeito, pObservacoes_suspeito);
  IF vErro = 1 THEN
    ROLLBACK;
    SET pResultado = 'Transação abortada em - Insere Prova_esta_associada_suspeito';
    LEAVE InsereProva;
  END IF;
  COMMIT;
  SET pResultado = 'Transação concluída';
END $$
DELIMITER ;
