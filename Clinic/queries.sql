DELIMITER $$
CREATE FUNCTION `idade`(dta date) RETURNS int
BEGIN
RETURN TIMESTAMPDIFF(YEAR, dta, CURDATE());
END $$
DELIMITER ;

# 6

select count(1) as NAtletas from Atleta;

# 14

select m.Nome, count(1) as NTestes from Medico m, Teste_Clinico tc where m.idMedico = tc.idMedico group by m.idMedico order by NTestes DESC limit 5;

# 15

select m.Nome, idade(Data_Inicio_Servico) as AnoServico from Medico m order by AnoServico DESC limit 5;

# 7

DROP PROCEDURE IF EXISTS atletas_medico;

DELIMITER $$
CREATE PROCEDURE atletas_medico (IN nome_medico VARCHAR(45))
BEGIN
select a.Nome from Medico m inner join Teste_Clinico tc on m.idMedico = tc.idMedico inner join Atleta a on tc.idAtleta = a.idAtleta and m.Nome = nome_medico;
END $$
DELIMITER ;

call atletas_medico('Alberto Trovoadas');

# 16

select c.Nome, count(1) as NAtletas from Clube c inner join Atleta a on c.idClube = a.idClube group by c.Nome order by NAtletas DESC limit 3;

# 8

DROP PROCEDURE IF EXISTS atletas_localidade;

DELIMITER $$
CREATE PROCEDURE atletas_localidade (IN nome_localidade VARCHAR(45))
BEGIN
select a.Nome from Atleta a inner join Codigo_Postal cp on cp.Codigo_Postal = a.Codigo_Postal and cp.Localidade = nome_localidade;
END $$
DELIMITER ;

call atletas_localidade('Braga');

# 17

select md.Designacao, count(1) as Praticantes from Modalidade_Atleta ma inner join Modalidade md on ma.idModalidade = md.idModalidade group by ma.idModalidade order by Praticantes DESC limit 5;

# 10

DROP PROCEDURE IF EXISTS testes_medico_estado;

DELIMITER $$
CREATE PROCEDURE testes_medico_estado (IN nome_medico VARCHAR(45), IN nome_estado Char(1))
BEGIN
select tc.* from Medico m inner join Teste_Clinico tc on m.idMedico = tc.idMedico and m.Nome = nome_medico and tc.Estado = nome_estado;
END $$
DELIMITER ;

call testes_medico_estado('Alberto Trovoadas','R');

# 9

DROP PROCEDURE IF EXISTS testes_atleta_estado;

DELIMITER $$
CREATE PROCEDURE testes_atleta_estado (IN nome_atleta VARCHAR(45), IN nome_estado Char(1))
BEGIN
select tc.* from Atleta a inner join Teste_Clinico tc on a.idAtleta = tc.idAtleta and a.Nome = nome_atleta and tc.Estado = nome_estado;
END $$
DELIMITER ;

call testes_atleta_estado('Fernando Fosforos','R');

# 11

select count(1) TotalTestes from Teste_Clinico tc where tc.Estado = 'A';

# 12

select c.Designacao, count(1) AtletasRegistados from Categoria c inner join Atleta a on c.idCategoria = a.idCategoria group by a.idCategoria order by AtletasRegistados DESC limit 1;

# 18

select a.Nome, sum(ma.Horas_Treino_Semanal) as TotalTreino from Atleta a inner join Modalidade_Atleta ma on a.idAtleta = ma.idAtleta group by ma.idAtleta order by TotalTreino DESC limit 5;

# 13

DROP PROCEDURE IF EXISTS atletas_anosPratica;

DELIMITER $$
CREATE PROCEDURE atletas_anosPratica (IN nome_modalidade VARCHAR(45))
BEGIN
select a.Nome, ma.Anos_Pratica from Atleta a inner join Modalidade_Atleta ma on a.idAtleta = ma.idAtleta inner join Modalidade m on ma.idModalidade = m.idModalidade and m.Designacao = nome_modalidade order by ma.Anos_Pratica ASC limit 3;
END $$
DELIMITER ;

call atletas_anosPratica('Maratona');

# 3

DROP PROCEDURE IF EXISTS inserir_clube;

DELIMITER $$
CREATE PROCEDURE inserir_clube (IN nome VARCHAR(45),IN morada VARCHAR(45),IN data_fundacao DATE,IN codigo_postal VARCHAR(45),IN localidade VARCHAR(45))
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=null;
select cp.Codigo_Postal into @A from Codigo_Postal cp where cp.Codigo_Postal = codigo_postal;
if(@A is null) then
insert into Codigo_Postal values (codigo_postal,localidade);
end if;
insert into Clube(Nome,Morada,Data_Fundacao,Codigo_Postal) values (nome,morada,data_fundacao,codigo_postal);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call inserir_clube('Clube clube','Rua da Vida nº3','1956-02-03','4720-601','Amares');

DROP PROCEDURE IF EXISTS inserir_contacto_clube;

DELIMITER $$
CREATE PROCEDURE inserir_contacto_clube (IN nome VARCHAR(45),IN contacto VARCHAR(45))
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=0;
select c.idClube into @A from Clube c where c.Nome = nome;
insert into Contacto_Clube (Contacto,idClube) values (contacto,@A);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call inserir_contacto_clube('Clube clube','253998754');

