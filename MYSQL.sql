
/*REVISAR TRIGGER E CURSORES*/
/* Modelagem Basica */
	Cliente
	NOME - VARCHAR(30)
	CPF - INT(11)
	EMAIL - VARCHAR(30)
	TELEFONE - VARCHAR(30)
	ENDERECO - VARCHAR(100)
	SEXO - CHAR(1)
	/*Processos de modelagem*/
	Modelagem conceitual - rascunho
	/*fase 01 e fase 02 - ad adm de dados*/
	Modelagem logica - programa de modelagem 
	/* fase 03 - dba/ ad*/
	Modelagem fisica - script de banco
	
	
	create database nome do banco;  
	/*usando a tabela*/ 
	use nome do banco;
	/*creando tabela*/
	create table Cliente(
	NOME VARCHAR(30),
	SEXO CHAR(1),
	CPF INT (11),
	EMAIL VARCHAR(30),
	TELEFONE VARCHAR(30),
	ENDERECO VARCHAR(100)
	);
	/*ver as tabelas*/
	show tables;
	/*ver colunas da tabela*/
	desc nome da tabela;
	/*INSERINDO DADOS por campo*/
	INSERT INTO cliente(NOME,SEXO,CPF,EMAIL,TELEFONE,ENDERECO) VALUES('DAVI', 'M',123456789,'email@mail.com', '(31)99999-9999', 'Rua base');
	/*INSERINDO DADOS Ordem*/
	INSERT INTO cliente VALUES('test', 'M',123456789,'email@mail.com', '(31)99999-9999', 'Rua base');
	/*alias de coluna*/
	select now(); 
	select now() as data_hora, 'davi nicollas ' as 'Aluno';
	select nome , sexo, endereco , telefone , now() as data_hora from cliente;
	select nome as cliente , sexo, endereco , telefone,  now() as data_hora from cliente;
	/*selecionar tudo*/
	select  * from cliente;
	select * from cliente where SEXO = "M";
	
1 - TODO CAMPO VETORIZADO SE TORNAR  OUTRA TABELA
2 - TODO CAMPO MULTIVALORADO SE TORNAR OUTRA TABELA.
3 - TODA TABELA NECESSITA DE PELO MENOS UM CAMPO QUE IDENTIFIQUE
TODO O REGISTRO COMO SENDO UNICO.
ISSO ;E O QUE CHAMAMOS DE CHAVE PRIMARIA OU PRIMARY KEY.
	
CREATE DATABASE COMERCIO;
USE COMERCIO;
create table CLIENTE(
	IDCLIENTE BIGINT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR (30) NOT NULL,
	SEXO ENUM('M', 'F') NOT NULL,
	EMAIL VARCHAR(30) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);
CREATE TABLE TELEFONE(
	IDTELEFONE BIGINT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES','COM','CEL')  NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE BIGINT,
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);
CREATE TABLE ENDERECO(
	IDENDERECO BIGINT PRIMARY KEY AUTO_INCREMENT,
	BAIRRO VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	CIDADE VARCHAR(30)NOT NULL ,
	RUA VARCHAR (30) NOT NULL,
	ID_CLIENTE BIGINT UNIQUE,
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);
select * from cliente;
insert into cliente values(NULL,'DAVI' , 'M', 'DAVI@DAVI.COM', 123456);
insert into cliente values(NULL,'ELAINE' , 'F', 'ELAINE@ELAINE.COM', 323232);
insert into cliente values(NULL,'JOAO' , 'M', 'JOAO@JOAO.COM', 147852);
insert into cliente values(NULL,'SARAH' , 'F', 'SARAH@SARAH.COM', 987987);
insert into cliente values(NULL,'EDU' , 'M', 'EDU@EDU.COM', 654456);
insert into cliente values(NULL,'GI' , 'F', NULL, 852369);	
	+-----------+--------+------+-------------------+--------+
