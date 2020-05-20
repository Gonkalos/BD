insert into Especialidade (Designacao) Values ('Clinica Geral'),('Cardiologia'),('Fisioterapia'),('Pneumologia'),('Oftalmologia'),('Psiquiatria'),('Ortopedia');

insert into Codigo_Postal values ('4700-001','Braga'),('4700-002','Braga'),('4700-003','Braga'),('4700-004','Braga'),('4700-005','Braga'),('4700-006','Braga'),('4700-007','Braga');

insert into Medico (Nome,Morada,Data_Nascimento,Data_Inicio_Servico,idEspecialidade,Codigo_Postal) values ('Jose Maria','Rua de Cima n.º 223, 5.º DTO','1970-01-23','1990-02-23',1,'4700-001'),('Antonio Pinto','Rua de Baixo n.º 125, 2.º ESQ','1991-11-21','2013-01-23',2,'4700-002'),('Manuel Maria Neves','Rua de Sul n.º 789, 9.º DTO','1964-03-24','1989-07-23',3,'4700-003'),('Pedro Pinto Silva','Rua de Este n.º 456, 1.º DTO','1978-02-13','1990-01-23',4,'4700-004'),('Marta Catarina','Rua do Eixo n.º 120, 3.º ESQ','1960-09-11','1981-05-23',5,'4700-005'),('Alberto Trovoadas','Rua da Beira n.º 312, 3.º DTO','1984-01-12','2000-07-23',6,'4700-006'),('Candido Faisca','Rua da Ponta n.º 21, 2.º DTO','1964-11-24','1989-03-23',7,'4700-007');

insert into Contacto_medico (Contacto,idMedico) values ('968765432',1),('914536741',2),('939645381',3),('969126483',4),('931234567',5),('937563819',6),('919235462',7),('253002134',1),('antonio91@gmail.com',2);

insert into Categoria (Designacao) values ('Pré-Competição'),('Cadete'),('Infantil'),('Juvenil'),('Júnior'),('Master');

insert into Clube (Nome,Morada,Data_Fundacao,Codigo_Postal) values ('Clube de Atletismo de Braga','Rua de Cima n.º 53','1970-05-23','4700-001'),('Clube Salta Alto','Rua de Este n.º 4','1998-02-12','4700-004'),('Clube Corre Bem','Rua da Beira n.º 32','2000-03-05','4700-006');

insert into Contacto_Clube (Contacto,idClube) values ('253009856',1),('253006574',2),('253001278',3),('atletismo.braga@gmail.com',1);

insert into Modalidade (Designacao) values ('Corrida Pistas Ovais-100m'),('Corrida Pistas Ovais-200m'),('Corrida Pistas Ovais-400m'),('Corrida Meio Fundo-800m'),('Corrida Meio Fundo-1500m'),('Corrida Meio Fundo-3000m'),('Corrida Obstáculos-100m'),('Corrida Obstáculos-200m'),('Corrida Obstáculos-400m'),('Maratona'),('Lançamento Peso-7,26Kg'),('Lançamento Peso-4Kg'),('Lançamento Disco-2Kg'),('Lançamento Disco-1Kg'),('Lançamento Dardo-800g'),('Lançamento Dardo-600g'),('Salto em Altura'),('Salto com Vara'),('Salto em Comprimento'),('Triplo Salto');

insert into Atleta (Nome,Sexo,Peso,Altura,Morada,Data_Nascimento,idClube,idCategoria,Codigo_Postal) values ('Fernando Fosforos','M',70.20,1.80,'Rua de Cima nº43','1990-08-23',1,6,'4700-001'),('Adelina Correia','F',60.35,1.60,'Rua de Baixo n.º 132, 5.º DTO','2001-04-05',2,5,'4700-002'),('Pedro Cerdeira','M',40.50,1.50,'Rua de Sul n.º 34','2010-08-09',3,1,'4700-003'),('Gestrudes Vieira','F',60.27,1.60,'Rua de Este n.º 6, 14.º ESQ','2005-12-01',1,3,'4700-004'),('Alexandre Silva','M',65.33,1.69,'Rua do Eixo n.º 3','2007-01-23',3,2,'4700-005'),('Eduardo Fernandes','M',77.20,1.77,'Rua da Beira n.º 312, 3.º DTO','2003-05-06',2,4,'4700-006'),('Andre Costa','M',100.20,2.10,'Rua da Ponta n.º 212, 4.º DTO','1980-02-02',1,6,'4700-007'),('Antonio Trovao','M',72.23,1.84,'Rua de Este n.º 67','1999-11-23',2,6,'4700-004');

insert into Contacto_Atleta (Contacto,idAtleta) values ('938475613',1),('967364901',2),('912746040',3),('910000456',4),('961115543',5),('918883400',6),('967722901',7),('948300199',8),('253009845',8),('fernando.90@gmail.com',1);

insert into Modalidade_Atleta values (1,1,20,20),(2,1,10,15),(3,1,30,18),(4,2,10,10),(5,2,22,9),(6,2,17,12),(7,3,8,5),(8,3,10,4),(9,3,12,2),(12,4,24,10),(14,4,10,7),(16,4,19,4),(10,5,24,2),(11,6,20,5),(13,6,9,3),(15,6,28,5),(18,7,30,20),(17,8,23,10),(19,8,15,15),(20,8,25,17);

insert into Teste_Clinico (Estado,Preco,Data_Inicio,Data_Fim,idAtleta,idMedico) values ('A',429.23,'2020-01-10 10:00:00',NULL,1,1),('A',200.33,'2020-01-05 11:00:00',NULL,2,2),('R',345.50,'2019-12-28 10:00:00','2019-12-28 10:30:00',3,3),('R',123.23,'2019-12-06 14:00:00','2019-12-06 14:30:00',4,4),('A',543.60,'2020-01-30 10:00:00',NULL,5,5),('R',1050.30,'2019-12-30 09:00:00','2019-12-30 09:30:00',6,6),('A',299.99,'2020-01-23 16:00:00',NULL,7,7),('A',400.33,'2020-01-07 15:00:00',NULL,8,1),('R',150.40,'2019-11-30 10:00:00','2019-11-30 10:30:00',1,4);
