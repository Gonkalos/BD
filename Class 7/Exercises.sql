USE Clinica;

#a)
SELECT avg(idade(data_nascimento))
FROM MEDICO m
WHERE idade(m.data_inicio_servico) > 15;

#b)
SELECT e.designacao, avg(idade(m.data_inicio_servico))
FROM MEDICO m INNER JOIN ESPECIALIDADE e ON m.especialidade = e.id_especialidade
GROUP BY e.designacao;

#c)
SELECT m.nome, count(c.id_medico)
FROM MEDICO m LEFT JOIN CONSULTA c ON c.id_medico = m.id_medico
GROUP BY m.id_medico;

#d)
SELECT cp.localidade, avg(idade(p.data_nascimento))
FROM PACIENTE p, CODIGO_POSTAL cp
WHERE p.codigo_postal = cp.codigo_postal
GROUP BY cp.localidade;

#e)
SELECT m.id_medico, m.nome, sum(c.preco)
FROM MEDICO m LEFT JOIN CONSULTA c ON c.id_medico = m.id_medico and year(c.data_hora) = 2016
GROUP BY m.id_medico;

#f)
SELECT e.designacao, count(m.id_medico)
FROM MEDICO m INNER JOIN ESPECIALIDADE e ON m.especialidade = e.id_especialidade
GROUP BY e.designacao;

#g)
SELECT NumeroEspecialidade.designacao, max(c.preco), min(c.preco), avg(c.preco)
FROM ( SELECT e.designacao, e.id_especialidade, count(m.id_medico) as qtd
       FROM ESPECIALIDADE e INNER JOIN MEDICO m ON e.id_especialidade = m.especialidade
       GROUP BY e.id_especialidade, e.designacao ) as NumeroEspecialidade,
       MEDICO m, CONSULTA c
WHERE c.id_medico = m.id_medico and NumeroEspecialidade.qtd < 2 and m.especialidade = NumeroEspecialidade.id_especialidade
GROUP BY NumeroEspecialidade.designacao;

#h)
SELECT m.nome
FROM MEDICO m, CONSULTA c
WHERE m.id_medico = c.id_medico and year(c.data_hora) = 2016
GROUP BY m.id_medico
HAVING sum(preco) > ( SELECT avg(Faturado2016.faturado)
                      FROM ( SELECT m.nome, sum(c.preco) as faturado
							 FROM MEDICO m, CONSULTA c
                             WHERE m.id_medico = c.id_medico and year(c.data_hora) = 2016
                             GROUP BY m.nome ) as Faturado2016 );

#i)
SELECT e.designacao, sum(c.preco) as valor
FROM ESPECIALIDADE e, MEDICO m, CONSULTA c
WHERE e.id_especialidade = m.especialidade and c.id_medico = m.id_medico and year(c.data_hora) = 2016
GROUP BY e.designacao
ORDER BY valor
LIMIT 2;

#j)
SELECT m.nome, count(1) as qtd
FROM MEDICO m, CONSULTA c
WHERE m.id_medico = c.id_medico and year(c.data_hora) = 2016
GROUP BY m.id_medico
ORDER BY qtd DESC
LIMIT 3;