| IDCLIENTE | NOME   | SEXO | EMAIL             | CPF    |
+-----------+--------+------+-------------------+--------+
|         1 | DAVI   | M    | DAVI@DAVI.COM     | 123456 |
|         2 | ELAINE | F    | ELAINE@ELAINE.COM | 323232 |
|         3 | JOAO   | M    | JOAO@JOAO.COM     | 147852 |
|         4 | SARAH  | F    | SARAH@SARAH.COM   | 987987 |
|         5 | EDU    | M    | EDU@EDU.COM       | 654456 |
|         6 | GI     | F    | NULL              | 852369 |
+-----------+--------+------+-------------------+--------+
DELETE FROM ENDERECO WHERE IDENDERECO =1 ;
INSERT INTO ENDERECO VALUES (NULL,'VALE FORMOSO','MG', 'VESPASIANO' , 'RUA JOSE PAULO DE BARROS', 1);
INSERT INTO ENDERECO VALUES (NULL,'VALE LINDO','MG', 'VESPASIANO' , 'RUA 31', 5);
INSERT INTO ENDERECO VALUES (NULL,'CAIERAS','MG', 'VESPASIANO' , 'RUA 233', 6);
INSERT INTO ENDERECO VALUES (NULL,'SAMPA','SP', 'SAO PAULO' , 'RUA AJS', 3);
INSERT INTO ENDERECO VALUES (NULL,'CENTRO','MG', 'BELO HORIZONTE' , 'RUA JPB', 2);
INSERT INTO ENDERECO VALUES (NULL,'GAMELEIRA','MG', 'BELO HORIZONTE' , 'RTEIXEIRA', 4);

SELECT * FROM ENDERECO;
INSERT INTO ENDERECO VALUES (NULL,'GAMELEIRA','MG', 'BELO HORIZONTE' , 'RTEIXEIRA', 4);

DESC TELEFONE;
SELECT * FROM TELEFONE;
INSERT INTO TELEFONE VALUES(NULL,'RES','325698',6);
INSERT INTO TELEFONE VALUES(NULL,'CEL','325698',6);
INSERT INTO TELEFONE VALUES(NULL,'COM','325698',5);
INSERT INTO TELEFONE VALUES(NULL,'RES','125314',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','325698',4);
INSERT INTO TELEFONE VALUES(NULL,'COM','325698',4);
INSERT INTO TELEFONE VALUES(NULL,'RES','325698',3);
INSERT INTO TELEFONE VALUES(NULL,'CEL','325698',3);
INSERT INTO TELEFONE VALUES(NULL,'COM','325698',2);
INSERT INTO TELEFONE VALUES(NULL,'COM','325698',2);
INSERT INTO TELEFONE VALUES(NULL,'COM','325698',1);
INSERT INTO TELEFONE VALUES(NULL,'COM','325698',1);


/*Seleção, projeção e junção */
/* projeção -> È tudo que voce quer ver na tela */
/*Seleção -> */
/*junção -> */
/*INNER JOIN nome,sexo,bairro,cidade*/
/*
SELECT nome, sexo, bairro, cidade /*PROJEÇÃO*/
FROM cliente /*ORIGEM*/
INNER JOIN endereco /*JUNÇAO*/
ON idcliente = ID_CLIENTE 
WHERE sexo ='F';/*SELEÇÃO*/

/*erro de ambiguidade*/
SELECT nome, sexo,bairro, cidade, numero, tipo /*PROJEÇÃO*/
FROM cliente /*ORIGEM*/
INNER JOIN endereco /*JUNÇAO*/
ON idcliente = ID_CLIENTE 
inner join telefone ON cliiente = ID_CLIENTE 
WHERE sexo ='F';/*SELEÇÃO*/

/*possivel maneira*/
SELECT cliente.nome, cliente.sexo,endereco.bairro, endereco.cidade, telefone.numero, telefone.tipo /*PROJEÇÃO*/
FROM cliente /*ORIGEM*/
INNER JOIN endereco /*JUNÇAO*/
ON cliente.idcliente = endereco.ID_CLIENTE 
inner join telefone ON cliente.idcliente = telefone.ID_CLIENTE 
WHERE cliente.sexo ='F';/*SELEÇÃO*/

/*Segunda forma*/
SELECT c.nome, c.sexo,e.bairro, e.cidade, t.numero, t.tipo /*PROJEÇÃO*/
FROM cliente  c/*ORIGEM*/
INNER JOIN endereco  e /*JUNÇAO*/
ON c.idcliente = e.ID_CLIENTE 
inner join telefone t ON c.idcliente = t.ID_CLIENTE 
WHERE c.sexo ='F';/*SELEÇÃO*/

INSERT INTO CLIENTE VALUES(NULL,'JOAO','M',NULL,'JOAO@IG.COM','077317540');

/*Nome sexo bairro cidade tipo numero*/

SELECT c.nome, c.sexo,e.bairro, e.cidade, t.numero, t.tipo /*PROJEÇÃO*/
FROM cliente  c/*ORIGEM*/
INNER JOIN endereco  e /*JUNÇAO*/
ON c.idcliente = e.ID_CLIENTE 
inner join telefone t ON c.idcliente = t.ID_CLIENTE;

/*
	DML - DATA MANIPULATION LANGUAGE
	DDL - DATA DEFINITION LANGUAGE
	DCL - DATA CONTROL LANGUAGE
	TCL - TRANSACTION CONTROL LANGUAGE
*/	

insert into cliente values(null,'maria','m','maria@maria.com', '123456789');
update cliente set sexo = 'f' where idcliente ='8';
update cliente set sexo = 'f' where idcliente IN(seguencia de ids para fazer alterações);

delete from cliente where idcliente ='8';

/**/
create table produto (
	IDPRODUTO BIGINT PRIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10,2)NOT NULL
	);
