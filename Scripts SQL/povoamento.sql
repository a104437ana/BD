-- Parte do povoamento da base de dados
-- inserir os dados na base de dados diretamente com instruções INSERT

USE agenciaDetetivesDB ;

INSERT INTO Secretario(Nome, NIF, Telefone, Salario, Email) VALUES
('Joana Miranda Amorim',112065783,351912345678,1000,'s1@detetivesminho.pt');

INSERT INTO Detetive(Nome, NIF, Telefone, Salario, Preco_por_hora,Email) VALUES
('Carolina Rodrigues Azevedo',796058458,351934567890,2000,11,'d1@detetivesminho.pt'),
('Fernando Gonçalves Oliveira',506036138,351917654321,1500,8,'d2@detetivesminho.pt'),
('João Pedro Cerqueira Costa',236525700,351965432109,1500,8,'d3@detetivesminho.pt');

INSERT INTO Cliente(Nome, Email, Telefone) VALUES
('Clara Costa Barbosa','claracbarbosa@gmail.com',351932064513),
('Joana Stefani Correia Pereira','stefanicorreiapereira@gmail.com',351915643021),
('André Gonçalves Azevedo','andreagzevedo@gmail.com',351923468156);

INSERT INTO Homicidio(Descricao, Local_homicidio, Data_homicidio, Hora,
                      Nome_vitima, Genero_vitima, Data_de_nascimento_vitima, Descricao_vitima, Estado_civil_vitima, Ocupacao_vitima) VALUES
('Vítima foi encontrada no seu escritório perto da meia noite, morreu de intoxicação',
 'Nº 120 Rua 25 de Abril - Serzedelo - Guimarães','2024-04-20','00:00:00',
 'Luis Barros Gomes','M','1977-06-15','Homem com 172 cm de altura peso de 100 kg, cabelo curto castanho','Casada','Contabilista'),
('Vítima foi morta com uma arma de fogo, foi encontrada numa cripta junto à igreja',
 'Rua Trás da Santa - Vale de Anta','2024-04-22',NULL,
  'Laura Ferreira Azevedo','F','1987-06-14','Mulher com 164 cm de altura peso de 72 kg, cabelo longo castanho claro','Divorciada','Empresária');

INSERT INTO Reuniao(Data_reuniao, Hora_inicio, Hora_fim, Custo_total, Data_de_pagamento, Cliente, Secretario, Detetive, Homicidio) VALUES
('2024-04-20','14:00:00','15:00:00','100',NULL,'1','1','1','1'),
('2024-04-21','15:00:00','16:00:00','100',NULL,'2','1','2','2'),
('2024-04-21','14:00:00','15:00:00','100',NULL,'3','1','3','1'),
('2024-04-22','14:00:00','15:00:00','200',NULL,'1','1','1','1'),
('2024-04-25','15:00:00','16:00:00','250',NULL,'2','1','3','2');

INSERT INTO Prova(Descricao, Link, Local_prova, Data_hora, Custo) VALUES
('Frasco partido encontrado num caixote do lixo','https://www.detetivesdominho.pt/login/provas/h1/p1.pdf',
  'Nº 120 Rua 25 Abril','2024-04-21 14:12:00', '12.00'),
('Vestígios de sangue encontrados na carpete','https://www.detetivesdominho.pt/login/provas/h1/p2.pdf',
 'Nº 120 Rua 25 Abril','2024-04-21 14:21:00', '52.50'),
('Fio de cabelo encontrado em cima do caixote do lixo','https://www.detetivesdominho.pt/login/provas/h1/p3.pdf',
 'Nº 120 Rua 25 Abril','2024-04-21 14:40:00', '60.25'),
('Arma de fogo pequena cinza de 0.22 mm, encontrada num beco a 200 m da Igreja de Valdanta','https://www.detetivesdominho.pt/login/provas/h2/p1.pdf',
 'Nº 10 Rua 1º de Maio','2024-04-24 18:32:00', '55.20');
-- ('Pegada de bota tamanho 40 na lama perto do Cemitério de Valdanta','https://www.detetivesdominho.pt/login/provas/h2/p2.pdf',
--  'Nº 2 Rua Trás da Santa - Vale de Anta','2024-04-23 08:02:00', '62.35');

INSERT INTO Suspeito(Nome, Genero, Data_nascimento, Ocupacao, Historico_criminal, Rua, Localidade, Codigo_postal, Telefone, Descricao) VALUES
('Joaquim Sousa Félix','M','1974-06-20','Comediante','Sem histórico','Nº 50 Rua 9 de Abril','Queluz','2745-155','351915035164',
 'Cerca de 170 cm de altura peso de 70 kg, cabelo castanho escuro longo, olhos castanhos, cara pálida'),
