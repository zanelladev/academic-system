CREATE TABLE departamento(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(100),
	endereco VARCHAR(300),
	PRIMARY KEY (id)
);

CREATE TABLE curso(
	id INT NOT NULL AUTO_INCREMENT,
	categoria VARCHAR(50),
	PRIMARY KEY (id)
);

CREATE TABLE disciplina(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(100),
	creditos INT,
	dificuldade VARCHAR(20),
	preRequisitos VARCHAR(300),
	PRIMARY KEY (id)
);

CREATE TABLE professor(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(100),
	regime VARCHAR(50),
	carreira VARCHAR(50),
	status BIT,
	PRIMARY KEY (id)
);

CREATE TABLE portaria(
	id INT NOT NULL AUTO_INCREMENT,
	nivel VARCHAR(30),
	classificacao VARCHAR(30),
	dataInicio DATE,
	dataTermino DATE,
	PRIMARY KEY (id)
);

CREATE TABLE artigo(
	id INT NOT NULL AUTO_INCREMENT,
	dataInicio DATE,
	dataFinal DATE,
	qualis VARCHAR(100),
	PRIMARY KEY (id)
);

CREATE TABLE aluno(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(100),
	fk_professor_id INT,
	PRIMARY KEY (id),
	CONSTRAINT fk_Professor FOREIGN KEY (fk_professor_id) REFERENCES professor (id)
);

CREATE TABLE turma(
	id INT NOT NULL AUTO_INCREMENT,
	nAlunos INT,
	dataInicio DATE,
	dataFinal DATE,
	fk_professor_id INT,
	fk_disciplina_id INT,
	PRIMARY KEY(id),
	FOREIGN KEY (fk_professor_id) REFERENCES professor (id),
	FOREIGN KEY (fk_disciplina_id) REFERENCES disciplina (id)
);

CREATE TABLE departamento_professor(
	fk_departamento_id INT,
	fk_professor_id INT,
	FOREIGN KEY (fk_professor_id) REFERENCES professor (id),
	FOREIGN KEY (fk_departamento_id) REFERENCES departamento (id)
);

CREATE TABLE departamento_curso(
	fk_departamento_id INT,
	fk_curso_id INT,
	FOREIGN KEY (fk_departamento_id) REFERENCES departamento (id),
	FOREIGN KEY (fk_curso_id) REFERENCES curso (id)
);

CREATE TABLE curso_disciplina(
	fk_disciplina_id INT,
	fk_curso_id INT,
	FOREIGN KEY (fk_disciplina_id) REFERENCES disciplina (id),
	FOREIGN KEY (fk_curso_id) REFERENCES curso (id)
);

CREATE TABLE disciplina_aluno(
	id INT NOT NULL AUTO_INCREMENT,
	nota DECIMAL,
	fk_disciplina_id INT,
	fk_aluno_id INT,
	PRIMARY KEY(id),
	FOREIGN KEY (fk_disciplina_id) REFERENCES disciplina (id),
	FOREIGN KEY (fk_aluno_id) REFERENCES aluno (id)
);

CREATE TABLE turma_aluno(
	fk_turma_id INT,
	fk_aluno_id INT,
	FOREIGN KEY (fk_turma_id) REFERENCES turma (id),
	FOREIGN KEY (fk_aluno_id) REFERENCES aluno (id)
);

CREATE TABLE substituicao(
	id INT NOT NULL AUTO_INCREMENT,
	qDias INT,
	motivo VARCHAR(300),
	dataInicio DATE,
	dataTermino DATE,
	fk_professor_id INT,
	fk_professorSubstituto_id INT,
	PRIMARY KEY(id),
	FOREIGN KEY (fk_professor_id) REFERENCES professor (id),
	FOREIGN KEY (fk_professorSubstituto_id) REFERENCES professor (id)
);

CREATE TABLE portaria_professor(
	fk_professor_id INT,
	fk_portaria_id INT,
	FOREIGN KEY (fk_professor_id) REFERENCES professor (id),
	FOREIGN KEY (fk_portaria_id) REFERENCES portaria (id)
);

--a
SELECT id, id_professor, qDias, dataInicio, dataFinal
FROM substituicao
ORDER BY id DESC;

--b
SELECT *
FROM artigo
ORDER BY qualis;

--c
SELECT portaria_professor.fk_professor_id , portaria.id, portaria.dataInicio, portaria.dataFinal, portaria.nivel
FROM portaria_professor, portaria
ORDER BY portaria.nivel;

--d
select p.nome, count(a.id)
from professor p
inner join alunos a;

--e
SELECT n.nota
FROM disciplina_aluno n
inner join turma t
inner join disciplina d
where t.id = 1 and d.discplina and t.dataInicio > '2022-02-01' and t.dataFinal < '2022-07-04';

--f
select a.*
from alunos a
inner join curso c
inner join departamento d
where c.id = 1 and d.id = 1;

--g
select *
from turma
where fk_professor_id = 1 and dataInicio > '2022-02-01' and dataFinal < '2022-07-04';

--h
select p.*
from professor p
inner join departamento_professor d
where d.fk_departamento_id = 1
group by carreira;

--i
select p.*
from professor p
inner join departamento_professor d
where d.fk_departamento_id = 1
group by regime;

--j
select count (id)
from turma
where fk_disciplina_id = 1 and dataInicio > '2022-02-01' and dataFinal < '2022-07-04';;