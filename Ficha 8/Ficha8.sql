USE Clinica;

SET GLOBAL log_bin_trust_function_creators = 1;



#a
DELIMITER $$
CREATE PROCEDURE updatePrice (IN ano int, percentagem int)
Begin

	DECLARE mediaEspecialidade INTEGER DEFAULT 0;
    DECLARE especialidadeID varchar(100) default "";
    DECLARE finished INTEGER DEFAULT 0;

	DECLARE cursorA CURSOR FOR SELECT e.id_especialidade, avg(e.preco) as media
							   FROM ESPECIALIDADE e, CONSULTA c, MEDICO m
							   WHERE c.id_medico = m.id_medico and m.especialidade = e.id_especialidade and year(c.data_hora) = ano;
      
	DECLARE CONTINUE HANDLER 
		FOR NOT FOUND SET finished = 1; 
                
	OPEN cursorA;
    
    my_loop : LOOP
        
		FETCH cursorA INTO especialidadeID, mediaEspecialidade;
        
        IF finished = 1 THEN LEAVE my_loop;
        END IF;
        
        UPDATE ESPECIALIDADE e
        SET e.preco = (mediaEspecialidade*(percentagem/100))
        WHERE e.id_especialidade = especialidadeID;
        
	END LOOP my_loop;
	
End $$ 
DELIMITER ;




#b
DELIMITER //
CREATE FUNCTION temConsultas (id int) RETURNS boolean
NOT DETERMINISTIC
BEGIN

	DECLARE result boolean DEFAULT false;
	
    IF (id IN ( SELECT m.id_medico FROM CONSULTA c, MEDICO m WHERE m.id_medico = c.id_medico )) 
    THEN SET result = true;
    END IF;
    
    RETURN result;
    
END //
DELIMITER ;




#c
DELIMITER $$
create function CodigoPostalUsado (CodPostal varchar(8)) returns bool
not deterministic
begin

	declare usado bool;
    declare resultado int;
    
    select count(1) into resultado
    from MEDICO m, PACIENTE p
    where m.codigo_postal = CodPostal or p.codigo_postal = CodPostal;
    
    if (resultado < 1)
    then set usado = false;
    else set usado = true;
    end if;
    
	return resultado;
    
end $$
DELIMITER ;




#d
alter table MEDICO
add totalFaturado decimal(8,2) default 0.0
after nome;


DELIMITER $$
create trigger acumularFaturado
after insert on CONSULTA
for each row 
begin

	update MEDICO m set m.totalFaturado = m.totalFaturado + new.preco where m.id_medico = new.id_medico;
    
end $$
DELIMITER ;




#e
create table if not exists AcumuladoPaciente (
	paciente int,
    mes int,
    ano int,
    valor decimal(8,2),
    constraint AcumuladorPaciente primary key (paciente, mes, ano)
);


























    









