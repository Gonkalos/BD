use mydb;

#1
select c.PagCaderneta
from Cromo c, Jogador j, Posicao p, Equipa e 
where c.Jogador = j.Nr and j.Posicao = p.Id and j.Equipa = e.Id and p.Designacao = 'Defesa' and (e.Designacao = 'Sporting Clube de Braga' or e.Designacao = 'Rio Ave Futebol Clube');

#2
select c.Nr, j.Nome, e.Treinador, p.Designacao
from Cromo c, Jogador j, Equipa e, Posicao p
where c.Jogador = j.Nr and j.Posicao = p.Id and j.Equipa = e.Id and p.Designacao not in ('Médio','Defesa') and e.Treinador in ('Jorge Jesus','Nuno espírito Santo')
order by c.Nr asc;

#3
create view CromosEmFalta as 
select c.Nr, j.Nome, e.Designacao as Equipa
from Cromo c, Jogador j, Equipa e
where c.Jogador = j.Nr and j.Equipa = e.Id and c.Adquirido = 'N';

select * from CromosEmFalta;

#4
Delimiter $$
create procedure CromosEquipa (in nomeEquipa varchar(45))
begin

	select c.Nr
    from Equipa e, Jogador j, Cromo c
    where c.Jogador = j.Nr and j.Equipa = e.Id and e.Designacao = nomeEquipa
    order by Cromo.PagCaderneta, Cromo.Nr asc;

end $$
Delimiter ;

call CromosEquipa('Sport Lisboa e Benfica');

#5
Delimiter $$
create procedure ListaCadernetaCompleta ()
begin
	select Cromo.Nr, Cromo.Tipo, Jogador.Nome, Equipa.Designacao, Cromo.Adquirido
    from Cromo left outer join Jogador on Cromo.Jogador = Jogador.Nr
			   left outer join Equipa on Jogador.Equipa = Equipa.Id
               left outer join TipoCromo on Cromo.Tipo = TipoCromo.Nr;
end $$
Delimiter ;

call ListaCadernetaCompleta();

#6
Delimiter $$
create function CromoRepetido (numeroCromo int) returns char(1)
not deterministic
begin
	
    declare adq char(1);
    
    select CromosAdquiridos into adq
    from Cromo
    where Cromo.Nr = numeroCromo;
    
    return (adq);
    
end $$
Delimiter ;

select CromoRepetido(37);

#7
Delimiter $$
create function CromoInfo (numeroCromo int) returns varchar(200)
not deterministic
begin

	declare tipo varchar(75);
    declare jogador varchar(75);
    declare equipa varchar(45);
    
    select TipoCromo.Descricao, Jogador.Nome, Equipa.Designacao into tipo, jogador, equipa
    from TipoCromo, Jogador, Equipa, Cromo
    where Cromo.tipo = TipoCromo.Nr and Cromo.jogador = Jogador.nr and Jogador.equipa = Equipa.id and Cromo.nr = numeroCromo;
    
    return (concat(tipo, ", ", jogador, ", ", equipa));

end $$
Delimiter ;


    
    
    
    
    
    
    
    
    

	



	
    


