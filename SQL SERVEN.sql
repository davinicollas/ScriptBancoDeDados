/*No sql serven 2014 usase o go com delimentador, seja para quebrar o pacote e chegar em forma assincrona*/

1- criar arquivo para setores de mkt e rh
2- criar um arquivo geral
3- deixar o mdf apenas com o dicionario de dados
4- criar 2 grupo de arquivos(primari - mdf)
FILESTREAM SER PARA ADICIONAR DOC DENTRO DA TABELA


/*CONECTANDO A UM BANCO*/
USE EMPRESA;
GO
/*CRIAÇÃO DE TABELAS*/
CREATE TABLE ALUNO(
	/*ID*/
	IDALUNO INT PRIMARY KEY IDENTITY,
	NOME VARCHAR (30) NOT NULL,
	SEXO CHAR(1) NOT NULL,
	NASCIMENTO DATE NOT NULL,
	EMAIL VARCHAR(30) UNIQUE
)
GO

/*CONSTRAIN*/
ALTER TABLE ALUNO
ADD CONSTRAINT
CK_SEXO CHECK(SEXO IN('M','F'))
GO


/*1*1*/
CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY IDENTITY(100,10),
	BAIRRO VARCHAR (30),
	UF CHAR(2) NOT NULL,
	CHECK (UF IN('RJ','MG','SP')),
	ID_ALUNO INT UNIQUE
)GO

/*CRIANDO A AFK*/
ALTER TABLE ENDERECO
ADD CONSTRAINT
FK_ENDERECO_ALUNO FOREIGN KEY (ID_ALUNO) REFERENCES ALUNO (IDALUNO) 
GO

/*COMANDO DESCRIÇÃO*/

/*PROCEDUREES - JA CRIADAS E ARMAZENAS NO SISTEMA*/
SP_COLUMNS ALUNO
GO

SP_HELP ALUNO 
GO

/*INSERINDO DADOS*/
/*NO SQL NAO E NECESSARIO COLOCAR O NULL NO ID, ELE JA RECONHECE COMO NULO AUTOMATICAMENTE*/
INSERT INTO TB_ALUNO VALUES('DAVI','M','1996/04/02', 'DAVI@NICOLLAS.COM')
INSERT INTO TB_ALUNO VALUES('NICOLLAS','M','1996/04/02', 'DAVID@NICOLLAS.COM')
INSERT INTO TB_ALUNO VALUES('ELAINE','F','1963/05/01', 'ELAINE@TEIXEIRA.COM')
INSERT INTO TB_ALUNO VALUES('GI','F','1997/03/01','GGI@TOP.COM')
GO

/**/

INSERT INTO TB_ENDERECO VALUES('CAIERAS','MG',1)
INSERT INTO TB_ENDERECO VALUES('FLAMENGO','RJ',3)
INSERT INTO TB_ENDERECO VALUES('GUARULHOS','SP',4)
INSERT INTO TB_ENDERECO VALUES('SANTOS','SP',5)


/**/

CREATE TABLE TB_TELEFONE(
	IDTELEFONE INT PRIMARY KEY IDENTITY,
	TIPO VARCHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_ALUNO INT,
	CHECK(TIPO IN('RES','COM','CEL'))
)
GO

INSERT INTO TB_TELEFONE VALUES('CEL','7897897899',1)
INSERT INTO TB_TELEFONE VALUES('RES','7896541236',1)
INSERT INTO TB_TELEFONE VALUES('COM','8855223366',5)
INSERT INTO TB_TELEFONE VALUES('CEL','7897897899',5)
GO

/*PEGAR DATA ATUAL*/
SELECT GETDATE()
GO
/*CLASULA AMBIGUA INNER JOIN*/
SELECT A.NOME T.TIPO, T.NUMERO, E.BAIRRO,E.UF
FROM ALUNO A
INNER JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO
GO

/*USANDO IS NULL PARA MASCARA CAMPO NULO, E O LEFT PARA TRAZER TODOS OS ALUNOS MESMO QUE NAO TENHA TELEFONE*/
SELECT A.NOME,
ISNULL(T.TIPO, 'SEM') AS "TIPO", 
ISNULL(T.NUMERO, 'SEM')AS "TELEFONE",
E.BAIRRO,
E.UF
FROM TB_ALUNO A
LEFT JOIN TB_TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN TB_ENDERECO E
ON A.IDALUNO = E.ID_ALUNO
GO
/*DATAS*/