# 1

DROP PROCEDURE IF EXISTS inserir_atleta;

DELIMITER $$
CREATE PROCEDURE inserir_atleta (IN nome VARCHAR(45),IN sexo CHAR(1),IN Peso DECIMAL(5,2),IN Altura DECIMAL(3,2),IN morada VARCHAR(45),IN data_nascimento DATE,IN clube VARCHAR(45),IN categoria VARCHAR(45),IN codigo_postal VARCHAR(45),IN localidade VARCHAR(45))
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=null;
set @B:=null;
set @C:=null;
select cp.Codigo_Postal into @A from Codigo_Postal cp where cp.Codigo_Postal = codigo_postal;
if(@A is null) then
insert into Codigo_Postal values (codigo_postal,localidade);
end if;
select c.idClube into @B from Clube c where c.Nome = clube;
select ca.idCategoria into @C from Categoria ca where ca.Designacao = categoria;
insert into Atleta (Nome,Sexo,Peso,Altura,Morada,Data_Nascimento,idClube,idCategoria,Codigo_Postal) values (nome,sexo,peso,altura,morada,data_nascimento,@B,@C,codigo_postal);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call inserir_atleta('Berto Ferreira','M',60.43,1.87,'Rua do Freixo nº89','1990-05-30','Clube clube','Master','4720-601','Amares');

DROP PROCEDURE IF EXISTS inserir_modalidade_atleta;

DELIMITER $$
CREATE PROCEDURE inserir_modalidade_atleta (IN nome VARCHAR(45),IN modalidade VARCHAR(45),IN ano_treino INT,IN horas_pratica INT)
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=null;
set @B:=null;
select a.idAtleta into @A from Atleta a where a.Nome = nome;
select m.idModalidade into @B from Modalidade m where m.Designacao = modalidade;
insert into Modalidade_Atleta values (@B,@A,horas_pratica,ano_treino);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call inserir_modalidade_atleta('Berto Ferreira','Maratona',10,20);


DROP PROCEDURE IF EXISTS inserir_contacto_atleta;

DELIMITER $$
CREATE PROCEDURE inserir_contacto_atleta (IN nome VARCHAR(45),IN contacto VARCHAR(45))
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=0;
select a.idAtleta into @A from Atleta a where a.Nome = nome;
insert into Contacto_Atleta (Contacto,idAtleta) values (contacto,@A);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call inserir_contacto_atleta('Berto Ferreira','253993200');

# 2

DROP PROCEDURE IF EXISTS inserir_medico;

DELIMITER $$
CREATE PROCEDURE inserir_medico (IN nome VARCHAR(45),IN morada VARCHAR(45),IN data_nascimento DATE,IN data_inicio_servico DATE,IN especialidade VARCHAR(45),IN codigo_postal VARCHAR(45),IN localidade VARCHAR(45))
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=null;
set @B:=null;
select cp.Codigo_Postal into @A from Codigo_Postal cp where cp.Codigo_Postal = codigo_postal;
if(@A is null) then
insert into Codigo_Postal values (codigo_postal,localidade);
end if;
select e.idEspecialidade into @B from Especialidade e where e.Designacao = especialidade;
insert into Medico (Nome,Morada,Data_Nascimento,Data_Inicio_Servico,idEspecialidade,Codigo_Postal) values (nome,morada,data_nascimento,data_inicio_servico,@B,codigo_postal);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call inserir_medico('Berto Menezes','Rua do Chão nº3','1970-05-21','1990-05-13','Clinica Geral','4720-601','Amares');

DROP PROCEDURE IF EXISTS inserir_contacto_medico;

DELIMITER $$
CREATE PROCEDURE inserir_contacto_medico (IN nome VARCHAR(45),IN contacto VARCHAR(45))
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=0;
select m.idMedico into @A from Medico m where m.Nome = nome;
insert into Contacto_medico (Contacto,idMedico) values (contacto,@A);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call inserir_contacto_medico('Berto Menezes','253990011');

# 4

DROP PROCEDURE IF EXISTS agendar_teste;

DELIMITER $$
CREATE PROCEDURE agendar_teste (IN nome VARCHAR(45),IN preco DECIMAL(6,2),IN data_inicio DATETIME, IN tipo VARCHAR(45))
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
set @A:=0;
set @B:=0;
select m.idMedico into @A from Medico m inner join Especialidade e on m.idEspecialidade = e.idEspecialidade and e.Designacao = tipo order by rand() limit 1;
select a.idAtleta into @B from Atleta a where a.Nome = nome;
insert into Teste_Clinico (Estado,Preco,Data_Inicio,Data_Fim,idAtleta,idMedico) values ('A',preco,data_inicio,null,@B,@A);
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call agendar_teste('Fernando Fosforos',123.45,'2020-04-21','Clinica Geral');

# 5

DROP PROCEDURE IF EXISTS realizar_consulta;

DELIMITER $$
CREATE PROCEDURE realizar_teste (IN id_teste INT)
BEGIN
declare erro Bool default 0;
declare continue handler for sqlexception set erro = 1;
start transaction;
update Teste_Clinico tc set tc.Estado = 'R', tc.Data_Fim = now() where tc.idTeste_Clinico = id_teste;
if erro then rollback;
else commit;
end if;
END $$
DELIMITER ;

call realizar_teste(8);