('Ana Maria Castro Felícia','F','1986-03-28','Psicóloga','Sem histórico','Nº 120 Rua Luis Simões','Queluz','2745-199','351934564823',
 'Cerca de 165 cm de altura peso de 60 kg, cabelo loiro longo, olhos castanhos, cara pálida'),
('Marcos Rodrigues Gomes','M','1960-06-26','Cantor','Sem histórico','Nº 10 Rua Carreira','Vale da Anta','5400-210','351920465312',
 'Cerca de 180 cm de altura peso de 90 kg, cabelo escuro curto, olhos castanhos, pele morena');

INSERT INTO Testemunha(Nome, Telefone) VALUES
('Maria Costa Ribeiro','351255126679'),
('Maria Castro Correia','351254648203');

INSERT INTO Homicidio_e_investigado_detetive(Detetive, Homicidio, Horas) VALUES
('1','1', '10'),
('3','1', '5'),
('2','2', '20'),
('3','2', '5'),
('1','2', '2');

INSERT INTO Prova_e_recolhida_detetive(Detetive, Prova) VALUES
('3','1'),
('1','2'),
('1','3'),
('2','4');
-- ('3','5');

INSERT INTO Homicidio_tem_prova(Homicidio, Prova) VALUES
('1','1'),
('1','2'),
('1','3'),
('2','4');
-- ('2','5');

INSERT INTO Suspeito_de_homicidio(Suspeito, Homicidio, Relacao_vitima, Observacoes) VALUES
('1','1','Nenhuma','Nenhuma'),
('2','1','Nenhuma','Nenhuma'),
('3','2','Ex-marido','Não se dava bem com a vítima');

INSERT INTO Prova_esta_associada_suspeito(Prova, Suspeito, Observacoes) VALUES
('2','1','Análise de sangue corresponde ao suspeito'),
('3','2','Análise do fio de cabelo corresponde à suspeita'),
('4','3','Foi visto a esconder algo onde a arma foi encontrada');

INSERT INTO Testemunha_de_homicidio(Testemunha, Homicidio, Resumo_testemunho, Link_testemunho) VALUES
('1','1','Ouviu barulho durante a noite e viu dois suspeitos a sair da casa da vítima por volta das 02:00 da manhã, pareciam ser um homem e uma mulher ambos magros',
 'https://www.detetivesdominho.pt/login/testemunhos/t1/t1.pdf'),
('2','2','Viu o ex-marido a esconder algo na Rua 1º de Maio no dia do homicídio',
 'https://www.detetivesdominho.pt/login/testemunhos/t2/t2.pdf');

UPDATE Reuniao SET Data_de_pagamento = '2024-04-20' WHERE Numero_reuniao = 1;
UPDATE Reuniao SET Data_de_pagamento = '2024-04-22' WHERE Numero_reuniao = 2;

-- UPDATE Prova SET Custo = 12.00 WHERE Numero_prova = 1;
-- UPDATE Prova SET Custo = 52.50 WHERE Numero_prova = 2;
-- UPDATE Prova SET Custo = 60.25 WHERE Numero_prova = 3;
-- UPDATE Prova SET Custo = 55.20 WHERE Numero_prova = 4;
-- UPDATE Prova SET Custo = 62.35 WHERE Numero_prova = 5;

-- UPDATE Homicidio_e_investigado_detetive SET Horas = 10 WHERE Detetive = 1 AND Homicidio = 1;
-- UPDATE Homicidio_e_investigado_detetive SET Horas = 5 WHERE Detetive = 3 AND Homicidio = 1;
-- UPDATE Homicidio_e_investigado_detetive SET Horas = 20 WHERE Detetive = 2 AND Homicidio = 2;
-- UPDATE Homicidio_e_investigado_detetive SET Horas = 5 WHERE Detetive = 3 AND Homicidio = 2;
-- UPDATE Homicidio_e_investigado_detetive SET Horas = 2 WHERE Detetive = 1 AND Homicidio = 2;

CALL sp_insere_prova(
  'Pegada de bota tamanho 40 na lama perto do Cemitério de Valdanta', -- prova
  'https://www.detetivesdominho.pt/login/provas/h2/p2.pdf', -- link
  'Nº 2 Rua Trás da Santa - Vale de Anta', -- local
  '2024-04-23 08:02:00', -- dia e hora da recolha
  '62.35', -- preço da prova
  '3', -- detetive
  '2', -- homicídio
  '3', -- suspeito
  'O tamanho do pé é o mesmo do suspeito', -- relação do suspeito e prova
  @vResultado);

UPDATE Homicidio SET Investigacao_encerrada = TRUE WHERE Numero_homicidio = 2;