/*datediff calcula a diferença entre 2 datas
getdate traz dia e hora*/

select nome, datediff(year,NASCIMENTO, GETDATE()) from tb_aluno 
go

/*dataname*/

select nome, datename(year,NASCIMENTO) from tb_aluno 
go

/*ate parte separa a data*/
SELECT nome, datepart(month, nascimento) from aluno 
go

/*cast converte dados*/

select cast('1'as int) + cast('1'as int)
go

/*conversão e concatenação 
exercicio converte as data de nascimento*/
select nome,
cast(day(nascimento) as varchar) + '/'+
cast(month(nascimento) as varchar) + '/'+
cast(year(nascimento) as varchar)
as data_nascimento
from tb_aluno
go

/*charindex- retorna um inteiro
contagem default- inicia com em 01*/
select nome, charindex('a', nome, 2) as indice
from aluno
go


/*bulk insert - importação de arquivo*/

create table lancamento_contabil(
	conta int,
	valor int,
	deb_cred char(1)
)
go
/*bulk insert - importação de arquivo*/
bulk insert nome_tabel
from 'caminho do arquivo'
with(
	firstrow = onde ira começar a ler o arquivo,
	datafiletype = tipo de dados ,
	fieldterminator = onde termina cada linha,
	rowterminator = onde termina o arquivo,
)

/*LEMBRETE O CASO E QUE TEM QUE ESTAR NO SERVIDOR 
O ARQUIVO PARA FAZER O BULK*/
bulk insert tb_lancamento_contabil
from 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\contas.txt'
with(
	firstrow = 2,
	datafiletype = 'char' ,
	fieldterminator = '\t',
	rowterminator = '\n'
)
SELECT CONTA, VALOR FROM DEB_CRED
GO

select CONTA,valor,
charindex('C', DEB_CRED) as credor,
charindex('d', DEB_CRED) as devedor,
charindex('c', DEB_CRED)* 2-1 as multiplicador,
from tb_lancamento_contabil
go
/*correção*/
select conta, sum(valor * (charindex('c', DEB_CRED)* 2-1)) as saldo
from tb_lancamento_contabil 
group by conta
go

/*triggre*/

create table produto (
	idproduto int IDENTITY PRIMARY KEY,
	nome VARCHAR(50) not null,
	categoria varchar(30) not null,
	preco numeric (10,2)not null
)
go


create table historico (
	idoperacao int IDENTITY PRIMARY key,
	produto varchar(50) not null,
	categoria varchar(30)not null,
	precoantigo numeric(10,2)not null,
	preconovo numeric(10,2)not null,
	data datetime,
	usuario varchar(30),
	mensagem varchar(100)
)
	go

insert into produto values('livroc++', 'livros', 98.00)
insert into produto values('livrosql', 'livros', 50.00)
insert into produto values('licensa office', 'software', 30000.00)
insert into produto values('nootbook', 'computadores', 2000.00)
insert into produto values('livrooracle', 'livros', 150.00)
	go
/**triggre de dados - data manipulation language*/
create TRIGGER tr_atualizar_preco
on dbo.produto 
for update as
	/*declarando as variaveis*/
	declare @idproduto int
	declare @produto varchar(50)
	declare @categoria varchar(30)
	declare @preco numeric(10,2)
	declare @preconovo numeric(10,2)
	declare @data datetime
	declare @usuario varchar(30)
	declare @acao varchar(100)

	/*valores vindo de tabelas sao inserindo com o comand select*/
	/*atribuindo valor as variaveis usando select*/
	SELECT @idproduto = idproduto from inserted
	SELECT @produto = nome from inserted
	SELECT @categoria = categotria from inserted
	SELECT @preco = preco from deleted
	SELECT @preconovo = preco  from inserted
	
	/*valores vindos de funcoes ou valores literais devem ser
	atribuidos com o comando set*/
	/*atribuindo valor as variaveis usando set*/
	set @data = GETDATE()
	set @usuario = SUSER_NAME()
	set @acao = 'valor inserindo com sucesso'

	insert into historico (produto, categoria, precoantigo, preconovo, data, usuario,mensagem)
	values(@produto,@categoria,@preco,@preconovo,@data, @acao)
	
	print 'trigger executada com successo'
	go

drop TRIGGER tr_atualizar_preco
/*trigger para apenas uma coluna*/