/**/
show tables;
/*Alterando o nome da coluna*/
ALTER TABLE Nome_do_banco CHANGE COLUMN nome_da_coluna novo_nome_da_coluna "tipo";

/*Alterar informação do banco de dados*/
alter table TABELA CHANGE campo_desejado  novo_campo  tipo_do_novo_campo; 
/*Ex*/alter table produto CHANGE valor_unitario  valor       int(10) t not null; 

/*Alterar o tipo do campo da tabela*/
alter table TABELA MODIFY campo_desejado tipo_do_novo_campo;
/*Ex*/alter table produto MODIFY valor_unitario int(10) not null;

/*Adicionando coluna na tabela*/
alter table TABELA ADD campo_desejado tipo_do_novo_campo;
/*Ex*/alter table produto ADD peso FLOAT(10,2) not null;

/*Excluir uma coluna da tabela*/
alter table TABELA DROP column campo_desejado;
/*Ex*/alter table produto DROP column PESO;

/*Adicionando depois de uma coluna*/
alter table TABELA add column campo_desejado tipo_do_novo_campo
after campo_ja_existente;
alter table PRODUTO add column TAMANHO FLOAT (10,2) not null 
after NOME_PRODUTO;

/*Adicionando Antes de uma coluna*/
alter table PRODUTO add column TAMANHO FLOAT (10,2) not null 
first NOME_PRODUTO;

/*IFNULL*/
IFNULL(campo_desejado, 'Mensagem para mostrar') as Nome_desejado;
/*Views*/
CREATE VIEW Nome_desejado AS
CONSULTA DESEJADA
/*EX*/
CREATE VIEW RELATORIO AS 
SELECT  C.IDCLIENTE,
		C.EMAIL,
		E.ESTADO,
		E.BAIRRO, 
		T.NUMERO
FROM CLIENTE C INNER JOIN ENDERECO E ON C.IDCLIENTE = E.ID_CLIENTE 
INNER JOIN TELEFONE T ON C.IDCLIENTE = T.ID_CLIENTE;

/*ACESSAR A QUERY*/
SELECT * FROM RELATORIO;
/*Apagandp view*/
drop view NOME DA VIEW
/*
Não e possivel fazer insert ou deleter em uma view que tem inner join;
*/	

/*Apenas é possivel fazer insert e delete em views que nao possuem inner join*/
/*E possivel fazer select dentro da view para filtrar dados precisos*/

/*Ordenar varias colunas*/
select * from nome_da_tabela order by colunas1 , colunas2 ; 
/*Ascendente*/
select * from nome_da_tabela order by colunas1 asc; 
/*descedente */
select * from nome_da_tabela order by colunas1 desc; 
/*Delimiter*/
DELIMITER sua_preferencia;
DELIMITER $
/*STORADE PROCEDOURS*/
CREATE PROCEDURE NOME_EMPRESA()
BEGIN 
	SELECT 'UNIVERSIDADE DOS DADOS ' AS EMPRESA;
END
$
DELIMITER ;
/*CHAMANDO STORADE PROCEDOURS*/
CALL Nome_desejado;

/*EXCLUIR PROCEDOURS*/

DROP PROCEDURE NOME_DA_PROCEDURE;
EX
DROP PROCEDURE NOME_EMPRESA;


