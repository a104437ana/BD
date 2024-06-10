-- Implementação do Sitema de Bases de Dados da agência "Detetives do Minho"
-- Grupo 33
-- Triggers

-- Indicar qual a base de dados a utilizar
USE agenciaDetetivesDB ;

-- Custo de um homicídio - requisito 15
-- Custo das provas
-- Custo das provas - insert
DROP TRIGGER IF EXISTS t_custo_homicidio_prova_insert;
DELIMITER $$
CREATE TRIGGER t_custo_homicidio_prova_insert
  AFTER INSERT ON Homicidio_tem_prova
  FOR EACH ROW
BEGIN
  DECLARE custo_prova DECIMAL(7,2);
  SELECT Custo INTO custo_prova
    FROM Prova WHERE Numero_prova = NEW.Prova;
  UPDATE Homicidio
  SET Custo_total = Custo_total + custo_prova
  WHERE Numero_homicidio = NEW.Homicidio;
END $$
DELIMITER ;

-- Custo das provas - update
DROP TRIGGER IF EXISTS t_custo_homicidio_prova_update;
DELIMITER $$
CREATE TRIGGER t_custo_homicidio_prova_update
  AFTER UPDATE ON Prova
  FOR EACH ROW
BEGIN
  DECLARE custo_variacao DECIMAL(7,2) DEFAULT 0.00;
  SET custo_variacao = NEW.Custo - OLD.Custo; -- custo variação
  UPDATE Homicidio
  SET Custo_total = Custo_total + custo_variacao
  WHERE Numero_homicidio IN (SELECT DISTINCT Homicidio
							   FROM Homicidio_tem_prova
                               WHERE Prova = NEW.Numero_prova);
END $$
DELIMITER ;

-- Custo horas de trabalho
-- Função preço por hora de um dado detetive
DROP FUNCTION IF EXISTS f_preco_por_hora_detetive;
DELIMITER $$
CREATE FUNCTION f_preco_por_hora_detetive(fDetetive INT)
  RETURNS DECIMAL(5,2) DETERMINISTIC
BEGIN
  DECLARE vPreco_por_hora DECIMAL(5,2) DEFAULT 0.00;
  SELECT Preco_por_hora INTO vPreco_por_hora
    FROM Detetive
    WHERE Numero_detetive = fDetetive;
  RETURN vPreco_por_hora;
END $$
DELIMITER ;

-- Custo horas de trabalho - insert
DROP TRIGGER IF EXISTS t_custo_homicidio_horas_trabalho_insert;
DELIMITER $$
CREATE TRIGGER t_custo_homicidio_horas_trabalho_insert
  AFTER INSERT ON Homicidio_e_investigado_detetive
  FOR EACH ROW
BEGIN
  UPDATE Homicidio
  SET Custo_total = Custo_total + (NEW.Horas * f_preco_por_hora_detetive(NEW.Detetive))
  WHERE Numero_homicidio = NEW.Homicidio;
END $$
DELIMITER ;

-- Custo horas de trabalho - update
DROP TRIGGER IF EXISTS t_custo_homicidio_horas_trabalho_update;
DELIMITER $$
CREATE TRIGGER t_custo_homicidio_horas_trabalho_update
  AFTER UPDATE ON Homicidio_e_investigado_detetive
  FOR EACH ROW
BEGIN
  DECLARE custo_variacao DECIMAL(8,2) DEFAULT 0.00;
  DECLARE preco_por_hora_detetive DECIMAL(5,2) DEFAULT 0.00;
  SET preco_por_hora_detetive = f_preco_por_hora_detetive(NEW.Detetive);
  SET custo_variacao = (NEW.Horas - OLD.Horas) * preco_por_hora_detetive; -- custo variação
  UPDATE Homicidio
  SET Custo_total = Custo_total + custo_variacao
  WHERE Numero_homicidio = NEW.Homicidio;
END $$
DELIMITER ;

-- Dívida de um cliente - requisito 28
-- Dívida do cliente - update
DROP TRIGGER IF EXISTS t_divida_cliente_update;
DELIMITER $$
CREATE TRIGGER t_divida_cliente_update
  AFTER UPDATE ON Reuniao
  FOR EACH ROW
BEGIN
  DECLARE custo_variacao DECIMAL(8,2) DEFAULT 0.00;
  SET custo_variacao = NEW.Custo_total - OLD.Custo_total; -- custo variação
  UPDATE Cliente
  SET Divida = Divida + custo_variacao
  WHERE Numero_cliente = NEW.Cliente;
END $$
DELIMITER ;

-- Dívida do cliente - insert
DROP TRIGGER IF EXISTS t_divida_cliente_insert;
DELIMITER $$
CREATE TRIGGER t_divida_cliente_insert
  AFTER INSERT ON Reuniao
  FOR EACH ROW
BEGIN
  DECLARE custo_variacao DECIMAL(8,2) DEFAULT 0.00;
  SET custo_variacao = NEW.Custo_total; -- custo variação
  UPDATE Cliente
  SET Divida = Divida + custo_variacao
  WHERE Numero_cliente = NEW.Cliente;
END $$
DELIMITER ;
