-- Implementação do Sitema de Bases de Dados da agência "Detetives do Minho"
-- Grupo 33
-- Descrição de dados

-- Remoção da Base de Dados se já existir
DROP DATABASE IF EXISTS agenciaDetetivesDB;

-- Criação da Base de Dados agenciaDetetivesDB
CREATE DATABASE agenciaDetetivesDB;

-- Indicar qual a base de dados a utilizar
USE agenciaDetetivesDB ;

-- Criação da tabela Cliente
CREATE TABLE Cliente (
  Numero_cliente INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(75) NOT NULL,
  Email VARCHAR(320) NOT NULL,
  Telefone CHAR(12) NOT NULL CHECK (Telefone REGEXP '[0-9]'), 
  Divida DECIMAL(8,2) NOT NULL DEFAULT 0 CHECK (Divida>=0), -- a dívida de um cliente começa com o valor 0
	PRIMARY KEY (Numero_cliente))
ENGINE = InnoDB;

-- Criação da tabela Secretario
CREATE TABLE Secretario (
  Numero_secretario INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(75) NOT NULL,
  NIF INT NOT NULL CHECK (NIF>=0 AND NIF<=999999999), -- nif tem no máximo 9 dígitos
  Email VARCHAR(30) NOT NULL DEFAULT "",
  Telefone CHAR(12) NOT NULL CHECK (Telefone REGEXP '[0-9]'),
  Salario DECIMAL(6,2) NOT NULL CHECK (Salario>=820 AND Salario<=1800),
	PRIMARY KEY (Numero_secretario))
ENGINE = InnoDB;

CREATE UNIQUE INDEX idxSecretarioNIF
	ON Secretario (NIF ASC) VISIBLE;
CREATE UNIQUE INDEX idxSecretarioEmail
	ON Secretario (Email ASC) VISIBLE;

-- Criação da tabela Detetive
CREATE TABLE Detetive (
  Numero_detetive INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(75) NOT NULL,
  NIF INT NOT NULL CHECK (NIF>=0 AND NIF<=999999999),
  Email VARCHAR(30) NOT NULL DEFAULT "",
  Telefone CHAR(12) NOT NULL CHECK (Telefone REGEXP '[0-9]'),
  Salario DECIMAL(6,2) NOT NULL CHECK (Salario>=820 AND Salario<=2000),
  Preco_por_hora DECIMAL(5,2) NOT NULL CHECK (Preco_por_hora>=0),
	PRIMARY KEY (Numero_detetive))
ENGINE = InnoDB;

CREATE UNIQUE INDEX idxDetetiveNIF
	ON Detetive (NIF ASC) VISIBLE;
CREATE UNIQUE INDEX idxDetetiveEmail
	ON Detetive (Email ASC) VISIBLE;

-- Criação da tabela Homicidio
CREATE TABLE Homicidio (
  Numero_homicidio INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(450) NOT NULL,
  Local_homicidio VARCHAR(150) NOT NULL,
  Data_homicidio DATE NOT NULL,
  Hora TIME NULL,
  Investigacao_encerrada BIT(1) NOT NULL DEFAULT 0,
  Custo_total DECIMAL(8,2) NOT NULL DEFAULT 0 CHECK (Custo_total>=0 AND Custo_total<1000000),
  Nome_vitima VARCHAR(75) NOT NULL,
  Genero_vitima CHAR(1) NOT NULL CHECK (Genero_vitima IN ('M','F')),
  Data_de_nascimento_vitima DATE NOT NULL,
  Descricao_vitima VARCHAR(300) NOT NULL,
  Estado_civil_vitima ENUM('Solteira', 'Casada', 'Divorciada', 'Viúva', 'Separada') NOT NULL,
  Ocupacao_vitima VARCHAR(75) NOT NULL,
	PRIMARY KEY (Numero_homicidio))
ENGINE = InnoDB;