create TRIGGER tr_atualizar_preco
on dbo.produto 
for update as
/*TERMO DO TLSLQ*/
if update(preco)
begin
	/*declarando as variaveis*/
	declare @idproduto int
	declare @produto varchar(50)
	declare @categoria varchar(30)
	declare @preco numeric(10,2)
	declare @preconovo numeric(10,2)
	declare @data datetime
	declare @usuario varchar(30)
	declare @acao varchar(100)

	/*valores vindo de tabelas sao inserindo com o comand select*/
	/*atribuindo valor as variaveis usando select*/
	SELECT @idproduto = idproduto from inserted
	SELECT @produto = nome from inserted
	SELECT @categoria = categotria from inserted
	SELECT @preco = preco from deleted
	SELECT @preconovo = preco  from inserted
	
	/*valores vindos de funcoes ou valores literais devem ser
	atribuidos com o comando set*/
	/*atribuindo valor as variaveis usando set*/
	set @data = GETDATE()
	set @usuario = SUSER_NAME()
	set @acao = 'valor inserindo com sucesso'

	insert into historico (produto, categoria, precoantigo, preconovo, data, usuario,mensagem)
	values(@produto,@categoria,@preco,@preconovo,@data, @acao)
	
	print 'trigger executada com successo'
end
GO

	/*update*/
update produto set preco = 200.00
where idproduto = 1
go

SELECT * FROM PRODUTO;
SELECT * FROM HISTORICO;


/* TRIGGER UPDATE */
CREATE TABLE TB_EMPREGADO(
	IDEMP INT PRIMARY KEY,
	NOME VARCHAR(30),
	SALARIO MONEY,
	IDGERENTE INT
)
GO

ALTER TABLE TB_EMPREGADO ADD CONSTRAINT FK_GERENTE
FOREIGN KEY(IDGERENTE) REFERENCES TB_EMPREGADO(IDEMP)
GO


INSERT INTO TB_EMPREGADO VALUES(1,'CLARA',5000.00,NULL)
INSERT INTO TB_EMPREGADO VALUES(2,'CELIA',4000.00,1)
INSERT INTO TB_EMPREGADO VALUES(3,'JOAO',4000.00,1)
GO

CREATE TABLE TB_HIST_SALARIO(
	IDEMPREGADO INT,
	ANTIGOSAL MONEY,
	NOVOSAL MONEY,
	DATA DATETIME
)
GO

CREATE TRIGGER TG_SALARIO
ON DBO.TB_EMPREGADO
FOR UPDATE AS
IF UPDATE(SALARIO)
BEGIN
	 INSERT INTO TB_HIST_SALARIO
	 (IDEMPREGADO,ANTIGOSAL,NOVOSAL,DATA)
	 SELECT D.IDEMP,D.SALARIO,I.SALARIO,GETDATE()
	 FROM DELETED D, inserted I
	 WHERE D.IDEMP = I.IDEMP
END
GO

UPDATE TB_EMPREGADO SET SALARIO = SALARIO * 1.1
GO

SELECT * FROM TB_EMPREGADO
GO

SELECT * FROM TB_HIST_SALARIO
GO

SELECT HS.ANTIGOSAL, HS.NOVOSAL, HS.DATA, T.NOME FROM TB_HIST_SALARIO AS HS
INNER JOIN  TB_EMPREGADO AS T 
ON HS.IDEMPREGADO = T.IDEMP
GO

/*CRIANDO UMA  TABELA PARA FAZER A ASSOCIAÇÃO*/
CREATE TABLE SALARIO_RANGE(
	MINSAL MONEY,
	MAXSAL MONEY
)
GO
INSERT INTO SALARIO_RANGE VALUES(3000.00,6000.00)
GO

/*cRIANDO UM TRIGGER  USANDO UM VALIDADOR
USANDO A CONDIÇÃO PARA VALIDAR INFORMAÇÃO*/

