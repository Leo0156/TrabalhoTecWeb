create database Faculdade
default character set utf8 
default collate utf8_general_ci; 

create table Professor (   -- Cria a Tabela *Professor*
ra int auto_increment, -- Auto numéra os dados do campo "primary key"
apelido varchar(30) unique, -- Atributos da Tabela .. 
nome varchar(120), 
email varchar(80),
celular char(11),  
primary key (ra) -- declaração da chave Primaria  
)auto_increment = 1000 default charset utf8; -- declara norma UTF8 para os campos

create table Aluno (   -- Cria a Tabela *Aluno*
ra int auto_increment, -- Auto numéra os dados do campo "primary key"
nome varchar(120) , 
email varchar(80) ,
celular char(11) ,  
sigla_curso char(2),
primary key (ra), -- declaração da chave Primaria  
foreign key (sigla_curso) references Curso(sigla)
)auto_increment = 1000 default charset utf8; -- declara norma UTF8 para os campos


create table Disciplina (   -- Cria a Tabela *Diciplina*
id int auto_increment,
nome varchar(240) , -- Auto numéra os dados do campo "primary key" 
-- obs MYSQL não aceita vachar *(tinyint)* para auto increment lembra quando for relacionar
carga_horaria tinyint, 
teoria decimal(3,2),
pratica decimal(3,2),  
ementa varchar(500),
competencias varchar(500),
habilidades varchar(500),
conteudo varchar(500),
bibliografia_basica varchar(500),
bibliografia_complementar varchar(500),
primary key (id) -- declaração da chave Primaria  
)default charset utf8; -- declara norma UTF8 para os campos

create table curso (   -- Cria a Tabela *curso*
sigla int auto_increment, -- Auto numéra os dados do campo "primary key"
nome varchar(50) unique, 
primary key (sigla) -- declaração da chave Primaria  
)default charset utf8; -- declara norma UTF8 para os campos

create table GradeCurricular (   -- Cria a Tabela *GradeCurricular*
sigla_curso int,
ano smallint, -- "primary key" 
semestre char(1), 
primary key (sigla_curso,ano,semestre), -- declaração da chave Primaria
foreign key (sigla_curso) references Curso(sigla)  
)default charset utf8; -- declara norma UTF8 para os campos


create table Periodo(   -- Cria a Tabela *Periodo*
sigla_curso varchar(5), -- estrangeira de curso 
ano_grade smallint, -- estrangeira de GradeCurricular  
semestre_grade char(1), -- estrangeira de GradeCurricular
numero tinyint, -- Atributos numero auto nemerado e PKS  
primary key (sigla_curso, ano_grade, semestre_grade, numero), -- declaração da chave Primaria
foreign key (sigla_curso) references GradeCurricular(sigla_curso),
foreign key (ano_grade) references GradeCurricular(ano),
foreign key (semestre_grade) references GradeCurricular(semestre)
)default charset utf8; -- declaracão de Biblioteca 

create table PeriodoDisciplina(   -- Cria a Tabela *Periodo*
sigla_curso varchar(5), -- estrangeira de curso 
ano_grade smallint, -- estrangeira de GradeCurricular  
semestre_grade char(1), -- estrangeira de GradeCurricular  
numero_periodo tinyint, -- estrangeira de periodo 
id_disciplina int,
primary key(sigla_curso, ano_grade, semestre_grade, numero_periodo, id_disciplina),
foreign key (sigla_curso) references Periodo(sigla_curso),
foreign key (ano_grade) references Periodo(ano_grade),
foreign key (semestre_grade) references Periodo(semestre_grade),
foreign key (numero_periodo) references Periodo(numero),
foreign key (id_disciplina) references Disciplina(id)
)default charset utf8; -- declaracão de Biblioteca 

create table DisciplinaOfertada(
nome_disciplina varchar(50),
ano smallint,
semestre char(1),
primary key (nome_disciplina, ano, semestre),
foreign key (nome_disciplina) references Disciplina(nome)
)default charset utf8;

create table Turma (
nome_disciplina varchar(50),
ano_ofertado smallint,
semestre_ofertado char(1),
id char(1),
turno varchar(15),
ra_professor int,
primary key (nome_disciplina, ano_ofertado, semestre_ofertado, id),
foreign key (nome_disciplina) references DisciplinaOfertada(nome_disciplina),
foreign key (ano_ofertado) references DisciplinaOfertada(ano),
foreign key (semestre_ofertado) references DisciplinaOfertada(semestre),
foreign key (ra_professor) references Professor(ra_professor)
)default charset utf8;