/*Testando procedures*/
create database tests;
use tests;
create table cursos(
	idCursos int PRIMARY key AUTO_INCREMENT,
	nome VARCHAR(30) not null,
	preco FLOAT(10,2) not null
);
Delimiter $

/*PROCEDURE DE CADASTRO DE DADOS*/
CREATE PROCEDURE cad_Curso(cad_nome VARCHAR(30),
						  cad_preco FLOAT(10,2))
	BEGIN
		insert into cursos values(null,cad_nome,cad_preco);
	end
$

CALL cad_Curso('BI', 300.02);
CALL cad_Curso('JAVA', 255.02);
CALL cad_Curso('C#', 265.02);

/*PROCEDURES DE SELEÇÃO DE CADASTRO*/
CREATE PROCEDURE sel_cursos()
	BEGIN
		select * from cursos;
	end
$
DELIMITER ;
call sel_cursos();

/*Criando tabela de vendedor*/

create table vendedor (
	idvendedor int PRIMARY key AUTO_INCREMENT,
	nome VARCHAR(30) not null,
	sexo ENUM('M','F') not null,
	janeiro float(10,2) not null,
	fevereiro float(10,2) not null,
	marco float(10,2) not null
);
show tables;

insert into vendedor values (null,'davi' ,'M' ,123.25, 255.22, 222.22);
insert into vendedor values (null,'elaine' ,'f' ,255.25, 200.22, 300.22);
insert into vendedor values (null,'joao' ,'m' ,300.25, 100.22, 400.22);
insert into vendedor values (null,'ygor' ,'m' ,288.25, 300.22, 1000.000);

insert into vendedor values(NULL,'nicollas' , 'M', 558569,223588,55863);
insert into vendedor values(NULL,'teixeira' , 'F', 889895,22586,99986);
insert into vendedor values(NULL,'paulo' , 'M',  558569,223588,55863);
insert into vendedor values(NULL,'SARAH' , 'F',  558569,223588,55863);
insert into vendedor values(NULL,'EDU' , 'M',  558569,223588,55863);
insert into vendedor values(NULL,'GI' , 'F', 558569,223588,55863);	

update vendedor set marco = '1000.000' where idvendedor ='4';
 
/*Max traz o maior valor da coluna*/
SELECT max(fevereiro) as maior_fev from vendedor;
/*min traz o menor valor da coluna*/
SELECT min(fevereiro) as menor_fev from vendedor;
/*avg  traaz media da coluna*/
SELECT avg(fevereiro) as avg_fev from vendedor;
/*varias função*/
SELECT max(janeiro) as maior_janeiro,
	   min(janeiro) as menor_janeiro,
	   avg(janeiro) as media_janeiro from vendedor;
/*Truncate para formata em determinada quantidade casa decimal*/
SELECT max(janeiro) as maior_janeiro,
	   min(janeiro) as menor_janeiro,
	   truncate(avg(janeiro),2) as media_janeiro 
	   from vendedor;
/*SUM funçao para somar coluna*/
select sum(nome_da_coluna) as Nome_desejado,
from tabela where condicao;
/*Usando sub query*/
select* from tabela where coluna = (select* from tabela where coluna = )
/*quem vendeu menos*/
SELECT nome, marco from vendedor where marco = (select min(marco) from vendedor);
/*quem vendeu mais*/
SELECT nome, marco from vendedor where marco = (select max(marco) from vendedor);
/*quem vendeu mais que a media de fevereiro*/
SELECT nome, fevereiro from vendedor where fevereiro > (select avg(fevereiro) from vendedor);
/*Aplicando varios dados na query*/
select nome, janeiro, fevereiro , marco ,(janeiro+fevereiro+marco)*.25 as "Desconto" ,
truncate((janeiro+fevereiro+marco)/3,2) as "media",
(janeiro+fevereiro+marco) as "total" 
from vendedor;
/*Inserindo chaves primarya*/
alter table nome da tabela ADD PRIMARY key (nome_da_coluna);	
/*Inserindo coluna*/
alter table nome da tabela ADD column nome_da_coluna tipo();	
/*alterando dadps da coluna*/
alter table nome da tabela MODIFY tipo();	
/*Renomeando a tabela*/
alter table nome da tabela rename novo_nome;	
/*foregein key*/
alter table nome da tabela ADD foreign key (Nome_do_campo) REFERENCES tabela_referencia(nome_da_coluna);


