DROP DATABASE IF EXISTS SiteCompras;

CREATE DATABASE IF NOT EXISTS SiteCompras;

USE SiteCompras;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `SiteCompras`.`conta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conta` (
  `idConta` INT(11) NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL DEFAULT NULL,
  `Usuario` VARCHAR(45) NULL DEFAULT NULL,
  `Senha` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Nivel` INT(11) NULL DEFAULT NULL,
  `Ativo` VARCHAR(45) CHARACTER SET 'latin1' COLLATE 'latin1_bin' NULL DEFAULT NULL,
  `Cpf` VARCHAR(45) NULL DEFAULT NULL,
  `Genero` VARCHAR(45) NULL DEFAULT NULL,
  `Nascimento` VARCHAR(45) NULL DEFAULT NULL,
  `DataCriacao` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idConta`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `perfil_cliente` (
  `idPerfil_Cliente` INT(11) NOT NULL AUTO_INCREMENT,
  `Numero_Cartão` VARCHAR(45) NULL DEFAULT NULL,
  `Conta_idConta` INT(11) NOT NULL,
  `Telefone` VARCHAR(11) NULL DEFAULT NULL,
  `CEP` VARCHAR(9) NULL DEFAULT NULL,
  `Endereco` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idPerfil_Cliente`),
  INDEX `fk_Perfil_Cliente_Conta1_idx` (`Conta_idConta` ASC),
  CONSTRAINT `fk_Perfil_Cliente_Conta1`
    FOREIGN KEY (`Conta_idConta`)
    REFERENCES `conta` (`idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `compra` (
  `idCompra` INT(11) NOT NULL AUTO_INCREMENT,
  `Perfil_Cliente_idPerfil_Cliente` INT(11) NOT NULL,
  `Valor_total` int(11),
  `Data_compra` DATETIME NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `fk_Compra_Perfil_Cliente1_idx` (`Perfil_Cliente_idPerfil_Cliente` ASC),
  CONSTRAINT `fk_Compra_Perfil_Cliente1`
    FOREIGN KEY (`Perfil_Cliente_idPerfil_Cliente`)
    REFERENCES `perfil_cliente` (`idPerfil_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


CREATE TABLE IF NOT EXISTS `status_compra` (
  `descricao_Status` VARCHAR(50) NOT NULL,
  `compra_idCompra` INT(11) NOT NULL,
  INDEX `fk_status_compra_compra_idx` (`compra_idCompra` ASC),
  CONSTRAINT `fk_status_compra_compra`
    FOREIGN KEY (`compra_idCompra`)
    REFERENCES `compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `endereco` (
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `numero` INT NULL,
  `conta_idConta` INT(11) NOT NULL,
  INDEX `fk_endereco_conta1_idx` (`conta_idConta` ASC),
  CONSTRAINT `fk_endereco_conta1`
    FOREIGN KEY (`conta_idConta`)
    REFERENCES `conta` (`idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `SiteCompras` ;


CREATE TABLE IF NOT EXISTS `categoria_produto` (
  `idCategoria_Produto` INT(11) NOT NULL AUTO_INCREMENT,
  `Nome_categoria` VARCHAR(45) NULL DEFAULT NULL,
  `Categoria_Descrição` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategoria_Produto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`perfil_vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfil_vendedor` (
  `idPerfil_Vendedor` INT(11) NOT NULL AUTO_INCREMENT,
  `CNPJ` VARCHAR(45) NULL DEFAULT NULL,
  `Conta_idConta` INT(11) NOT NULL,
  PRIMARY KEY (`idPerfil_Vendedor`),
  INDEX `fk_Perfil_Vendedor_Conta1_idx` (`Conta_idConta` ASC),
  CONSTRAINT `fk_Perfil_Vendedor_Conta1`
    FOREIGN KEY (`Conta_idConta`)
    REFERENCES `conta` (`idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produto` (
  `idProduto` INT(11) NOT NULL AUTO_INCREMENT,
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
    REFERENCES `perfil_vendedor` (`idPerfil_Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Anuncio_Produto1`
    FOREIGN KEY (`Categoria_Produto_idProduto`)
    REFERENCES `categoria_produto` (`idCategoria_Produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`compra_has_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compra_has_produto` (
  `Quantidade` INT(11) NOT NULL,
  `valor_total` DOUBLE NOT NULL,
  `Produto_idProduto` INT(11) NOT NULL,
  `Cliente_idPerfil_Cliente` INT(11) NOT NULL,
  `Compra_idCompra` INT(11) NOT NULL,
  INDEX `fk_Compra_has_Produto_Produto1_idx` (`Produto_idProduto` ASC),
  INDEX `fk_Compra_has_Produto_Compra1_idx` (`Compra_idCompra` ASC),
  CONSTRAINT `fk_Compra_has_Produto_Compra1`
    FOREIGN KEY (`Compra_idCompra`)
    REFERENCES `compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `SiteCompras`.`conta_pagar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `conta_pagar` (
  `idConta_pagar` INT(11) NOT NULL AUTO_INCREMENT,
  `formaPagamento` VARCHAR(50) NULL DEFAULT NULL,
  `parcelas` INT(11) NULL DEFAULT NULL,
  `cartao` VARCHAR(45) NULL DEFAULT NULL,
  `recebimento_aprovado` TINYINT(4) NULL DEFAULT NULL,
  `compra_idCompra` INT(11) NOT NULL,
  PRIMARY KEY (`idConta_pagar`),
  INDEX `fk_conta_pagar_compra1_idx` (`compra_idCompra` ASC),
  CONSTRAINT `fk_conta_pagar_compra1`
    FOREIGN KEY (`compra_idCompra`)
    REFERENCES `compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`setor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `setor` (
  `idSetor` INT(11) NOT NULL AUTO_INCREMENT,
  `Nome_Setor` VARCHAR(45) NULL DEFAULT NULL,
  `Coordenador_id` INT(11) NULL,
  `Departamento_idDepartamento` INT(11) NOT NULL,
  PRIMARY KEY (`idSetor`),
  INDEX `fk_Setor_Perfil_Funcionario1_idx` (`Coordenador_id` ASC),
  INDEX `fk_Setor_Departamento1_idx` (`Departamento_idDepartamento` ASC),
  CONSTRAINT `fk_Setor_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Setor_Perfil_Funcionario1`
    FOREIGN KEY (`Coordenador_id`)
    REFERENCES `perfil_funcionario` (`idPerfil_Funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`função`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `função` (
  `idFunção` INT(11) NOT NULL AUTO_INCREMENT,
  `Nome_Função` VARCHAR(45) NULL DEFAULT NULL,
  `Setor_idSetor` INT(11) NOT NULL,
  PRIMARY KEY (`idFunção`),
  INDEX `fk_Função_Setor1_idx` (`Setor_idSetor` ASC),
  CONSTRAINT `fk_Função_Setor1`
    FOREIGN KEY (`Setor_idSetor`)
    REFERENCES `setor` (`idSetor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`perfil_funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `perfil_funcionario` (
  `idPerfil_Funcionario` INT(11) NOT NULL AUTO_INCREMENT,
  `Setor_idSetor` INT(11) NOT NULL,
  `Conta_idConta` INT(11) NOT NULL,
  `Função_idFunção` INT(11) NOT NULL,
  PRIMARY KEY (`idPerfil_Funcionario`),
  INDEX `fk_Perfil_Funcionario_Conta1_idx` (`Conta_idConta` ASC),
  INDEX `fk_Perfil_Funcionario_Função1_idx` (`Função_idFunção` ASC),
  CONSTRAINT `fk_Perfil_Funcionario_Conta1`
    FOREIGN KEY (`Conta_idConta`)
    REFERENCES `SiteCompras`.`conta` (`idConta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Perfil_Funcionario_Função1`
    FOREIGN KEY (`Função_idFunção`)
    REFERENCES `SiteCompras`.`função` (`idFunção`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `departamento` (
  `idDepartamento` INT(11) NOT NULL AUTO_INCREMENT,
  `Nome_Departamento` VARCHAR(45) NULL DEFAULT NULL,
  `Gestor_id` INT(11)  NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `fk_Departamento_Perfil_Funcionario1_idx` (`Gestor_id` ASC),
  CONSTRAINT `fk_Departamento_Perfil_Funcionario1`
    FOREIGN KEY (`Gestor_id`)
    REFERENCES `perfil_funcionario` (`idPerfil_Funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `SiteCompras`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `entrega` (
  `idEntrega` INT(11) NOT NULL AUTO_INCREMENT,
  `dataEntrega` DATE NULL DEFAULT NULL,
  `frete` DOUBLE NULL DEFAULT NULL,
  `local` VARCHAR(255) NULL DEFAULT NULL,
  `sucessoEntrega` TINYINT(4) NULL DEFAULT NULL,
  `compra_idCompra` INT(11) NOT NULL,
  PRIMARY KEY (`idEntrega`),
  INDEX `fk_entrega_compra1_idx` (`compra_idCompra` ASC),
  CONSTRAINT `fk_entrega_compra1`
    FOREIGN KEY (`compra_idCompra`)
    REFERENCES `compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Procedures
-- -----------------------------------------------------


-- Define um gestor para um determinado departamento com o id do funcionario e o id do departamento
Drop PROCEDURE if exists `Pro_Definir_Gestor`;
delimiter $$

CREATE PROCEDURE `Pro_Definir_Gestor` (in id_gestor int(10),in id_departamento int(10))
BEGIN
	update `SiteCompras`.`Departamento` set Gestor_id=id_gestor where idDepartamento = id_departamento ;
END $$
delimiter ;



-- Define um coordenador para um determinado setor com o id do funcionario e o id do setor
Drop PROCEDURE if exists `Pro_Definir_Coordenador`;
delimiter $$

CREATE PROCEDURE `Pro_Definir_Coordenador` (in id_Coordenador int(10),in id_setor int(10))
BEGIN
	update `SiteCompras`.`setor` set Coordenador_id=id_Coordenador where idsetor = id_setor ;
END $$
delimiter ;

-- -----------------------------------------------------
-- Procedures
-- -----------------------------------------------------
-- -----------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------

use SiteCompras;
drop trigger if exists AFTER_COMPRA_INSERT;

DELIMITER $$
CREATE TRIGGER AFTER_COMPRA_INSERT
AFTER INSERT ON `SiteCompras`.`compra`
FOR EACH ROW
BEGIN
	insert into `SiteCompras`.`status_compra` values ("em andamento",new.idcompra);
    
END$$
DELIMITER ;


drop trigger if exists BEFORE_COMPRA_HAS_PRODUTO_INSERT;

DELIMITER $$
CREATE TRIGGER BEFORE_COMPRA_HAS_PRODUTO_INSERT
before INSERT ON `COMPRA_HAS_PRODUTO`
FOR EACH ROW
BEGIN

-- atualiza o campo valor_total na tabela de compra_has_produto para ter o valor do produto * quantidade de um dos produtos da compra
set new.`Valor_total` = new.`quantidade` * (select preço from produto where idproduto = new.`Produto_idProduto`);
-- atualiza o campo estoque para subtrair que foram comprados
update `produto` set `produto`.`Estoque` = `produto`.`Estoque` - new.`Quantidade` where `idProduto` = new.`Produto_idProduto`;    
-- calcula o valor total e atualiza o campo do valor total na tabela de compra
update `compra`set `compra`.`Valor_total` = `compra`.`Valor_total` + new.`Valor_total` where `idCompra` = new.`Compra_idCompra` ;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------


-- inserts 

 

-- Conta

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Joao','Joao123','0000','joao@domain.com',0,'sim','1346567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Pedro','Pedro123','0000','pedro@domain.com',0,'sim','4567123-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Marcos','marcos123','0000','marcos@domain.com',0,'sim','2345671-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Jorge','jorge123','0000','jorge@domain.com',0,'sim','3456723-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Pedrock','pedroca123','0000','pedroca@domain.com',0,'sim','3456733-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Lucas','lucas123','0000','lucas@domain.com',0,'sim','3456734-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Matheus','mat123','0000','mat@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Marino','marin123','0000','marinho@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Gustavo Marinho','gust123','0000','gust@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Jorge','jorge123','0000','jorge@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Tiago','tiago123','0000','jorge@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Ton','ton123','0000','ton@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

insert into Conta(Nome,Usuario,Senha,Email,Nivel,Ativo,Cpf,Genero,Nascimento,DataCriacao) VALUES ('Carlos','carlos123','0000','carlos@domain.com',0,'sim','1234567-8','m','01/01/0001',current_date());

-- Endereço

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Rua das Palmeiras', 'Cidade líder', 88, 10);

insert into endereco VALUES ('Santos', 'São Paulo', 'Brasil', 'Rua dos trabalhadores', 'cidade do trabalho', 18, 11);

insert into endereco VALUES ('Diadema', 'São Paulo', 'Brasil', 'Avenida sonho batista', 'cidade dos cidadãos', 12, 12);

insert into endereco VALUES ('Jundiaí', 'São Paulo', 'Brasil', 'Rua da judiação', 'Cidade Jundiaí', 66, 13);

insert into endereco VALUES ('Santos', 'São Paulo', 'Brasil', 'Rua de todos os santos', 'Cidade dos Santos', 17, 14);

insert into endereco VALUES ('ABC', 'São Paulo', 'Brasil', 'Rua do abc', 'Cidade ABC', 96, 15);

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Av paulista', 'Centro', 99, 16);

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Av das araucárias', 'Araucárias', 100, 17);

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Rua dos Sonhos', 'Jardim célia', 118, 18);

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Av Líder', 'Cidade líder', 68, 19);

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Rua Orlando', 'Jardim das Orlas', 98, 20);

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Rua das igrejas', 'Cidade Crente', 78, 21);

insert into endereco VALUES ('São Paulo', 'São Paulo', 'Brasil', 'Avenida teodoro sampaio', 'Centro', 102, 22);

-- Departamento 

 

insert into departamento(Nome_Departamento) values ('Financeiro');

insert into departamento(Nome_Departamento) values ('RH');

insert into departamento(Nome_Departamento) values ('IT');


 -- setor

insert into Setor(Nome_Setor,Departamento_idDepartamento) values ('Contabilidade',1); 

insert into Setor(Nome_Setor,Departamento_idDepartamento) values ('RH de IT',2); 

insert into Setor(Nome_Setor,Departamento_idDepartamento) values ('Redes',3); 

-- funçao

 

insert into Função(Nome_Função,Setor_idSetor) values ('Analista Contabil',1); 

insert into Função(Nome_Função,Setor_idSetor) values ('Analista Financeiro',1); 

insert into Função(Nome_Função,Setor_idSetor) values ('Agente de RH',2); 

insert into Função(Nome_Função,Setor_idSetor) values ('DBA',3); 

insert into Função(Nome_Função,Setor_idSetor) values ('Tec. Informatica',3); 

 

 

-- perfil_Funcionario

insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (1,20,1); -- arrumar fk da conta

insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (2,21,4); -- arrumar fk da conta

insert into Perfil_Funcionario (Setor_idSetor,Conta_idConta,Função_idFunção) VALUES (3,22,5); -- arrumar fk da conta



 

-- perfil_cliente

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 10, '376576767', '08280660', 'rua do joao');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 11, '12312312', '08280667', 'rua do pedro');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 12, '12212312', '08280667', 'rua do marcos');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 13, '12112312', '08280667', 'rua do jorge');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 14, '123412312', '08280667', 'rua do pedroca');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 15, '12342312', '08280667', 'rua do lucas');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 16, '122342312', '08280667', 'rua do mat');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 17, '2312312', '08280667', 'rua do luquinhas');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 18, '2312312', '08280667', 'rua do matheus');

insert into Perfil_Cliente (Numero_Cartão,Conta_idConta, Telefone, CEP, Endereco) values ('423412312', 19, '12312312', '08280667', 'rua do pedrao');

 

 

-- Perfil_Vendedor

 

insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',15);

insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',16);

insert into Perfil_Vendedor(CNPJ,Conta_idConta) values('12414151-5',17);

 select * from perfil_vendedor;
 
 -- Categoria Produto

 

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('VideoGames','Descrição videogames');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Livros','Descrição livros');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Carros','Descrição carros');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Computadores','Descrição computadores');

insert into Categoria_Produto(Nome_categoria,Categoria_Descrição) values('Outros','Descrição outros');

-- Produto
 select * from Produto;
 
insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (1,1,15.00,'descrição x',200);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (1,2,300.00,'descrição y',20);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (2,3,25000.00,'descrição z',10);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (3,4,1500.00,'descrição a',1500);

insert into Produto (Perfil_Vendedor_idPerfil_Vendedor,Categoria_Produto_idProduto,Preço,Descrição,Estoque) values (3,5,10.00,'descrição b',30);

 -- Compra 


 

 insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra,Valor_total) values (2,current_date(),0);

 insert into Compra(Perfil_Cliente_idPerfil_Cliente,Data_compra,Valor_total) values (3,current_date(),0);
 
 -- Compra_has_produto

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(5,250,2,2,2);

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(2,250,3,2,2);

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,5,2,2);


insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,2,3,1);

insert into Compra_has_Produto(Quantidade,valor_total,Produto_idProduto,Cliente_idPerfil_Cliente,Compra_idCompra) values(1,250,3,3,1);

-- Conta pagar

insert into Conta_pagar(formaPagamento,parcelas,cartao,recebimento_aprovado,Compra_idCompra) values(100,5,'1b34ac',1,1);


-- Entrega 

insert into Entrega(dataEntrega,frete,`local`,sucessoEntrega,Compra_idCompra) values (curdate(),100,'RUA X',0,1) ;

 
 -- 10 SELECTS
 
 -- Listando quantidade de compras(compras e não quantidade comprada) por produto

select c.produto_idproduto as 'ID DO PRODUTO', p.descrição as 'NOME PRODUTO', COUNT(c.produto_idproduto) as 'COMPRAS' from compra_has_produto c INNER JOIN produto p 

WHERE c.produto_idProduto = p.idproduto   group by c.produto_idproduto, p.descrição;

 

-- produto mais vendido de cada vendedor (decrescente)

select co.nome, c.produto_idproduto as 'ID DO PRODUTO', p.descrição as 'NOME PRODUTO', COUNT(c.produto_idproduto) as 'COMPRAS' from produto p, compra_has_produto c, conta co, perfil_vendedor pe

WHERE c.produto_idproduto = p.idproduto AND co.idconta = pe.conta_idconta AND p.perfil_vendedor_idperfil_vendedor = pe.idPerfil_vendedor

group by c.produto_idproduto, p.descrição, co.nome;

-- ordem crescente

select co.nome, c.produto_idproduto as 'ID DO PRODUTO', p.descrição as 'NOME PRODUTO', COUNT(c.produto_idproduto) as 'COMPRAS' from produto p, compra_has_produto c, conta co, perfil_vendedor pe

WHERE c.produto_idproduto = p.idproduto AND co.idconta = pe.conta_idconta AND p.perfil_vendedor_idperfil_vendedor = pe.idPerfil_vendedor

group by c.produto_idproduto, p.descrição, co.nome ORDER BY COUNT(c.produto_idproduto);

-- mostrar subtotal de cada item de uma compra

select c.compra_idcompra as 'ID DA COMPRA', c.quantidade * p.preço as 'subtotal de cada item da compra' from compra_has_produto c INNER JOIN produto p INNER JOIN compra co 

WHERE p.idproduto = c.produto_idproduto AND c.compra_idcompra = co.idcompra;

-- total vendido pela empresa

select sum(c.quantidade * p.preço) as 'total vendido pela empresa' from compra_has_produto c INNER JOIN produto p

WHERE p.idproduto = c.produto_idproduto;

 
-- TODOS OS SELECTS 
select * from conta;

select * from endereco;

select * from perfil_cliente;

select * from perfil_funcionario;

select * from função;

select * from setor;

select * from departamento;

select * from perfil_vendedor;

select * from produto;

select * from categoria_produto;

select * from compra_has_produto;

select * from compra;

select * from status_compra;

select * from entrega;

select * from conta_pagar;

-- ATUALIZANDO REGISTROS
update conta SET `Nome` = 'novo nome', `Usuario` = 'novo user', `Senha` = 'nova senha', `Email`='novo@email.com', `Nivel` = 1, `Ativo` = 'sim',
`Cpf` = '44922173806',
`Genero` = 'M', 
`Nascimento` = '01/02/1998', `DataCriacao` = now() WHERE idconta = 10;


update endereco SET cidade = 'cidade nova', estado = 'estado novo', pais = 'país novo', logradouro = 'rua nova', bairro='novo',
numero = '96', conta_idConta= 12 where conta_idconta=10;

show columns from produto;

update perfil_cliente SET Numero_Cartão = '1212121', Conta_idConta = 10, Telefone = '2743365', CEP = '08280667', Endereco = 'Rua jackson 98'
where idPerfil_cliente = 10;

update perfil_funcionario SET Setor_idSetor = 1, Conta_idConta = 1, Função_idFunção = 1 where idperfil_funcionario = 5;

update função SET Nome_Função = 'nova func', Setor_idSetor = 1 where idFunção = 1;

update setor SET Nome_Setor = 'Novo setor', Coordenador_id = 10, Departamento_idDepartamento = 1 where idsetor = 5;

update departamento SET Nome_Departamento = 'Novo depart', Gestor_id = 1 where iddepartamento = 5;

update perfil_vendedor SET CNPJ = '121212/11-1', Conta_idConta = 1 where idPerfil_Vendedor = 4;

update produto SET Perfil_Vendedor_idPerfil_Vendedor = 1,  Categoria_Produto_idProduto = 1, preço = 1, descrição = 'Atualizando', 
Descrição = 'teste', Estoque= 1 where idproduto = 1;

-- update categoria_produto = set ;

-- update compra_has_produto;

-- update compra;

-- update status_compra;

-- update entrega;

-- update conta_pagar;


-- DELETANDO REGISTROS
delete from conta_pagar where idconta_pagar = 1;

delete from entrega where identrega = 1;

delete from status_compra where compra_idcompra = 1;

delete from produto where idproduto = 1;

delete from categoria_produto where idcategoria_produto = 1;

delete from perfil_vendedor where idperfil_vendedor = 4;

delete from compra_has_produto where compra_idcompra = 1;

delete from compra where idcompra = 1;

delete from endereco where conta_idConta = 10;

delete from perfil_cliente where idperfil_cliente = 10;

delete from perfil_funcionario where idperfil_funcionario = 1;

delete from função where idfunção = 1;

delete from setor where idsetor = 4;

delete from departamento where iddepartamento = 4;

delete from conta where idconta = 1;

 -- SELECT COM JOINS, inner
select f.nome_função, s.nome_setor from função f inner join setor s where f.setor_idsetor = s.idsetor;
select s.nome_setor, d.nome_departamento from setor s inner join departamento d where s.departamento_iddepartamento = d.iddepartamento;
-- left
select * from função f left join setor s on f.setor_idsetor = s.idsetor;
select * from setor s left join departamento d on s.departamento_iddepartamento = d.iddepartamento;
-- right
select * from função f right join setor s on f.setor_idsetor = s.idsetor;
select * from setor s right join departamento d on s.departamento_iddepartamento = d.iddepartamento;
-- full outer join
select * from função f left join setor s on f.setor_idsetor = s.idsetor 
UNION 
select * from função f right join setor s on f.setor_idsetor = s.idsetor;

select * from setor s left join departamento d on s.departamento_iddepartamento = d.iddepartamento 
UNION
select * from setor s right join departamento d on s.departamento_iddepartamento = d.iddepartamento;