create table Matricula(
ra_aluno int,
nome_disciplina varchar(50),
ano_ofertado smallint,
semestre_ofertado char(1),
id_turma char(1),
primary key (ra_aluno, nome_disciplina, ano_ofertado, semestre_ofertado, id_turma),
foreign key (ra_aluno) references Aluno(ra),
foreign key (nome_disciplina) references Turma(nome_disciplina),
foreign key (ano_ofertado) references Turma(ano_ofertado),
foreign key (semestre_ofertado) references Turma(semestre_ofertado),
foreign key (id_turma) references Turma(id)
)default charset utf8;



create table CursoTurma(
sigla_curso varchar(5),
nome_disciplina varchar(50),
ano_ofertado smallint,
semestre_ofertado char(1),
id_turma char(1),
primary key (sigla_curso, nome_disciplina, ano_ofertado, semestre_ofertado, id_turma),
foreign key (sigla_curso) references Curso(sigla),
foreign key (nome_disciplina) references Turma(nome_disciplina),
foreign key (ano_ofertado) references Turma(ano_ofertado),
foreign key (semestre_ofertado) references Turma(semestre_ofertado),
foreign key (id_turma) references Turma(id)
)default charset utf8;



create table Questao(
nome_disciplina varchar(50),
ano_ofertado smallint,
semestre_ofertado char(1),
id_turma char(1),
numero int,
data_limite_entrega date,
descricao varchar(200),
data date,
primary key (nome_disciplina, ano_ofertado, semestre_ofertado, id_turma, numero),
foreign key (nome_disciplina) references Turma(nome_disciplina),
foreign key (ano_ofertado) references Turma(ano_ofertado),
foreign key (semestre_ofertado) references Turma(semestre_ofertado),
foreign key (id_turma) references Turma(id)
)default charset utf8;


create table ArquivosQuestao(
nome_disciplina varchar(50),
ano_ofertado smallint,
semestre_ofertado char(1),
id_turma char(1),
numero_questao int,
arquivo varchar(200),
primary key (nome_disciplina, ano_ofertado, semestre_ofertado, id_turma, numero_questao, arquivo),
foreign key (nome_disciplina) references Questao(nome_disciplina),
foreign key (ano_ofertado) references Questao(ano_ofertado),
foreign key (semestre_ofertado) references Questao(semestre_ofertado),
foreign key (id_turma) references Questao(id_turma),
foreign key (numero_questao) references Questao(numero)
)default charset utf8;



create table Resposta(
nome_disciplina varchar(50),
ano_ofertado smallint,
semestre_ofertado char(1),
id_turma char(1),
numero_questao int,
ra_aluno int,
data_avaliacao date,
nota decimal (4,2),
avaliacao varchar(200),
descricao varchar(200),
data_de_envio date,
primary key (nome_disciplina, ano_ofertado, semestre_ofertado, id_turma, numero_questao, ra_aluno),
foreign key (nome_disciplina) references Questao(nome_disciplina),
foreign key (ano_ofertado) references Questao(ano_ofertado),
foreign key (semestre_ofertado) references Questao(semestre_ofertado),
foreign key (id_turma) references Questao(id_turma),
foreign key (numero_questao) references Questao(numero)
)default charset utf8;


create table ArquivosResposta(
nome_disciplina varchar(50),
ano_ofertado smallint,
semestre_ofertado char(1),
id_turma char(1),
numero_questao int,
ra_aluno int,
arquivo varchar(200),
primary key (nome_disciplina, ano_ofertado, semestre_ofertado, id_turma, numero_questao, ra_aluno, arquivo),
foreign key (nome_disciplina) references Resposta(nome_disciplina),
foreign key (ano_ofertado) references Resposta(ano_ofertado),
foreign key (semestre_ofertado) references Resposta(semestre_ofertado),
foreign key (id_turma) references Resposta(id_turma),
foreign key (numero_questao) references Resposta(numero_questao),
foreign key (ra_aluno) references Resposta(ra_aluno)
)default charset utf8;

drop database faculdade;



-----------------------------------------------