/**/
drop table endereco;
drop table telefone;
drop table cliente;


create table cliente(
	idcliente int ,
	nome varchar(30)
);
create table telefone(
	idtelefone int ,
	tipo varchar(2) not null,
	numero int(10) not null,
	id_cliente int
);
/**/

/*Ex: inserindo uma primary key*/
alter table nome_da_tabela add constraint nome_da_constante PRIMARY key (nome_da_coluna);
alter table cliente add constraint pk_cliente PRIMARY key (idcliente);
/*Ex: inserindo uma foreing key*/
alter table nome_da_tabela add constraint nome_foreign foreign key(campo_tabela)REFERENCES tabela_sera_usada(id_usado);
alter table telefone add constraint fk_cliente_telefone foreign key (id_cliente) REFERENCES cliente(idcliente);

show create table telefone;

use information_schema;
show databases;
desc table_constraints;

select constraint_schema as "banco",
	   table_name as "tabela",
	   constraint_name as "Nome da regra",
	   constraint_type as "tipo"
	   from table_constraints;

select constraint_schema as "banco",
		table_name as "tabela",
		constraint_name as "Nome da regra",
		constraint_type as "tipo"
		from table_constraints
		where constraint_schema = "Comercio";

use comercio;
alter table telefone drop foreign key pk_cliente_telefone;
alter table telefone add constraint fk_cliente_telefone foreign key(id_cliente)REFERENCES cliente(idcliente);

/*CRIANDO UMA TRIGRER*/
create trigrer nome_da_trigrer
	escolher antes ou depois (Before/after) fazer depois de qual função( insert/delete/update) on nome_da tabela
	for each row(para cada linha)
	BEGIN -> INICIO

			QUALQUER COMANDO SQL
	END -> FIM 

/*EXEMPLO DE UM TRIGGER*/
create database aula40;
USE aula40;
create table usuario(
	id int PRIMARY key AUTO_INCREMENT,
	nome varchar (30),
	login varchar(30),
	senha varchar(15)
	);
create table bkusuario(
	idbackup int PRIMARY key AUTO_INCREMENT,
	idusuario int,
	nome varchar(30),
	login varchar(30)
	);

/*criando uma trigrer*/
DELIMITER $
create trigger backup_user
before delete on usuario
for each row
BEGIN
		insert into bkusuario values
		(null, old.id,old.nome,old.login);
END 
$

INSERT INTO USUARIO VALUES(NULL, "DAVI NICOLLAS" , "DAVIGALO", "125369");
DELIMITER ;
DELETE  FROM USUARIO WHERE ID=1;



CREATE DATABASE LOJAAULA;
USE LOJAAULA;
CREATE TABLE PRODUTO(
IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR (30),
VALOR FLOAT(10,2)
);

CREATE DATABASE BACKUP;
USE BCUKPROJETO;
CREATE TABLE BKP_PRODUTO(
IDBCKP INT PRIMARY KEY AUTO_INCREMENT,
ID_PRODUTO INT,
NOME VARCHAR (30),
VALOR FLOAT(10,2)
);
INSERT INTO LOJAAULA.PRODUTO VALUES (NULL,'BALA TOOFEW',0.50);
INSERT INTO BACKUP.BKP_PRODUTO VALUES (NULL,1,'BALA',0.25);

DELIMITER $
USE LOJAAULA;
CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL,NEW.IDPRODUTO, NEW.NOME,NEW.VALOR);
END
$
DELIMITER ;
INSERT INTO PRODUTO VALUES (NULL,'LIVROSQL',90.50);
INSERT INTO PRODUTO VALUES (NULL,'LIVROBI',50.50);
INSERT INTO PRODUTO VALUES (NULL,'LIVVROC++',85.50);
INSERT INTO PRODUTO VALUES (NULL,'LIVROJAVA',100.50);


INSERT INTO PRODUTO VALUES (NULL,'LIVRO C#',100.00);
INSERT INTO PRODUTO VALUES (NULL,'LIVRO C#',100.00);INSERT INTO PRODUTO VALUES (NULL,'LIVRO C#',100.00);INSERT INTO PRODUTO VALUES (NULL,'LIVRO C#',100.00);