-- Criação da tabela Reuniao
CREATE TABLE Reuniao (
  Numero_reuniao INT NOT NULL AUTO_INCREMENT,
  Data_reuniao DATE NOT NULL,
  Hora_inicio TIME NOT NULL,
  Hora_fim TIME NOT NULL,
  Custo_total DECIMAL(8,2) NOT NULL DEFAULT 0 CHECK (Custo_total>=0),
  Data_de_pagamento DATETIME NULL,
  Cliente INT NOT NULL,
  Secretario INT NOT NULL,
  Detetive INT NOT NULL,
  Homicidio INT NOT NULL,
	PRIMARY KEY (Numero_reuniao),
    FOREIGN KEY (Cliente)
		REFERENCES Cliente (Numero_cliente),
    FOREIGN KEY (Secretario)
		REFERENCES Secretario (Numero_secretario),
    FOREIGN KEY (Detetive)
		REFERENCES Detetive (Numero_detetive),
    FOREIGN KEY (Homicidio)
		REFERENCES Homicidio (Numero_homicidio))
ENGINE = InnoDB;

-- Criação de índices: chaves estrangeiras da tabela "Reuniao"
CREATE INDEX idxReuniaoCliente
	ON Reuniao (Cliente ASC) VISIBLE;
CREATE INDEX idxReuniaoSecretario
	ON Reuniao (Secretario ASC) VISIBLE;
CREATE INDEX idxReuniaoDetetive
	ON Reuniao (Detetive ASC) VISIBLE;
CREATE INDEX idxReuniaoHomicidio
	ON Reuniao (Homicidio ASC) VISIBLE;

-- Criação da tabela Homicidio_e_investigado_Detetive
CREATE TABLE Homicidio_e_investigado_Detetive (
  Detetive INT NOT NULL,
  Homicidio INT NOT NULL,
  Horas INT NOT NULL DEFAULT 0 CHECK (Horas >= 0),
	PRIMARY KEY (Detetive, Homicidio),
	FOREIGN KEY (Detetive)
		REFERENCES Detetive (Numero_detetive),
    FOREIGN KEY (Homicidio)
		REFERENCES Homicidio (Numero_homicidio))
ENGINE = InnoDB;

-- Criação de índices: chaves estrangeiras da tabela "Homicidio_e_investigado_Detetive"
CREATE INDEX idxHomicidioDetetiveDetetive
	ON Homicidio_e_investigado_Detetive (Detetive ASC) VISIBLE;
CREATE INDEX idxHomicidioDetetiveHomicidio
	ON Homicidio_e_investigado_Detetive (Homicidio ASC) VISIBLE;

-- Criação da tabela Prova
CREATE TABLE Prova (
  Numero_prova INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(300) NOT NULL,
  Link VARCHAR(150) NOT NULL,
  Local_prova VARCHAR(150) NOT NULL,
  Data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Custo DECIMAL(7,2) NOT NULL CHECK (Custo>=0),
  PRIMARY KEY (Numero_prova))
ENGINE = InnoDB;

CREATE UNIQUE INDEX idxProvaLink
	ON Prova (Link ASC) VISIBLE;

-- Criação da tabela Homicidio_tem_Prova
CREATE TABLE Homicidio_tem_Prova (
  Homicidio INT NOT NULL,
  Prova INT NOT NULL,
  PRIMARY KEY (Homicidio, Prova),
    FOREIGN KEY (Homicidio)
		REFERENCES Homicidio (Numero_homicidio),
    FOREIGN KEY (Prova)
		REFERENCES Prova (Numero_prova))
ENGINE = InnoDB;

-- Criação de índices: chaves estrangeiras da tabela "Homicidio_tem_Prova"
CREATE INDEX idxHomicidioProvaHomicidio
	ON Homicidio_tem_Prova (Homicidio ASC) VISIBLE;
CREATE INDEX idxHomicidioProvaProva
	ON Homicidio_tem_Prova (Prova ASC) VISIBLE;

-- Criação da tabela Prova_e_recolhida_Detetive
CREATE TABLE Prova_e_recolhida_Detetive(
  Detetive INT NOT NULL,
  Prova INT NOT NULL,
  PRIMARY KEY (Detetive, Prova),
	FOREIGN KEY (Detetive)
    REFERENCES Detetive (Numero_detetive),
    FOREIGN KEY (Prova)
    REFERENCES Prova (Numero_prova))
ENGINE = InnoDB;

-- Criação de índices: chaves estrangeiras da tabela "Prova_e_recolhida_Detetive"
CREATE INDEX idxProvaDetetiveDetetive
	ON Prova_e_recolhida_Detetive (Detetive ASC) VISIBLE;