INSERT INTO professor VALUES 
	(default,'Dan','Daniel Morais','dmoraes@hotmail.com', 11980302112),
    (default,'Tata','Talita Nascimento','tata@hotmail.com', 11970251331),
    (default,'Biel','Emerson Gabriel','biel@hotmail.com', 11998603560),
	(default,'luceno','Lucas Damasceno','luceno@hotmail.com', 11947708327),
    (default,'lala','Leila Martins','leila@hotmail.com', 11970883609),
	(default,'neves','Letícia Neves','neves@gmail.com',11960578904),
    (default,'jana','Janaína Couto','jana@gmail.com',11957843302),
    (default,'rosa','Carlisson Rosa','rosa@gmail.com',11961456709),
    (default,'telles','Jackson Telles','telles@gmail.com',11985863341),
    (default,'nilo','Danilo Araujo','nilo@gmail.com',11965064590);
    
    
INSERT INTO Aluno VALUES     
    (default,'Elvis Schwarz','el@gmail.com', 11978063561,default),
    (default,'Paulo Narley','paulo@hotmail.com', 11950324564,default),
    (default,'Joade Assis','assis@yahoo.com.br', 11963204569,default),
    (default,'Nara Matos','nara@gmail.com', 11956574099,default),
    (default,'Marcos Dissotti','sotti@hotmail.com', 11976543312,default),
    (default,'Ana Carolina Mendes','carol@yahoo.com.br', 11934706539,default),
    (default,'Guilherme de Sousa','dsousa@hotmail.com', 11961433211,default),
    (default,'Bruno Torres','torres@yahoo.com.br', 11956546097,default),
    (default,'Yuji Homa','homa@hotmail.com', 11970453923,default),
    (default,'Raian Porto','porto@gmail.com', 11980325677,default);
    