SELECT * FROM PRODUTO;
SELECT * FROM BACKUP.BKP_PRODUTO;

DELIMITER $
CREATE TRIGGER BACKUP_PRODUTO_DELETE
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL,OLD.IDPRODUTO, OLD.NOME,OLD.VALOR);
END
$

DELETE FROM PRODUTO WHERE IDPRODUTO = 2;
DROP TRIGGER BACKUP_PRODUTO;

ALTER TABLE  BACKUP.BKP_PRODUTO ADD EVENTO CHAR(1);

DROP TRIGGER BACKUP_PRODUTO_DELETE;
DELIMITER $
CREATE TRIGGER BACKUP_PRODUTO_DELETE
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL,OLD.IDPRODUTO, OLD.NOME,OLD.VALOR, "D");
END
$

DELETE FROM PRODUTO WHERE IDPRODUTO = 3;


DROP TRIGGER BACKUP_PRODUTO;
CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BKP_PRODUTO VALUES
	(NULL,NEW.IDPRODUTO, NEW.NOME,NEW.VALOR, "I");
END
$

INSERT INTO PRODUTO VALUES (NULL,'LIVROJAVA45',200.50);

DELIMITER ;
DROP DATABASE LOJAAULA;
DROP DATABASE BACKUP;


CREATE DATABASE LOJAAULA;
USE LOJAAULA;
CREATE TABLE PRODUTO(
IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR (30),
VALOR FLOAT(10,2)
);

CREATE DATABASE BACKUP;
USE BACKUP;
CREATE TABLE BCK_PRODUTO(
IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
IDPRODUTO INT,
NOME_PRODUTO VARCHAR (30),
USUARIO VARCHAR(30),
DATA DATETIME,
VALOR_ORIGINAL FLOAT(10,2),
VALOR_ALTERADO FLOAT(10,2),
EVENTO CHAR(1)
);

ALTER TABLE  PRODUTO ADD EVENTO CHAR(1);
ALTER TABLE  PRODUTO ADD USUARIO VARCHAR(30);
ALTER TABLE  PRODUTO ADD DATA DATETIME;
ALTER TABLE  PRODUTO ADD VALOR_ORIGINAL FLOAT(10,2) ;
ALTER TABLE  PRODUTO ADD VALOR_ALTERADO FLOAT(10,2) ;

alter table produto DROP column VALOR;


INSERT INTO LOJAAULA.PRODUTO VALUES (NULL,'LIVROSQL',90.50);
INSERT INTO LOJAAULA.PRODUTO VALUES (NULL,'LIVROBI',50.50);
INSERT INTO LOJAAULA.PRODUTO VALUES (NULL,'LIVVROC++',85.50);
INSERT INTO LOJAAULA.PRODUTO VALUES (NULL,'LIVROJAVA',100.50);

SELECT * FROM LOJAAULA.PRODUTO;
DELIMITER $
CREATE TRIGGER AUDIT_PROD
AFTER UPDATE ON PRODUTO 
FOR EACH ROW
BEGIN
	INSERT INTO BACKUP.BCK_PRODUTO VALUES( NULL, OLD.IDPRODUTO, OLD.NOME_PRODUTO,
	 CURRENT_USER(),NOW(),OLD.VALOR, NEW.VALOR ,"U");
END
$

USE LOJAAULA;

alter table produto DROP column NOME;
ALTER TABLE  PRODUTO ADD NOME_PRODUTO VARCHAR(30);

UPDATE LOJAAULA.PRODUTO SET VALOR = 110.00
WHERE IDPRODUTO = 1;

SELECT * FROM PRODUTO;

USE LOJAAULA

DROP TRIGGER AUDIT_PROD;


UPDATE LOJAAULA.PRODUTO SET VALOR = 185.00
WHERE IDPRODUTO = 4;

create database cursores;
	use cursores;
	create table vendedor(
		id int PRIMARY key AUTO_INCREMENT,
		nome VARCHAR(30),
		jan int,
		fev int,
		marc int
);

	insert into vendedor values(null, "davi",25,30,999);
	insert into vendedor values(null, "nicollas",30,40,987);
	insert into vendedor values(null, "paula",35,50,858);
	insert into vendedor values(null, "felipe",40,45,100);
	insert into vendedor values(null, "jose",50,55,0);

