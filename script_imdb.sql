-- -----------------------------------------------------
-- DATABASE db_imdb | DDL - DATA DEFINITION LANGUAGE
-- -----------------------------------------------------
CREATE DATABASE db_imdb;
USE db_imdb;
SHOW TABLES;

-- ----------------------------------------
-- table tb_pais
-- ----------------------------------------
CREATE TABLE tb_pais (
	pai_sigla VARCHAR(2),
    pai_descricao VARCHAR(45) NOT NULL,
    PRIMARY KEY (pai_sigla));

-- ----------------------------------------
-- table tb_estado
-- ----------------------------------------
CREATE TABLE tb_estado (
	est_sigla VARCHAR(2),
	est_descricao VARCHAR(45) NOT NULL,
    PRIMARY KEY (est_sigla));

-- ----------------------------------------
-- table tb_cidade
-- ----------------------------------------
CREATE TABLE tb_cidade (
	cid_id INT,
    cid_descricao VARCHAR(45) NOT NULL,
    PRIMARY KEY (cid_id));

-- ----------------------------------------
-- table tb_endereco
-- ----------------------------------------
CREATE TABLE tb_endereco (
	end_cid_id INT,
    end_est_sigla VARCHAR(2) NOT NULL,
    end_pai_sigla VARCHAR(2) NOT NULL,
    PRIMARY KEY (end_cid_id, end_est_sigla),
	FOREIGN KEY (end_pai_sigla) REFERENCES tb_pais (pai_sigla));
    
-- ----------------------------------------
-- table tb_sexo
-- ----------------------------------------
CREATE TABLE tb_sexo (
	sex_id INT,
    sex_descricao VARCHAR(45),
    PRIMARY KEY (sex_id));

-- ----------------------------------------
-- table tb_pessoa
-- ----------------------------------------
CREATE TABLE tb_pessoa (
	pes_id INT,
    pes_nome VARCHAR(100) NOT NULL,
    pes_dataNasc DATE NOT NULL,
    pes_sex_id INT NOT NULL,
    pes_end_cid_id INT NOT NULL,
    pes_end_est_sigla VARCHAR(2) NOT NULL,
    PRIMARY KEY (pes_id),
    FOREIGN KEY (pes_sex_id) REFERENCES tb_sexo (sex_id),
    FOREIGN KEY (pes_end_cid_id, pes_end_est_sigla) REFERENCES tb_endereco (end_cid_id, end_est_sigla));
    
-- ----------------------------------------
-- table tb_diretor
-- ----------------------------------------
CREATE TABLE tb_diretor (
	dir_id INT,
    dir_pes_id INT NOT NULL,
    PRIMARY KEY (dir_id),
    FOREIGN KEY (dir_pes_id) REFERENCES tb_pessoa (pes_id));

-- ----------------------------------------
-- table tb_estrela
-- ----------------------------------------
CREATE TABLE tb_estrela (
	estr_id INT,
    estr_pes_id INT NOT NULL,
    PRIMARY KEY (estr_id),
    FOREIGN KEY (estr_pes_id) REFERENCES tb_pessoa (pes_id));

-- ----------------------------------------
-- table tb_roteirista
-- ----------------------------------------
CREATE TABLE tb_roteirista (
	rot_id INT,
    rot_pes_id INT NOT NULL,
    PRIMARY KEY (rot_id),
    FOREIGN KEY (rot_pes_id) REFERENCES tb_pessoa (pes_id));
    
-- ----------------------------------------
-- table tb_produtor
-- ----------------------------------------
CREATE TABLE tb_produtor (
	prod_id INT,
    prod_pes_id INT NOT NULL,
    PRIMARY KEY (prod_id),
    FOREIGN KEY (prod_pes_id) REFERENCES tb_pessoa (pes_id));

-- ----------------------------------------
-- table tb_produtora
-- ----------------------------------------
CREATE TABLE tb_produtora (
	proda_id INT,
    proda_descricao VARCHAR(45) NOT NULL,
    PRIMARY KEY (proda_id));
    
-- ----------------------------------------
-- table tb_classIndicativa
-- ----------------------------------------
CREATE TABLE tb_classIndicativa (
	cli_sigla VARCHAR(2),
    cli_descricao VARCHAR(100) NOT NULL,
    cli_caracteristica VARCHAR(100) NOT NULL,
    PRIMARY KEY (cli_sigla));
    