INSERT INTO disciplina VALUES   
	(1, 'Comunicação e Expressão', 40, 7.50, 8.77,'comunicação expressão ementa', 'comunicação expressão competencias', 'comunicação expressão habilidades', 'comunicação expressão conteudo','comunicação expressão bibliografia_basica', 'comunicação expressão bibliografia_complementar'),
    (2, 'fundamentos de banco de dados', 40, 7.59, 8.70,'fundamentos de banco de dados ementa','fundamentos de banco de dados competencias', 'fundamentos de banco de dados habilidades', 'fundamentos de banco de dados conteudo','fundamentos de banco de dados bibliografia_basica','fundamentos de banco de dados bibliografia_complementar'),
	(3, 'Introdução a internet das coisas ', 40, 9.25, 6.00, 'Introdução a internet das coisas ementa', 'Introdução a internet das coisas competencias', 'Introdução a internet das coisas habilidades', 'Introdução a internet das coisas conteudo','Introdução a internet das coisas bibliografia_basica','Introdução a internet das coisas bibliografia_complementar'),
	(4, 'Linguagem de Programação 1', 40, 6.30, 8.00, 'Linguagem de Programação 1 ementa', 'Linguagem de Programação 1 competencias', 'Linguagem de Programação 1 habilidades', 'Linguagem de Programação 1 conteudo','Linguagem de Programação 1 bibliografia_basica','Linguagem de Programação 1 bibliografia_complementar'),
    (5,'Logica de programação', 40, 9.30, 9.45, 'Logica de programação ementa', 'Logica de programação competencias', 'Logica de programação habilidades', 'Logica de programação conteudo','Logica de programação bibliografia_basica','Logica de programação bibliografia_complementar'),
    (6,'Matematica Aplicada', 40, 8.30, 5.00, 'Matematica Aplicada ementa', 'Matematica Aplicada competencias', 'Matematica Aplicada habilidades', 'Matematica Aplicada conteudo','Matematica Aplicada bibliografia_basica','Matematica Aplicada bibliografia_complementar'),
	(7,'DevOps', 40, 8.40, 4.90, 'DevOps ementa', 'DevOps competencias', 'DevOps habilidades', 'DevOps conteudo','DevOps bibliografia_basica','DevOps bibliografia_complementar'),
    (8,'Engenharia de Software', 40, 5.90, 9.50, 'Engenharia de Software ementa', 'Engenharia de Software competencias', 'Engenharia de Software habilidades', 'Engenharia de Software conteudo','Engenharia de Software bibliografia_basica','Engenharia de Software bibliografia_complementar'),
    (9,'Gestão de Projetos', 40, 8.68, 3.90, 'Gestão de Projetos ementa', 'Gestão de Projetos competencias', 'Gestão de Projetos habilidades', 'Gestão de Projetos conteudo','Gestão de Projetos bibliografia_basica','Gestão de Projetos bibliografia_complementar'),
	(10,'Linguagem SQL', 40, 8.70, 2.90, 'Linguagem SQL ementa', 'Linguagem SQL competencias', 'Linguagem SQL habilidades', 'Linguagem SQL conteudo','Linguagem SQL bibliografia_basica','Linguagem SQL bibliografia_complementar'),
	(11,'TecWeb', 40, 6.94, 8.00, 'TecWeb ementa', 'TecWeb competencias', 'TecWeb habilidades', 'TecWeb conteudo','TecWeb bibliografia_basica','TecWeb bibliografia_complementar'),
	(12,'Computação Cognitiva', 40, 5.30, 9.00, 'Computação Cognitiva ementa', 'Computação Cognitiva competencias', 'Computação Cognitiva habilidades', 'Computação Cognitiva conteudo','Computação Cognitiva bibliografia_basica','Computação Cognitiva bibliografia_complementar'),
	(13,'Governacia de TI', 40, 6.30, 7.00, 'Governacia de TI ementa', 'Governacia de TI competencias', 'Governacia de TI habilidades', 'Governacia de TI conteudo','Governacia de TI bibliografia_basica','Governacia de TI bibliografia_complementar'),
	(14,'Estrutura de Dados', 40, 9.30, 7.88, 'Estrutura de Dados ementa', 'Estrutura de Dados competencias', 'Estrutura de Dados habilidades', 'Estrutura de Dados conteudo','Estrutura de Dados bibliografia_basica','Estrutura de Dados bibliografia_complementar'),
    (15,'Legislação e Ética', 40, 3.30, 6.88, 'Legislação e Ética ementa', 'Legislação e Ética competencias', 'Legislação e Ética habilidades', 'Legislação e Ética conteudo','Legislação e Ética bibliografia_basica','Legislação e Ética bibliografia_complementar'),
    (16,'BigData', 40, 6.30, 4.88, 'BigData ementa', 'BigData competencias', 'BigData habilidades', 'BigData conteudo','BigData bibliografia_basica','BigData bibliografia_complementar'),
    (17,'AdmBD', 40, 9.30, 6.22, 'AdmBD ementa', 'AdmBD competencias', 'AdmBD habilidades', 'AdmBD conteudo','AdmBD bibliografia_basica','AdmBD bibliografia_complementar'),
    (18,'Redes IPV6', 40, 8.45, 7.98, 'Redes IPV6 ementa', 'Redes IPV6 competencias', 'Redes IPV6 habilidades', 'Redes IPV6 conteudo','Redes IPV6 bibliografia_basica','Redes IPV6 bibliografia_complementar'),
    (19,'Comunicações Móveis', 40, 6.41, 6.58, 'Comunicações Móveis ementa', 'Comunicações Móveis competencias', 'Comunicações Móveis habilidades', 'Comunicações Móveis conteudo','Comunicações Móveis bibliografia_basica','Comunicações Móveis bibliografia_complementar'),
    (20,'Routing', 40, 9.30, 6.01, 'Routing ementa', 'Routing competencias', 'Routing habilidades', 'Routing conteudo','Routing bibliografia_basica','Routing bibliografia_complementar'),
	(21,'Auditoria em TI', 40, 6.30, 7.00, 'Auditoria em TI ementa', 'Auditoria em TI competencias', 'Auditoria em TI habilidades', 'Auditoria em TI conteudo','Auditoria em TI bibliografia_basica','Auditoria em TI bibliografia_complementar'),
	(22,'Computação em nuvens', 40, 9.30, 6.22, 'Computação em nuvens ementa', 'Computação em nuvens competencias', 'Computação em nuvens habilidades', 'Computação em nuvens conteudo','Computação em nuvens bibliografia_basica','Computação em nuvens bibliografia_complementar'),
	(23,'Design de App1', 40, 3.30, 6.88, 'Design de App1 ementa', 'Design de App1 competencias', 'Design de App1 habilidades', 'Design de App1 conteudo','Design de App1 bibliografia_basica','Design de App1 bibliografia_complementar'),
	(24,'Linguagem de Programação 2', 40, 6.30, 8.00, 'Linguagem de Programação 2 ementa', 'Linguagem de Programação 2 competencias', 'Linguagem de Programação 2 habilidades', 'Linguagem de Programação 2 conteudo','Linguagem de Programação 2 bibliografia_basica','Linguagem de Programação 2 bibliografia_complementar'),
	(25,'Design de App2', 40, 3.30, 6.88, 'Design de App2 ementa', 'Design de App2 competencias', 'Design de App2 habilidades', 'Design de App2 conteudo','Design de App2 bibliografia_basica','Design de App2 bibliografia_complementar');
 