CREATE INDEX idxProvaDetetiveProva
	ON Prova_e_recolhida_Detetive (Prova ASC) VISIBLE;

-- Criação da tabela Suspeito
CREATE TABLE Suspeito (
  Numero_suspeito INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(75) NOT NULL,
  Genero CHAR(1) NOT NULL CHECK (Genero IN ('M','F')),
  Data_nascimento DATE NOT NULL,
  Ocupacao VARCHAR(75) NOT NULL,
  Historico_criminal VARCHAR(150) NOT NULL,
  Rua VARCHAR(75) NOT NULL,
  Localidade VARCHAR(50) NOT NULL,
  Codigo_postal CHAR(8) NOT NULL,
  Telefone CHAR(12) NOT NULL CHECK (Telefone REGEXP '[0-9]'),
  Descricao VARCHAR(400) NOT NULL,
	PRIMARY KEY (Numero_suspeito))
ENGINE = InnoDB;

-- Criação da tabela Testemunha
CREATE TABLE Testemunha (
  Numero_testemunha INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(75) NOT NULL,
  Telefone CHAR(12) NOT NULL CHECK (Telefone REGEXP '[0-9]'),
	PRIMARY KEY (Numero_testemunha))
ENGINE = InnoDB;

-- Criação da tabela Testemunha_de_Homicidio
CREATE TABLE Testemunha_de_Homicidio(
  Testemunha INT NOT NULL,
  Homicidio INT NOT NULL,
  Resumo_testemunho VARCHAR(300) NOT NULL,
  Link_testemunho VARCHAR(150) NOT NULL,
  PRIMARY KEY (Testemunha, Homicidio),
	FOREIGN KEY (Testemunha)
    REFERENCES Testemunha (Numero_testemunha),
    FOREIGN KEY (Homicidio)
    REFERENCES Homicidio (Numero_homicidio))
ENGINE = InnoDB;

-- Criação de índices: chaves estrangeiras da tabela "Testemunha_de_Homicidio"
CREATE INDEX idxTestemunhaHomicidioTestemunha
	ON Testemunha_de_Homicidio (Testemunha ASC) VISIBLE;
CREATE INDEX idxTestemunhaHomicidioHomicidio
	ON Testemunha_de_Homicidio (Homicidio ASC) VISIBLE;

-- Criação da tabela Suspeito_de_Homicidio
CREATE TABLE Suspeito_de_Homicidio(
  Suspeito INT NOT NULL,
  Homicidio INT NOT NULL,
  Relacao_vitima VARCHAR(75) NOT NULL,
  Observacoes VARCHAR(250) NOT NULL,
  PRIMARY KEY (Suspeito, Homicidio),
	FOREIGN KEY (Suspeito)
    REFERENCES Suspeito (Numero_suspeito),
    FOREIGN KEY (Homicidio)
    REFERENCES Homicidio (Numero_homicidio))
ENGINE = InnoDB;

-- Criação de índices: chaves estrangeiras da tabela "Suspeito_de_Homicidio"
CREATE INDEX idxSuspeitoHomicidioSuspeito
	ON Suspeito_de_Homicidio (Suspeito ASC) VISIBLE;
CREATE INDEX idxSuspeitoHomicidioHomicidio
	ON Suspeito_de_Homicidio (Homicidio ASC) VISIBLE;

-- Criação da tabela Prova_esta_associada_Suspeito
CREATE TABLE Prova_esta_associada_Suspeito(
  Prova INT NOT NULL,
  Suspeito INT NOT NULL,
  Observacoes VARCHAR(250) NOT NULL,
  PRIMARY KEY (Prova, Suspeito),
	FOREIGN KEY (Prova)
    REFERENCES Prova (Numero_prova),
    FOREIGN KEY (Suspeito)
    REFERENCES Suspeito (Numero_suspeito))
ENGINE = InnoDB;

-- Criação de índices: chaves estrangeiras da tabela "Prova_esta_associada_Suspeito"
CREATE INDEX idxProvaSuspeitoProva
	ON Prova_esta_associada_Suspeito (Prova ASC) VISIBLE;
CREATE INDEX idxProvaSuspeitoSuspeito
	ON Prova_esta_associada_Suspeito (Suspeito ASC) VISIBLE;