create table vend_tot(
		nome VARCHAR(30),
		jan int,
		fev int,
		marc int,
		total int,
		media int
);

delimiter $


create procedure inserirdados()
begin 
	DECLARE FIM INT DEFAULT 0;
	DECLARE VAR1, VAR2, VAR3 ,VTOTAL, VMEDIA INT;
	DECLARE VNOME VARCHAR (30);
	/*PADRAO*/DECLARE REG CURSOR FOR(
			  SELECT NOME, JAN, FEV, MARC FROM vendedor
			);
	/*PADRAO DECLARA AS VARIAVEIS*/DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM =1;
	/*PADRAO DECLARANDO OS VETORES*/OPEN REG;
	/*PADRAO INICIANDO O LAÇO DE REPETIÇÃO*/REPEAT 
		/*MUDA APENAS AS VARIAVEIS*/FETCH REG INTO VNOME, VAR1, VAR2, VAR3;
		/*PADRAO INICIA O IF*/IF NOT FIM THEN 
			/*ATRIBUINDO AS VARIAVEIS*/SET VTOTAL = VAR1+VAR2+VAR3;
			/*ATRIBUINDO AS VARIAVEIS*/SET VMEDIA = VTOTAL/3;
			/*iNSERINDO DADOS NAS COLUNAS*/INSERT INTO vend_tot VALUES(VNOME,VAR1,VAR2,VAR3,VTOTAL,VMEDIA);
		/*PADRAO FECHAMENTO DO IF*/END IF;	
	/*PADRAO FECHAMENTO DO REPEAT*/UNTIL FIM END REPEAT;
	/*PADRAO FECHAMENTO DO REG*/CLOSE REG;
end
$

SELECT * FROM VENDEDOR;
SELECT * FROM vend_tot;
DELIMITER ;

CALL inserirdados();
DROP PROCEDURE inserirdados;


SELECT NOME, (JAN+FEV+MARC) AS TOTAL FROM VENDEDOR;
SELECT NOME, (JAN+FEV+MARC)/3 AS MEDIA FROM VENDEDOR;


/*pRIMEIRA FN*/

ATOMACIDADE - UM CAMPO NAO PODE SER DIVISIVEL
UM CAMPO NAO PODE SER VETORIZADO
PK CHAVE PRIMARIA
/**/

/*SEGUNDA*/

CREATE DATABASE CONSULTORIO;
USE CONSULTORIO;

CREATE TABLE PACIENTE(
	IDPACIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	EMAIL VARCHAR(30),
	NASCIMENTO DATE
);

CREATE TABLE MEDICO(
	IDMEDICO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	ESPECIALIDADE VARCHAR(30),
	FUNCIONARIO ENUM('S','N')
);

CREATE TABLE HOSPITAL(
	IDHOSPITAL INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	BAIRRO VARCHAR(30),
	CIDADE VARCHAR(30),
	ESTADO CHAR(2)
);

CREATE TABLE CONSULTA(
	IDCONSULTA INT PRIMARY KEY AUTO_INCREMENT,
	ID_PACIENTE INT,
	ID_MEDICO INT,
	ID_HOSPITAL INT,
	DATA DATETIME,
	DIAGNOSTICO VARCHAR(50)
);

CREATE TABLE INTERNACAO(
	IDINTERNACAO INT PRIMARY KEY AUTO_INCREMENT,
	ENTRADA DATETIME,
	QUARTO INT,
	SAIDA DATETIME,
	OBSERVACOES VARCHAR(50),
	ID_CONSULTA INT UNIQUE	
);  
/*CONTRAINT COD DO OBJ(PK,FK)_TABELA PERTEMCENTE_TABELA REFERENCIA*/
/*---*/
alter table CONSULTA add constraint FK_PACIENTE foreign key(ID_PACIENTE)REFERENCES PACIENTE(IDPACIENTE);
/*---*/
alter table CONSULTA add constraint FK_MEDICO foreign key(ID_MEDICO)REFERENCES MEDICO(IDMEDICO);
/*---*/
alter table CONSULTA add constraint FK_HOSPITAL foreign key(ID_HOSPITAL)REFERENCES HOSPITAL(IDHOSPITAL);
/*---*/
alter table INTERNACAO add constraint FK_CONSULTA foreign key(ID_CONSULTA)REFERENCES CONSULTA(IDCONSULTA);