INSERT INTO curso VALUES 
	(default,'Sistema de informação'),
	(default,'Analise e desenvolvimento de sistema'),
    (default,'Gestao de tecnologia da informação'),
    (default,'Banco de Dados'),
    (default,'Java Script');
    
INSERT INTO gradecurricular VALUES   
    (1,'2017',4),
	(2,'2017',4),
    (3,'2017',4),
    (4,'2017',4),
    (5,'2017',4);

INSERT INTO periodo VALUES   
    (1,'2017',4,1),
	(2,'2017',4,2),
    (3,'2017',4,3),
    (4,'2017',4,4),
    (5,'2017',4,5);

INSERT INTO periododisciplina VALUES   
    (1,'2017',4,1,1),
	(2,'2017',4,2,2),
    (3,'2017',4,3,3),
    (4,'2017',4,4,4),
    (5,'2017',4,5,5);

INSERT INTO disciplinaofertada VALUES   
    ('Comunicação e Expressão','2017',4),
	('Introdução a internet das coisas','2017',4),
    ('DevOps','2017',4),
    ('Linguagem SQL','2017',4),
    ('Estrutura de Dados','2017',4);
  
INSERT INTO Turma VALUES
	('Comunicação e Expressão','2017',4,1,'manha',default),
	('Introdução a internet das coisas','2017',4,2,'manha',default),
    ('DevOps','2017',4,3,'manha',default),
    ('Linguagem SQL','2017',4,4,'manha',default),
    ('Estrutura de Dados','2017',4,5,'manha',default);

INSERT INTO Matricula VALUES
	(1001,'Comunicação e Expressão',2017,4,1),
	(1002,'Introdução a internet das coisas',2017,4,2),
	(1003,'DevOps',2017,4,3),
	(1004,'Linguagem SQL',2017,4,4),
	(1005,'Estrutura de Dados',2017,4,5);

INSERT INTO CursoTurma VALUES
	(1,'Comunicação e Expressão',2017,4,1),
	(2,'Introdução a internet das coisas',2017,4,2),
	(3,'DevOps',2017,4,3),
	(4,'Linguagem SQL',2017,4,4),
	(5,'Estrutura de Dados',2017,4,5);
    
INSERT INTO Questao VALUES
	('Comunicação e Expressão',2017,4,1,10,20171125,'descrição questao',20171123),
	('Introdução a internet das coisas',2017,4,2,20,20171125,'descrição questao',20171123),
	('DevOps',2017,4,3,30,20171125,'descrição questao',20171123),
	('Linguagem SQL',2017,4,4,40,20171125,'descrição questao',20171123),
	('Estrutura de Dados',2017,4,5,50,20171125,'descrição questao',20171123);
    
    
INSERT INTO ArquivosQuestao VALUES
	('Comunicação e Expressão',2017,4,1,10,'arquivo questao'),
	('Introdução a internet das coisas',2017,4,2,20,'arquivo questao'),
	('DevOps',2017,4,3,30,'arquivo questao'),
	('Linguagem SQL',2017,4,4,40,'arquivo questao'),
	('Estrutura de Dados',2017,4,5,50,'arquivo questao');
    
INSERT INTO Resposta VALUES
	('Comunicação e Expressão',2017,4,1,10,1001,20171123,10.00,'avaliação','descrição', 20171124),
	('Introdução a internet das coisas',2017,4,2,20,1002,20171123,10.00,'avaliação','descrição', 20171124),
	('DevOps',2017,4,3,30,1003,20171123,10.00,'avaliação','descrição', 20171124),
	('Linguagem SQL',2017,4,4,40,1004,20171123,10.00,'avaliação','descrição', 20171124),
	('Estrutura de Dados',2017,4,5,50,1005,20171123,10.00,'avaliação','descrição', 20171124);
    
INSERT INTO ArquivosResposta VALUES
	('Comunicação e Expressão',2017,4,1,10,1001,'arquivo'),
	('Introdução a internet das coisas',2017,4,2,20,1002,'arquivo'),
	('DevOps',2017,4,3,30,1003,'arquivo'),
	('Linguagem SQL',2017,4,4,40,1004,'arquivo'),
	('Estrutura de Dados',2017,4,5,50,1005,'arquivo');