-- ----------------------------------------
-- table tb_bilheteria
-- ----------------------------------------
CREATE TABLE tb_bilheteria (
	bil_id INT,
    bil_orcamento DOUBLE,
    bil_lucroUS DOUBLE NOT NULL,
    bil_lucroWW DOUBLE NOT NULL,
    PRIMARY KEY (bil_id));


-- ----------------------------------------
-- table tb_genero
-- ----------------------------------------
CREATE TABLE tb_genero (
	gen_id INT,
    gen_descricao VARCHAR(45) NOT NULL,
    PRIMARY KEY (gen_id));
    
-- ----------------------------------------
-- table tb_premio	
-- ----------------------------------------
CREATE TABLE tb_premio (
	pre_id INT,
    pre_nome VARCHAR(100) NOT NULL,
    pre_ano DATE NOT NULL,
    PRIMARY KEY (pre_id));
    
    -- ----------------------------------------
-- table tb_metacritic
-- ----------------------------------------
CREATE TABLE tb_metacritic (
	metc_id INT,
    metc_afiliacao VARCHAR(45) NOT NULL,
    metc_nome VARCHAR (45) NOT NULL,
    PRIMARY KEY (metc_id));

-- ----------------------------------------
-- table tb_metascore
-- ----------------------------------------
CREATE TABLE tb_metascore (
	mets_id INT,
    mets_nota FLOAT NOT NULL,
    mets_metc_id INT NOT NULL,
    PRIMARY KEY (mets_id),
    FOREIGN KEY (mets_metc_id) REFERENCES tb_metacritic (metc_id));

-- ----------------------------------------
-- table tb_filme
-- ----------------------------------------
CREATE TABLE tb_filme (
	fil_id INT,
    fil_tituloBR VARCHAR(100) NOT NULL,
    fil_tituloOG VARCHAR(100),
    fil_anoLanc VARCHAR(4) NOT NULL,
    fil_duracao VARCHAR(45) NOT NULL,
    fil_avaliacaoImdb FLOAT NOT NULL,
    fil_sinopse VARCHAR(600) NOT NULL,
    fil_mets_id INT NOT NULL,
    fil_bil_id INT NOT NULL,
	fil_cli_sigla VARCHAR(2) NOT NULL,
    PRIMARY KEY (fil_id),
    FOREIGN KEY (fil_mets_id) REFERENCES tb_metascore (mets_id),
    FOREIGN KEY (fil_bil_id) REFERENCES tb_bilheteria (bil_id),
    FOREIGN KEY (fil_cli_sigla) REFERENCES tb_classIndicativa (cli_sigla));

-- ----------------------------------------
-- table tb_tem_premio
-- ----------------------------------------
CREATE TABLE tb_tem_premio (
	tp_id INT,
    tp_dir_id INT,
    tp_prod_id INT,
    tp_estr_id INT,
    tp_rot_id INT,
    tp_fil_id INT,
    tp_tem_premio TINYINT NOT NULL,
    tp_pre_id INT,
    PRIMARY KEY (tp_id),
    FOREIGN KEY (tp_dir_id) REFERENCES tb_diretor (dir_id),
    FOREIGN KEY (tp_prod_id) REFERENCES tb_produtor (prod_id),
    FOREIGN KEY (tp_estr_id) REFERENCES tb_estrela (estr_id),
    FOREIGN KEY (tp_rot_id) REFERENCES tb_roteirista (rot_id),
    FOREIGN KEY (tp_fil_id) REFERENCES tb_filme (fil_id),
    FOREIGN KEY (tp_pre_id) REFERENCES tb_premio (pre_id));
    
-- ----------------------------------------
-- table tb_filGen
-- ----------------------------------------
CREATE TABLE tb_filGen (
	fg_fil_id INT,
    fg_gen_id INT,
    PRIMARY KEY (fg_fil_id, fg_gen_id),
    FOREIGN KEY (fg_fil_id) REFERENCES tb_filme (fil_id),
    FOREIGN KEY (fg_gen_id) REFERENCES tb_genero (gen_id));

-- ----------------------------------------
-- table tb_filProd
-- ----------------------------------------
CREATE TABLE tb_filProd (
	fp_fil_id INT,
    fp_prod_id INT,
    PRIMARY KEY (fp_fil_id, fp_prod_id),
    FOREIGN KEY (fp_fil_id) REFERENCES tb_filme (fil_id),
    FOREIGN KEY (fp_prod_id) REFERENCES tb_produtora (proda_id));