CREATE TRIGGER TG_RANGE 
ON DBO.TB_EMPREGADO
FOR INSERT, UPDATE
AS
	declare	
		@MINSAL MONEY,
		@MAXSAL MONEY,
		@ATUALSAL MONEY

		SELECT @MINSAL = MINSAL, @MAXSAL = MAXSAL FROM SALARIO_RANGE
		SELECT @ATUALSAL = I.SALARIO 
		FROM INSERTED I
		IF(@ATUALSAL< @MINSAL)
		begin
			RAISERROR('SALARIO MENOR QUE O PISO',16,1)
			ROLLBACK TRANSACTION 
		END
		IF(@ATUALSAL> @MAXSAL)
		begin
			RAISERROR('SALARIO MAIOR QUE O TETO',16,1)
			ROLLBACK TRANSACTION 
		end
	GO

	UPDATE TB_EMPREGADO SET SALARIO  = 9000.00
	WHERE IDEMP = 1
	GO

	/*MOSTRAR INFO DAS TRIGGERS*/]
	SP_HELPTEXT NOME DA TRIGGER 
	GO
	/*EX*/
	SP_HELPTEXT TG_RANGE
	GO

	/*Procedures*/

	create table tb_pessoa(
		idpessoa int primary key IDENTITY,
		nome varchar(30) not null,
		sexo char(1) not null check(sexo in('m','f') ),
		NASCIMENTO date not null
	)
	go

	create table telefone(
		idtelefone int primary key IDENTITY,
		tipo char(3) not null check(tipo in('cel','com','res'),
		numero numeric(10) not null,
		id_pessoa int
	)
	go

	ALTER TABLE tb_telefone ADD CONSTRAINT FK_PESSOA
	FOREIGN KEY(ID_PESSOA) REFERENCES tb_pessoa(idpessoa)
	on delete cascade
	GO

	insert into pessoa values('Davi', 'm','1196-04-02')
	insert into pessoa values('gi', 'f','2000-04-02')
	insert into pessoa values('jose','M','1998-04-25')
	GO

	insert into telefone values ('cel','36225747',1)
	insert into telefone values ('cel','36225747',1)
	insert into telefone values ('COM','36225747',2)
	insert into telefone values ('COM','36225747',2)
	insert into telefone values ('cel','36225747',3)
	insert into telefone values ('cel','36225747',3)
	GO

	/*CRIANDO PROCEDURES*/
	/*EX*/
	CREATE PROC SOMA
	AS
		SELECT 10 + 10 AS SOMA
	GO
	/*EXECUTANDO DA PROCEDURES*/
	EXEC SOMA
	GO

	/*PROCEDURES COM PARAMENTRO*/

	CREATE PROC CONTA @NUM1 INT , @NUM2 INT
	AS
		SELECT @NUM1 + @NUM2 AS SOMA
	GO

	DROP PROC CONTA;
	GO

	/*PROCEDURES EM TABELAS*/

	SELECT NOME , NUMERO
	FROM pessoa
	INNER JOIN TELEFONE
	ON IDPESSOA = ID_PESSOA
	WHERE TIPO ='CEL'
	GO

	/*tRAZER OS TELEFONES DE ACORDO COM O TIPO PASSADO*/

	CREATE PROC BUSCAR_TEL @TIPO CHAR(3)
	AS 
		SELECT NOME , NUMERO
		FROM pessoa
		INNER JOIN TELEFONE
		ON IDPESSOA = ID_PESSOA
		WHERE TIPO = @TIPO
	GO


	EXEC BUSCAR_TEL 'CEL'
	GO
	EXEC BUSCAR_TEL 'COM'
	GO
	EXEC BUSCAR_TEL 'RES'
	GO

	/*PARAMETROS OUTPUT*/
	SELECT TIPO , COUNT(*) AS QUANTIDADE
	FROM TELEFONE 
	GROUP BY TIPO
	GO
	
	/*CRIANDO PROC COM PARAMETROS DE ENTRADA E SAIDA*/
	
	CREATE PROC GET_TIPO @TIPO CHAR(3), @CONTADOR INT OUTPUT
	AS
		SELECT @CONTADOR = COUNT(*)
		FROM TELEFONE
		WHERE TIPO = @TIPO
	GO
	
	/*EXECUÇÃO DAA PROC COM PARAMETRO DE SAIDA*/

	DECLARE @SAIDA INT 
	EXEC GET_TIPO @TIPO = 'CEL', @CONTADOR = @SAIDA OUTPUT
	SELECT @SAIDA
	GO


	/*@@IDENTITY guarda o ultimo id inserido;*/



	create proc cadastro @nome varchar(30),@sexo char(1),@NASCIMENTO date,
		@tipo char(3), @numero varchar(30)
		as
			declare @FK int

			insert into tb_pessoa values(@nome, @sexo ,@NASCIMENTO) /*Cria o usuario ja com id*/


			set @FK = (select idpessoa from tb_pessoa where IDPESSOA = @@IDENTITY)


			insert into telefone values(@tipo, @numero , @fk)
		go

	exec cadastro 'davi nicollas de paula periceles', 'm','1996-04-02', 'cel', '78965412'
	go




	/*tsql e um bloco de linguagem de programação 
	programas sao unidades que podem ser chamadas de blocos anonimos.
	blocos anonimos nao recebem nome, pois não sao salvos no banco. Criamos blocos anonimos quando iremos executa-los
	uma so vez ou testar algo*/

	begin 
		print 'primeiro bloco'
	end 
	go
	/*Atribuição de variaveis*/
	declare
		@contato int
	begin
		set @contato = 5
		print @contato
	end
	go 
	/*no sql server cada coluna variavel local expressao e parametro tem um tipo*/
	declare 
		@vnum numeric(10,2) = 100.52,
		@vdata datetime = '20170207'
	begin
		/*Convertendo usando cast o numero em varchar*/
		print 'Valor numerico: '+ cast(@vnum as varchar)
		/*Convertendo usando convert numero em varchar*/
		print 'Valor numerico: '+ convert(varchar , @vnum)
		/*Formato de data  7 2017 12:00AM*/
		print 'valor data' + cast(@vdata as VARCHAR)
		/*valor data 2017-02-07 00:00:00.000*/
		print 'valor data' + convert(varchar, @vdata ,121)
		/*valor data 2017-02-07 00:00:00*/
		print 'valor data' + convert(varchar, @vdata,120)
		/*valor data 07-02-2017*/
		print 'valor data' + convert(varchar, @vdata,105)
	end
	go

	/*Atribuindo resultados a variaveis*/

	create table carros(
		carro varchar(20),
		fabricante VARCHAR(30)
	)
	go


	insert into carros values ('ka', 'ford')
	insert into carros values ('fiesta', 'ford')
	insert into carros values ('prisma', 'ford')
	insert into carros values ('clio', 'renault')
	insert into carros values ('sandero', 'renault')
	insert into carros values ('chevete', 'chevrolet')
	insert into carros values ('omega', 'chevrolet')
	insert into carros values ('palio', 'fiat')
	insert into carros values ('doblo', 'fiat')
	insert into carros values ('uno', 'fiat')
	insert into carros values ('gol', 'volkswagen')
	go	

	/*TSQL Atribuindo resultados a variaveis*/
	declare 
		@V_CONT_FORD INT,
		@V_CONT_FIAT INT
	BEGIN
	  	--METODO 1-- O SELECT PRECISA RETORNA UMA SIMPLES COLUNA E COM UM RESULTADO

	  	SET @V_CONT_FORD = (SELECT COUNT(*) FROM CARROS 
		WHERE fabricante ='FORD')
	  	PRINT 'QUANTIDADE FORD:' + CAST(@V_CONT_FORD AS VARCHAR)

	  	--METODO 2

	  	SELECT @V_CONT_FIAT = COUNT(*) FROM CARROS WHERE fabricante = 'FIAT'
  		PRINT 'QUANTIDADE FIAT:' + CONVERT(VARCHAR, V_CONT_FIAT)
	END
	GO

	/*USANDO IF E ELSE*/
	DECLARE 
		@NUMERO INT = 5
	BEGIN
		IF @NUMERO = 5
			PRINT 'VALOR E VERDADEIRO'
		ELSE
			PRINT 'VALOR E FALSO'

	END

	/*USANDO CASE*/

	DECLARE 
		@CONTADOR INT
	BEGIN
		SELECT 
		CASE /*REPRESENTA UMA COLUNA*/
			WHEN FABRICANTE ='FIAT' THEN 'FAIXA1'
			WHEN FABRICANTE = 'CHEVROLE' THEN 'FAIXA2'
			ELSE 'OUTRAS FAIXAS'
			END AS "INFORMAÇÃO"
		*
		FOM CARROS
	END

	/*TRANFORMANDO EM BLOCO */
 
	CREATE PROC VERIFICARVALOR  @NUMERO INT
	AS
		IF @NUMERO = 5
			PRINT 'VALOR E VERDADEIRO'
		ELSE
			PRINT 'VALOR E FALSO'
	GO

	/*LOOPS WHILE*/

	DECLARE 
		@I INT = 1
	BEGIN
		WHILE (@I<15)
		BEGIN
			PRINT 'O VALOR E @I =' +CAST(@I AS VARCHAR)
			SET @I = @I+1 /*OU SET @I++*/
		END
	END
	GO