
#a)
SELECT nome
From MEDICO 
WHERE idade (data_inicio_servico) > 10;

#b)
SELECT m.nome, e.designacao 
FROM MEDICO m, ESPECIALIDADE e
WHERE m.especialidade = e.id_especialidade;

SELECT m.nome, e.designacao
FROM MEDICO m INNER JOIN ESPECIALIDADE e ON m.especialidade = e.id_especialidade;

#c)
SELECT nome, morada
FROM PACIENTE p, CODIGO_POSTAL cp
WHERE p.codigo_postal = cp.codigo_postal and cp.localidade = 'Braga';

#d)
SELECT nome
FROM MEDICO m, ESPECIALIDADE e
WHERE m.especialidade = e.id_especialidade and e.designacao = 'Oftalmologia';

#e)
SELECT m.nome, idade(m.data_inicio_servico)
FROM MEDICO m, ESPECIALIDADE e
WHERE m.especialidade = e.id_especialidade and idade(m.data_inicio_servico) > 40 and e.designacao = 'Clínica Geral'; 

#f)
SELECT DISTINCT m.nome
FROM MEDICO m, ESPECIALIDADE e, CONSULTA c, CODIGO_POSTAL cp
WHERE m.especialidade = e.id_especialidade and e.designacao = 'Oftalmologia' and c.id_medico = m.id_medico and m.codigo_postal = cp.codigo_postal and cp.localidade = 'Braga';

#g)
SELECT m.nome, idade(m.data_inicio_servico) AS 'Idade'
FROM MEDICO m, CONSULTA c, PACIENTE p
WHERE idade(m.data_nascimento) > 50  and c.id_medico = m.id_medico and c.id_paciente = p.id_paciente and idade(p.data_nascimento) < 20 and HOUR(c.data_hora) >= 12;
#h)
SELECT p.nome, idade(p.data_nascimento) AS 'Idade'
FROM PACIENTE p
WHERE idade(p.data_nascimento) > 10
and p.id_paciente NOT IN ( SELECT DISTINCT p.id_paciente
						   FROM MEDICO m, PACIENTE p, CONSULTA c, ESPECIALIDADE e
						   WHERE c.id_medico = m.id_medico and c.id_paciente = p.id_paciente and m.especialidade = e.id_especialidade and e.designacao = 'Oftalmologia');

#i)
SELECT DISTINCT e.designacao
FROM ESPECIALIDADE e, CONSULTA c, MEDICO m
WHERE c.id_medico = m.id_medico and m.especialidade = e.id_especialidade and YEAR(c.data_hora) = 2016 and MONTH(c.data_hora) = 1;

#j)
SELECT m.nome
FROM MEDICO m
WHERE idade(m.data_nascimento) > 30 or idade(m.data_inicio_servico) < 5;

#k)
SELECT DISTINCT m.nome
FROM MEDICO m, CONSULTA c
WHERE c.id_medico = m.id_medico
and m.id_medico NOT IN ( SELECT m.id_medico
						 FROM MEDICO m, CONSULTA c
                         WHERE c.id_medico = m.id_medico and YEAR(c.data_hora) = 2016 and MONTH(c.data_hora) = 1);

#l)
SELECT DISTINCT id_paciente
FROM CONSULTA c
WHERE NOT EXISTS ( SELECT m.id_medico
				   FROM MEDICO m
				   WHERE m.id_medico NOT IN ( SELECT cc.id_medico
											  FROM CONSULTA cc
                                              WHERE cc.id_paciente = c.id_paciente ) );

#m)
SELECT DISTINCT e.designacao
FROM ESPECIALIDADE e, CONSULTA c, MEDICO m
WHERE c.id_medico = m.id_medico and m.especialidade = e.id_especialidade and YEAR(c.data_hora) = 2016 and MONTH(c.data_hora) = 1 or MONTH(c.data_hora) = 3;

#n)
SELECT DISTINCT m.nome 
FROM MEDICO m
WHERE m.id_medico NOT IN ( SELECT m1.id_medico
						   FROM MEDICO m1, CONSULTA c, PACIENTE p, CODIGO_POSTAL cp
                           WHERE c.id_medico = m1.id_medico and c.id_paciente = p.id_paciente and p.codigo_postal = cp.codigo_postal and cp.localidade = 'Braga' );

#o)
SELECT DISTINCT p.nome, idade(p.data_nascimento) AS 'Idade'
FROM PACIENTE p, CONSULTA c, ESPECIALIDADE e, MEDICO m
WHERE p.id_paciente NOT IN ( SELECT p1.id_paciente
							 FROM PACIENTE p1
                             WHERE c.id_paciente = p1.id_paciente and c.id_medico = m.id_medico and m.especialidade = e.id_especialidade and e.designacao <> 'Clinica Geral' );




