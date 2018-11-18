
DROP DATABASE IF EXISTS TESTE;

CREATE DATABASE IF NOT EXISTS TESTE; 

USE TESTE;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

 

CREATE TABLE IF NOT EXISTS `Conta` (

  `idConta` INT NOT NULL auto_increment,

  `Nome` VARCHAR(45) NULL,

  `Usuario` VARCHAR(45) NULL,

  `Senha` VARCHAR(45) NULL,

  `Email` VARCHAR(45) NULL,

  `Nivel` INT NULL,

  `Ativo` VARCHAR(45) BINARY NULL,

  `Cpf` VARCHAR(45) NULL,

  `Genero` VARCHAR(45) NULL,

  `Nascimento` VARCHAR(45) NULL,

  `DataCriacao` VARCHAR(45) NULL,

  PRIMARY KEY (`idConta`))

ENGINE = InnoDB

COMMENT = '';

 

-- insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Joao','Joao123','0000','joao@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

 

 

CREATE TABLE IF NOT EXISTS `Perfil_Funcionario` (

  `idPerfil_Funcionario` INT(11) NOT NULL auto_increment,

  `Setor_idSetor` INT(11) NOT NULL,

  `Conta_idConta` INT(11) NOT NULL,

  `Função_idFunção` INT(11) NOT NULL,

  PRIMARY KEY (`idPerfil_Funcionario`),

  INDEX `fk_Perfil_Funcionario_Conta1_idx` (`Conta_idConta` ASC),

  INDEX `fk_Perfil_Funcionario_Função1_idx` (`Função_idFunção` ASC),

  CONSTRAINT `fk_Perfil_Funcionario_Conta1`

    FOREIGN KEY (`Conta_idConta`)

    REFERENCES `Conta` (`idConta`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_Perfil_Funcionario_Função1`

    FOREIGN KEY (`Função_idFunção`)

    REFERENCES `Função` (`idFunção`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

 -- insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (1,2,3);

 

CREATE TABLE IF NOT EXISTS `Setor` (

  `idSetor` INT(11) NOT NULL auto_increment,

  `Nome_Setor` VARCHAR(45) NULL DEFAULT NULL,

  `Coordenador_id` INT(11) NOT NULL,

  `Departamento_idDepartamento` INT(11) NOT NULL,

  PRIMARY KEY (`idSetor`),

  INDEX `fk_Setor_Perfil_Funcionario1_idx` (`Coordenador_id` ASC),

  INDEX `fk_Setor_Departamento1_idx` (`Departamento_idDepartamento` ASC),

  CONSTRAINT `fk_Setor_Perfil_Funcionario1`

    FOREIGN KEY (`Coordenador_id`)

    REFERENCES `Perfil_Funcionario` (`idPerfil_Funcionario`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_Setor_Departamento1`

    FOREIGN KEY (`Departamento_idDepartamento`)

    REFERENCES `Departamento` (`idDepartamento`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COMMENT = '';

 

-- insert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('Contabilidade',1,3); 

 

CREATE TABLE IF NOT EXISTS `Função` (

  `idFunção` INT(11) NOT NULL auto_increment,

  `Nome_Função` VARCHAR(45) NULL DEFAULT NULL,

  `Setor_idSetor` INT(11) NOT NULL,

  PRIMARY KEY (`idFunção`),

  INDEX `fk_Função_Setor1_idx` (`Setor_idSetor` ASC),

  CONSTRAINT `fk_Função_Setor1`

    FOREIGN KEY (`Setor_idSetor`)

    REFERENCES `Setor` (`idSetor`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

-- insert into Função(Nome_Função,Setor_idSetor) values ('Analista Contabil',1); 

 

CREATE TABLE IF NOT EXISTS `Perfil_Cliente` (

  `idPerfil_Cliente` INT(11) NOT NULL auto_increment,

  `Numero_Cartão` VARCHAR(45) NULL DEFAULT NULL,

  `Conta_idConta` INT(11) NOT NULL,

  `Telefone` VARCHAR(11) NULL DEFAULT NULL,

  `CEP` VARCHAR(9) NULL DEFAULT NULL,

  `Endereco` VARCHAR(255) NULL DEFAULT NULL,

  PRIMARY KEY (`idPerfil_Cliente`),

  INDEX `fk_Perfil_Cliente_Conta1_idx` (`Conta_idConta` ASC),

  CONSTRAINT `fk_Perfil_Cliente_Conta1`

    FOREIGN KEY (`Conta_idConta`)

    REFERENCES `Conta` (`idConta`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

-- insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values  ( '423412312', 1, '376576767', '08280660', 'rua do joao');

 

CREATE TABLE IF NOT EXISTS `Perfil_Vendedor` (

  `idPerfil_Vendedor` INT(11) NOT NULL auto_increment,

  `CNPJ` VARCHAR(45) NULL DEFAULT NULL,

  `Conta_idConta` INT(11) NOT NULL,

  PRIMARY KEY (`idPerfil_Vendedor`),

  INDEX `fk_Perfil_Vendedor_Conta1_idx` (`Conta_idConta` ASC),

  CONSTRAINT `fk_Perfil_Vendedor_Conta1`

    FOREIGN KEY (`Conta_idConta`)

    REFERENCES `Conta` (`idConta`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

 -- insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',4);

 

CREATE TABLE IF NOT EXISTS `Produto` (

  `idProduto` INT(11) NOT NULL auto_increment,

  `Perfil_Vendedor_idPerfil_Vendedor` INT(11) NOT NULL,

  `Categoria_Produto_idProduto` INT(11) NOT NULL,

  `Preço` INT(11) NULL DEFAULT NULL,

  `Descrição` VARCHAR(45) NULL DEFAULT NULL,

  `Estoque` INT(11) NULL DEFAULT NULL,

  PRIMARY KEY (`idProduto`),

  INDEX `fk_Anuncio_Perfil_Vendedor1_idx` (`Perfil_Vendedor_idPerfil_Vendedor` ASC),

  INDEX `fk_Anuncio_Produto1_idx` (`Categoria_Produto_idProduto` ASC),

  CONSTRAINT `fk_Anuncio_Perfil_Vendedor1`

    FOREIGN KEY (`Perfil_Vendedor_idPerfil_Vendedor`)

    REFERENCES `Perfil_Vendedor` (`idPerfil_Vendedor`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_Anuncio_Produto1`

    FOREIGN KEY (`Categoria_Produto_idProduto`)

    REFERENCES `Categoria_Produto` (`idCategoria_Produto`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

-- insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (5,1,15.00,'descrição x',20);

 

CREATE TABLE IF NOT EXISTS `Compra` (

  `idCompra` INT NOT NULL AUTO_INCREMENT,

  `Perfil_Cliente_idPerfil_Cliente` INT NOT NULL,

  `Data_compra` datetime not null,

  PRIMARY KEY (`idCompra`),

  INDEX `fk_Compra_Perfil_Cliente1_idx` (`Perfil_Cliente_idPerfil_Cliente` ASC),

  CONSTRAINT `fk_Compra_Perfil_Cliente1`

    FOREIGN KEY (`Perfil_Cliente_idPerfil_Cliente`)

    REFERENCES `teste`.`Perfil_Cliente` (`idPerfil_Cliente`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;

 

-- insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra) values (1,current_date());

 

CREATE TABLE IF NOT EXISTS `Compra_has_Produto` (

  `Quantidade` INT NOT NULL,

  `valor_total` DOUBLE NOT NULL,

  `Produto_idProduto` INT NOT NULL,

  `Cliente_idPerfil_Cliente` INT NOT NULL,

  `Compra_idCompra` INT NOT NULL,

  INDEX `fk_Compra_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) ,

  INDEX `fk_Compra_has_Produto_Compra1_idx` (`Compra_idCompra` ASC) ,

  CONSTRAINT `fk_Compra_has_Produto_Produto1`

    FOREIGN KEY (`Produto_idProduto`)

    REFERENCES `teste`.`Produto` (`idProduto`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_Compra_has_Produto_Compra1`

    FOREIGN KEY (`Compra_idCompra`)

    REFERENCES `teste`.`Compra` (`idCompra`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;

 

-- insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(5,250,1,2,1);

 

CREATE TABLE IF NOT EXISTS `Categoria_Produto` (

  `idCategoria_Produto` INT(11) NOT NULL auto_increment,

  `Nome_categoria` VARCHAR(45) NULL DEFAULT NULL,

  `Categoria_Descrição` VARCHAR(45) NULL DEFAULT NULL,

  PRIMARY KEY (`idCategoria_Produto`))

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

-- insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('VideoGames','Descrição videogames');

 

CREATE TABLE IF NOT EXISTS `Departamento` (

  `idDepartamento` INT(11) NOT NULL auto_increment,

  `Nome_Departamento` VARCHAR(45) NULL DEFAULT NULL,

  `Gestor_id` INT(11) NOT NULL,

  PRIMARY KEY (`idDepartamento`),

  INDEX `fk_Departamento_Perfil_Funcionario1_idx` (`Gestor_id` ASC),

  CONSTRAINT `fk_Departamento_Perfil_Funcionario1`

    FOREIGN KEY (`Gestor_id`)

    REFERENCES `teste`.`Perfil_Funcionario` (`idPerfil_Funcionario`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

-- insert into departamento(Nome_Departamento,Gestor_id) values ('Financeiro', 10);

 

CREATE TABLE IF NOT EXISTS `Conta_pagar` (

  `idConta_pagar` INT(11) NOT NULL auto_increment,

  `formaPagamento` INT(11) NULL DEFAULT NULL,

  `parcelas` INT(11) NULL DEFAULT NULL,

  `cartao` VARCHAR(45) NULL DEFAULT NULL,

  `recebimento_aprovado` TINYINT(4) NULL DEFAULT NULL,

  `Compra_idCompra` INT(11) NOT NULL,

  PRIMARY KEY (`idConta_pagar`),

  INDEX `fk_Conta_pagar_Compra_has_Produto1_idx` (`Compra_idCompra` ASC),

  CONSTRAINT `fk_Conta_pagar_Compra_has_Produto1`

    FOREIGN KEY (`Compra_idCompra`)

    REFERENCES `teste`.`Compra_has_Produto` (`Compra_idCompra`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

-- insert into Conta_pagar(formaPagamento,parcelas,cartao,recebimento_aprovado,Compra_idCompra) values(100,5,'1b34ac',1,2);

 

CREATE TABLE IF NOT EXISTS `Entrega` (

  `idEntrega` INT(11) NOT NULL auto_increment,

  `dataEntrega` DATE NULL DEFAULT NULL,

  `frete` DOUBLE NULL DEFAULT NULL,

  `local` VARCHAR(255) NULL DEFAULT NULL,

  `sucessoEntrega` TINYINT(4) NULL DEFAULT NULL,

  `Compra_idCompra` INT(11) NOT NULL,

  PRIMARY KEY (`idEntrega`),

  INDEX `fk_Entrega_Compra_has_Produto1_idx` (`Compra_idCompra` ASC),

  CONSTRAINT `fk_Entrega_Compra_has_Produto1`

    FOREIGN KEY (`Compra_idCompra`)

    REFERENCES `teste`.`Compra_has_Produto` (`Compra_idCompra`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8;

 

-- insert into Entrega(dataEntrega,frete,`local`,sucessoEntrega,Compra_idCompra) values (curdate(),100,'RUA X',0,5) ;

 

SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

 

 

-- inserts 

 

-- Conta

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Joao','Joao123','0000','joao@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Pedro','Pedro123','0000','pedro@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('marcos','marcos123','0000','marcos@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Jorge','jorge123','0000','jorge@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('pedroca','pedroca123','0000','pedroca@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('lucas','lucas123','0000','lucas@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('mat','mat123','0000','mat@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('luqinhas','luqinhas123','0000','luquinhas@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('matheus','matheus123','0000','matheus@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('pedrao','pedrao123','0000','pedrao@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

 

-- perfil_Funcionario

insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (1,2,1);

insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (2,3,4);

insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (3,4,5);

-- setor

insert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('Contabilidade',1,1); 

insert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('RH de IT',1,2); 

insert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('Redes',1,3); 

 

-- funçao

 

insert into Função(Nome_Função,Setor_idSetor) values ('Analista Contabil',1); 

insert into Função(Nome_Função,Setor_idSetor) values ('Analista Financeiro',1); 

insert into Função(Nome_Função,Setor_idSetor) values ('Agente de RH',2); 

insert into Função(Nome_Função,Setor_idSetor) values ('DBA',3); 

insert into Função(Nome_Função,Setor_idSetor) values ('Tec. Informatica',3); 

 

 

 

-- perfil_cliente

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 1, '376576767', '08280660', 'rua do joao');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 2, '12312312', '08280667', 'rua do pedro');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 3, '12212312', '08280667', 'rua do marcos');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 4, '12112312', '08280667', 'rua do jorge');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 5, '123412312', '08280667', 'rua do pedroca');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 6, '12342312', '08280667', 'rua do lucas');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 7, '122342312', '08280667', 'rua do mat');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 8, '2312312', '08280667', 'rua do luquinhas');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 9, '2312312', '08280667', 'rua do matheus');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 10, '12312312', '08280667', 'rua do pedrao');

 

 

-- Perfil_Vendedor

 

insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',5);

insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',6);

insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',7);

 

-- Produto

 

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (5,1,15.00,'descrição x',20);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (5,2,300.00,'descrição y',2);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (6,3,25000.00,'descrição z',1);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (7,4,1500.00,'descrição a',150);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (7,5,10.00,'descrição b',3);

 

-- Compra 

 

 insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra) values (1,current_date());

 insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra) values (3,current_date());

 

-- Compra_has_produto

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(5,250,1,1,1);

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(2,250,3,1,1);

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,5,1,1);

 

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,2,3,2);

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,3,3,2);

 

-- Categoria Produto

 

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('VideoGames','Descrição videogames');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Livros','Descrição livros');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Carros','Descrição carros');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Computadores','Descrição computadores');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Outros','Descrição outros');

 

-- Departamento 

 

insert into departamento(Nome_Departamento,Gestor_id) values ('Financeiro', 10);

insert into departamento(Nome_Departamento,Gestor_id) values ('RH', 10);

insert into departamento(Nome_Departamento,Gestor_id) values ('IT', 10);

 

 

-- Conta pagar

 

insert into Conta_pagar(formaPagamento,parcelas,cartao,recebimento_aprovado,Compra_idCompra) values(100,5,'1b34ac',1,1);

 

-- Entrega 

 

insert into Entrega(dataEntrega,frete,`local`,sucessoEntrega,Compra_idCompra) values (curdate(),100,'RUA X',0,1) ;

 

-- drop database TESTE;

 

-- Listando quantidade de compras(compras e não quantidade comprada) por produto

select c.produto_idproduto as 'ID DO PRODUTO', p.descrição as 'NOME PRODUTO', COUNT(c.produto_idproduto) as 'COMPRAS' from compra_has_produto c INNER JOIN produto p 

WHERE c.produto_idProduto = p.idproduto   group by c.produto_idproduto, p.descrição;

 

-- produto mais vendido de cada vendedor

select co.nome, MAX(c.produto_idproduto) as 'ID DO PRODUTO', p.descrição as 'NOME PRODUTO', COUNT(c.produto_idproduto) as 'COMPRAS' from produto p, compra_has_produto c, conta co, perfil_vendedor pe

WHERE c.produto_idproduto = p.idproduto AND co.idconta = pe.conta_idconta AND p.perfil_vendedor_idperfil_vendedor = pe.conta_idconta 

group by c.produto_idproduto, p.descrição, co.nome;

 

-- mostrar subtotal de cada item de uma compra

select c.compra_idcompra as 'ID DA COMPRA', c.quantidade * p.preço as 'subtotal de cada item da compra' from compra_has_produto c INNER JOIN produto p INNER JOIN compra co 

WHERE p.idproduto = c.produto_idproduto AND c.compra_idcompra = co.idcompra;

 

-- total vendido pela empresa

select sum(c.quantidade * p.preço) as 'total vendido pela empresa' from compra_has_produto c INNER JOIN produto p

WHERE p.idproduto = c.produto_idproduto;

 

-- select * from compra_has_produto;

-- select * from compra;

-- select * from produto;

-- select * from perfil_vendedor;

-- select * from conta;

DROP DATABASE IF EXISTS TESTE;CREATE DATABASE IF NOT EXISTS TESTE; USE TESTE;SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE TABLE IF NOT EXISTS `Conta` (  `idConta` INT NOT NULL auto_increment,  `Nome` VARCHAR(45) NULL,  `Usuario` VARCHAR(45) NULL,  `Senha` VARCHAR(45) NULL,  `Email` VARCHAR(45) NULL,  `Nivel` INT NULL,  `Ativo` VARCHAR(45) BINARY NULL,  `Cpf` VARCHAR(45) NULL,  `Genero` VARCHAR(45) NULL,  `Nascimento` VARCHAR(45) NULL,  `DataCriacao` VARCHAR(45) NULL,  PRIMARY KEY (`idConta`))ENGINE = InnoDBCOMMENT = '';
-- insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Joao','Joao123','0000','joao@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

CREATE TABLE IF NOT EXISTS `Perfil_Funcionario` (  `idPerfil_Funcionario` INT(11) NOT NULL auto_increment,  `Setor_idSetor` INT(11) NOT NULL,  `Conta_idConta` INT(11) NOT NULL,  `Função_idFunção` INT(11) NOT NULL,  PRIMARY KEY (`idPerfil_Funcionario`),  INDEX `fk_Perfil_Funcionario_Conta1_idx` (`Conta_idConta` ASC),  INDEX `fk_Perfil_Funcionario_Função1_idx` (`Função_idFunção` ASC),  CONSTRAINT `fk_Perfil_Funcionario_Conta1`    FOREIGN KEY (`Conta_idConta`)    REFERENCES `Conta` (`idConta`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,  CONSTRAINT `fk_Perfil_Funcionario_Função1`    FOREIGN KEY (`Função_idFunção`)    REFERENCES `Função` (`idFunção`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
 -- insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (1,2,3);
CREATE TABLE IF NOT EXISTS `Setor` (  `idSetor` INT(11) NOT NULL auto_increment,  `Nome_Setor` VARCHAR(45) NULL DEFAULT NULL,  `Coordenador_id` INT(11) NOT NULL,  `Departamento_idDepartamento` INT(11) NOT NULL,  PRIMARY KEY (`idSetor`),  INDEX `fk_Setor_Perfil_Funcionario1_idx` (`Coordenador_id` ASC),  INDEX `fk_Setor_Departamento1_idx` (`Departamento_idDepartamento` ASC),  CONSTRAINT `fk_Setor_Perfil_Funcionario1`    FOREIGN KEY (`Coordenador_id`)    REFERENCES `Perfil_Funcionario` (`idPerfil_Funcionario`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,  CONSTRAINT `fk_Setor_Departamento1`    FOREIGN KEY (`Departamento_idDepartamento`)    REFERENCES `Departamento` (`idDepartamento`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8COMMENT = '';
-- insert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('Contabilidade',1,3); 
CREATE TABLE IF NOT EXISTS `Função` (  `idFunção` INT(11) NOT NULL auto_increment,  `Nome_Função` VARCHAR(45) NULL DEFAULT NULL,  `Setor_idSetor` INT(11) NOT NULL,  PRIMARY KEY (`idFunção`),  INDEX `fk_Função_Setor1_idx` (`Setor_idSetor` ASC),  CONSTRAINT `fk_Função_Setor1`    FOREIGN KEY (`Setor_idSetor`)    REFERENCES `Setor` (`idSetor`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
-- insert into Função(Nome_Função,Setor_idSetor) values ('Analista Contabil',1); 
CREATE TABLE IF NOT EXISTS `Perfil_Cliente` (  `idPerfil_Cliente` INT(11) NOT NULL auto_increment,  `Numero_Cartão` VARCHAR(45) NULL DEFAULT NULL,  `Conta_idConta` INT(11) NOT NULL,  `Telefone` VARCHAR(11) NULL DEFAULT NULL,  `CEP` VARCHAR(9) NULL DEFAULT NULL,  `Endereco` VARCHAR(255) NULL DEFAULT NULL,  PRIMARY KEY (`idPerfil_Cliente`),  INDEX `fk_Perfil_Cliente_Conta1_idx` (`Conta_idConta` ASC),  CONSTRAINT `fk_Perfil_Cliente_Conta1`    FOREIGN KEY (`Conta_idConta`)    REFERENCES `Conta` (`idConta`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
-- insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values  ( '423412312', 1, '376576767', '08280660', 'rua do joao');
CREATE TABLE IF NOT EXISTS `Perfil_Vendedor` (  `idPerfil_Vendedor` INT(11) NOT NULL auto_increment,  `CNPJ` VARCHAR(45) NULL DEFAULT NULL,  `Conta_idConta` INT(11) NOT NULL,  PRIMARY KEY (`idPerfil_Vendedor`),  INDEX `fk_Perfil_Vendedor_Conta1_idx` (`Conta_idConta` ASC),  CONSTRAINT `fk_Perfil_Vendedor_Conta1`    FOREIGN KEY (`Conta_idConta`)    REFERENCES `Conta` (`idConta`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
 -- insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',4);
CREATE TABLE IF NOT EXISTS `Produto` (  `idProduto` INT(11) NOT NULL auto_increment,  `Perfil_Vendedor_idPerfil_Vendedor` INT(11) NOT NULL,  `Categoria_Produto_idProduto` INT(11) NOT NULL,  `Preço` INT(11) NULL DEFAULT NULL,  `Descrição` VARCHAR(45) NULL DEFAULT NULL,  `Estoque` INT(11) NULL DEFAULT NULL,  PRIMARY KEY (`idProduto`),  INDEX `fk_Anuncio_Perfil_Vendedor1_idx` (`Perfil_Vendedor_idPerfil_Vendedor` ASC),  INDEX `fk_Anuncio_Produto1_idx` (`Categoria_Produto_idProduto` ASC),  CONSTRAINT `fk_Anuncio_Perfil_Vendedor1`    FOREIGN KEY (`Perfil_Vendedor_idPerfil_Vendedor`)    REFERENCES `Perfil_Vendedor` (`idPerfil_Vendedor`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,  CONSTRAINT `fk_Anuncio_Produto1`    FOREIGN KEY (`Categoria_Produto_idProduto`)    REFERENCES `Categoria_Produto` (`idCategoria_Produto`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
-- insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (5,1,15.00,'descrição x',20);
CREATE TABLE IF NOT EXISTS `Compra` (  `idCompra` INT NOT NULL AUTO_INCREMENT,  `Perfil_Cliente_idPerfil_Cliente` INT NOT NULL,  `Data_compra` datetime not null,  PRIMARY KEY (`idCompra`),  INDEX `fk_Compra_Perfil_Cliente1_idx` (`Perfil_Cliente_idPerfil_Cliente` ASC),  CONSTRAINT `fk_Compra_Perfil_Cliente1`    FOREIGN KEY (`Perfil_Cliente_idPerfil_Cliente`)    REFERENCES `teste`.`Perfil_Cliente` (`idPerfil_Cliente`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDB;
-- insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra) values (1,current_date());
CREATE TABLE IF NOT EXISTS `Compra_has_Produto` (  `Quantidade` INT NOT NULL,  `valor_total` DOUBLE NOT NULL,  `Produto_idProduto` INT NOT NULL,  `Cliente_idPerfil_Cliente` INT NOT NULL,  `Compra_idCompra` INT NOT NULL,  INDEX `fk_Compra_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) ,  INDEX `fk_Compra_has_Produto_Compra1_idx` (`Compra_idCompra` ASC) ,  CONSTRAINT `fk_Compra_has_Produto_Produto1`    FOREIGN KEY (`Produto_idProduto`)    REFERENCES `teste`.`Produto` (`idProduto`)    ON DELETE NO ACTION    ON UPDATE NO ACTION,  CONSTRAINT `fk_Compra_has_Produto_Compra1`    FOREIGN KEY (`Compra_idCompra`)    REFERENCES `teste`.`Compra` (`idCompra`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDB;
-- insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(5,250,1,2,1);
CREATE TABLE IF NOT EXISTS `Categoria_Produto` (  `idCategoria_Produto` INT(11) NOT NULL auto_increment,  `Nome_categoria` VARCHAR(45) NULL DEFAULT NULL,  `Categoria_Descrição` VARCHAR(45) NULL DEFAULT NULL,  PRIMARY KEY (`idCategoria_Produto`))ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
-- insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('VideoGames','Descrição videogames');
CREATE TABLE IF NOT EXISTS `Departamento` (  `idDepartamento` INT(11) NOT NULL auto_increment,  `Nome_Departamento` VARCHAR(45) NULL DEFAULT NULL,  `Gestor_id` INT(11) NOT NULL,  PRIMARY KEY (`idDepartamento`),  INDEX `fk_Departamento_Perfil_Funcionario1_idx` (`Gestor_id` ASC),  CONSTRAINT `fk_Departamento_Perfil_Funcionario1`    FOREIGN KEY (`Gestor_id`)    REFERENCES `teste`.`Perfil_Funcionario` (`idPerfil_Funcionario`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
-- insert into departamento(Nome_Departamento,Gestor_id) values ('Financeiro', 10);
CREATE TABLE IF NOT EXISTS `Conta_pagar` (  `idConta_pagar` INT(11) NOT NULL auto_increment,  `formaPagamento` INT(11) NULL DEFAULT NULL,  `parcelas` INT(11) NULL DEFAULT NULL,  `cartao` VARCHAR(45) NULL DEFAULT NULL,  `recebimento_aprovado` TINYINT(4) NULL DEFAULT NULL,  `Compra_idCompra` INT(11) NOT NULL,  PRIMARY KEY (`idConta_pagar`),  INDEX `fk_Conta_pagar_Compra_has_Produto1_idx` (`Compra_idCompra` ASC),  CONSTRAINT `fk_Conta_pagar_Compra_has_Produto1`    FOREIGN KEY (`Compra_idCompra`)    REFERENCES `teste`.`Compra_has_Produto` (`Compra_idCompra`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
-- insert into Conta_pagar(formaPagamento,parcelas,cartao,recebimento_aprovado,Compra_idCompra) values(100,5,'1b34ac',1,2);
CREATE TABLE IF NOT EXISTS `Entrega` (  `idEntrega` INT(11) NOT NULL auto_increment,  `dataEntrega` DATE NULL DEFAULT NULL,  `frete` DOUBLE NULL DEFAULT NULL,  `local` VARCHAR(255) NULL DEFAULT NULL,  `sucessoEntrega` TINYINT(4) NULL DEFAULT NULL,  `Compra_idCompra` INT(11) NOT NULL,  PRIMARY KEY (`idEntrega`),  INDEX `fk_Entrega_Compra_has_Produto1_idx` (`Compra_idCompra` ASC),  CONSTRAINT `fk_Entrega_Compra_has_Produto1`    FOREIGN KEY (`Compra_idCompra`)    REFERENCES `teste`.`Compra_has_Produto` (`Compra_idCompra`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDBDEFAULT CHARACTER SET = utf8;
-- insert into Entrega(dataEntrega,frete,`local`,sucessoEntrega,Compra_idCompra) values (curdate(),100,'RUA X',0,5) ;
SET SQL_MODE=@OLD_SQL_MODE;SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- inserts 
-- Containsert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Joao','Joao123','0000','joao@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Pedro','Pedro123','0000','pedro@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('marcos','marcos123','0000','marcos@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Jorge','jorge123','0000','jorge@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('pedroca','pedroca123','0000','pedroca@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('lucas','lucas123','0000','lucas@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('mat','mat123','0000','mat@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('luqinhas','luqinhas123','0000','luquinhas@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('matheus','matheus123','0000','matheus@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('pedrao','pedrao123','0000','pedrao@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());
-- perfil_Funcionarioinsert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (1,2,1);insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (2,3,4);insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (3,4,5);-- setorinsert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('Contabilidade',1,1); insert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('RH de IT',1,2); insert into Setor(Nome_Setor,Coordenador_id,Departamento_idDepartamento) values ('Redes',1,3); 
-- funçao
insert into Função(Nome_Função,Setor_idSetor) values ('Analista Contabil',1); insert into Função(Nome_Função,Setor_idSetor) values ('Analista Financeiro',1); insert into Função(Nome_Função,Setor_idSetor) values ('Agente de RH',2); insert into Função(Nome_Função,Setor_idSetor) values ('DBA',3); insert into Função(Nome_Função,Setor_idSetor) values ('Tec. Informatica',3); 


-- perfil_clienteinsert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 1, '376576767', '08280660', 'rua do joao');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 2, '12312312', '08280667', 'rua do pedro');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 3, '12212312', '08280667', 'rua do marcos');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 4, '12112312', '08280667', 'rua do jorge');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 5, '123412312', '08280667', 'rua do pedroca');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 6, '12342312', '08280667', 'rua do lucas');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 7, '122342312', '08280667', 'rua do mat');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 8, '2312312', '08280667', 'rua do luquinhas');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 9, '2312312', '08280667', 'rua do matheus');insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 10, '12312312', '08280667', 'rua do pedrao');

-- Perfil_Vendedor
insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',5);insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',6);insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',7);
-- Produto
insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (5,1,15.00,'descrição x',20);insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (5,2,300.00,'descrição y',2);insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (6,3,25000.00,'descrição z',1);insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (7,4,1500.00,'descrição a',150);insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (7,5,10.00,'descrição b',3);
-- Compra 
 insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra) values (1,current_date()); insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra) values (3,current_date());
-- Compra_has_produtoinsert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(5,250,1,1,1);insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(2,250,3,1,1);insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,5,1,1);
insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,2,3,2);insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,3,3,2);
-- Categoria Produto
insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('VideoGames','Descrição videogames');insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Livros','Descrição livros');insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Carros','Descrição carros');insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Computadores','Descrição computadores');insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Outros','Descrição outros');
-- Departamento 
insert into departamento(Nome_Departamento,Gestor_id) values ('Financeiro', 10);insert into departamento(Nome_Departamento,Gestor_id) values ('RH', 10);insert into departamento(Nome_Departamento,Gestor_id) values ('IT', 10);

-- Conta pagar insert into Conta_pagar(formaPagamento,parcelas,cartao,recebimento_aprovado,Compra_idCompra) values(100,5,'1b34ac',1,1);
-- Entrega 
insert into Entrega(dataEntrega,frete,`local`,sucessoEntrega,Compra_idCompra) values (curdate(),100,'RUA X',0,1) ;
-- drop database TESTE;
-- Listando quantidade de compras(compras e não quantidade de comprada) por produtoselect c.produto_idproduto as 'ID DO PRODUTO', p.descrição as 'NOME PRODUTO', COUNT(c.produto_idproduto) as 'COMPRAS' from compra_has_produto c INNER JOIN produto p WHERE c.produto_idProduto = p.idproduto   group by c.produto_idproduto, p.descrição;
-- produto masi vendido de cada vendedorselect co.nome, MAX(c.produto_idproduto) as 'ID DO PRODUTO', p.descrição as 'NOME PRODUTO', COUNT(c.produto_idproduto) as 'COMPRAS' from produto p, compra_has_produto c, conta co, perfil_vendedor peWHERE c.produto_idproduto = p.idproduto AND co.idconta = pe.conta_idconta AND p.perfil_vendedor_idperfil_vendedor = pe.conta_idconta group by c.produto_idproduto, p.descrição, co.nome;
-- mostrar subtotal de cada item de uma compraselect c.compra_idcompra as 'ID DA COMPRA', c.quantidade * p.preço as 'subtotal de cada item da compra' from compra_has_produto c INNER JOIN produto p INNER JOIN compra co WHERE p.idproduto = c.produto_idproduto AND c.compra_idcompra = co.idcompra;
-- total vendido pela empresaselect sum(c.quantidade * p.preço) as 'total vendido pela empresa' from compra_has_produto c INNER JOIN produto pWHERE p.idproduto = c.produto_idproduto;
-- select * from compra_has_produto;-- select * from compra;-- select * from produto;-- select * from perfil_vendedor;-- select * from conta;










