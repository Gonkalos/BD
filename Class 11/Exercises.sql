use mydb;

#1
create table if not exists ListaFaltas (NrCromo int primary key);


#2
Delimiter $$
create procedure povoarListaFaltas (in total int) 
begin

	declare adq char(1) default 'N';
    
    my_loop : loop
		
        if (total = 0) then leave my_loop;
        end if;
        
        set adq = 'N';
        
        select adquirido into adq from Cromo where Nr = total;
        
        if (adq = 'N') then insert into ListaFaltas values (total);
        end if;
        
        set total = total - 1;
        
	end loop;
    
end $$
Delimiter ;

call povoarListaFaltas(350);

select * from ListaFaltas;


#3
Delimiter $$
create procedure adquirirCromo (in NrCromoAdq int) 
begin

	declare erro bool default 0;
    
    declare continue handler for sqlexception set erro = 1;
    
    set AUTOCOMMIT = OFF;
    
    start transaction;

	update Cromo set adquirido = 'S' where Nr = NrCromoAdq;
	delete from ListaFaltas where NrCromo = NrCromoAdq;
    
    if (erro) then rollback;
    end if;
    
    commit;
    
end $$
Delimiter ;

call adquirirCromo(70);

select * from ListaFaltas;


#4
Delimiter $$
create procedure adquirirCromoReverse (in NrCromoAdq int) 
begin

	declare erro bool default 0;
    
    declare continue handler for sqlexception set erro = 1;
    
    set AUTOCOMMIT = OFF;
    
    start transaction;

	update Cromo set adquirido = 'N' where Nr = NrCromoAdq;
	insert into ListaFaltas values (NrCromoAdq);
    
    if (erro) then rollback;
    end if;
    
    commit;
    
end $$
Delimiter ;

call adquirirCromoReverse(35);

select * from ListaFaltas;


#5
Delimiter $$
create trigger adquirirCromoTrigger after update on Cromo
for each row
begin

	if (old.adquirido = 'N' and new.adquirido = 'S') then delete from listaFaltas where NrCromo = old.Nr;
    end if;

end $$
Delimiter $$
    
select * from ListaFaltas;


#6
Delimiter $$
create procedure listagem (in idEquipa char(3), out result_list varchar(2000))
begin

	declare v_finished int default 0;
    declare v_treinador varchar(50);
    declare v_nome_equipa varchar(45);
    declare v_nome_jogador varchar(75);
    declare v_posicao varchar(20);
    
    declare jogador_cursor cursor for
    select j.Nome, p.Designacao
    from Jogador j, Posicao p 
    where j.posicao = p.id and j.equipa = idEquipa;
    
    select treinador, designacao into v_treinador, v_nome_equipa
    from equipa
    where Id = idEquipa;
    
    set result_list = concat(v_nome_equipa, ";", v_treinador);
    
    open jogador_cursor;
    
    get_jogador : loop
    
		fetch jogador_cursor into v_nome_jogador, v_posicao;
        
        if v_finished = 1 then leave get_jogador;
        end if;
        
        set result_list = concat(result_list, ";", v_nome_jogador, ":", v_posicao);
        
	end loop;
    
    close jogador_cursor;

end $$
Delimiter ;

set @res = "";
call listagem('SLB',@res);
select @res;
    
    
	


