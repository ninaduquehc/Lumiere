CREATE DATABASE IF NOT EXISTS lumiere;
USE lumiere;

-- =========================
-- TABELA USUARIOS (3FN)
-- =========================
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);

-- =========================
-- TABELA CATEGORIAS (NORMALIZAÇÃO IMPORTANTE)
-- =========================
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- =========================
-- TABELA PRODUTOS (3FN)
-- =========================
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2),
    imagem VARCHAR(255),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- =========================
-- TABELA PEDIDOS (3FN)
-- =========================
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- =========================
-- TABELA ITENS_PEDIDO (3FN)
-- =========================
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- =========================
-- TABELA CARRINHO (NORMALIZADO)
-- =========================
CREATE TABLE carrinho (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT DEFAULT 1,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- =========================
-- SEED DE CATEGORIAS
-- =========================
INSERT INTO categorias (nome) VALUES
('bolsas'),
('calcas'),
('camisas'),
('casacos'),
('sapatos'),
('chapeus'),
('pijamas'),
('cintos'),
('maquiagens'),
('joias');

-- =========================
-- SEED DE USUARIOS (OPCIONAL)
-- =========================
INSERT INTO usuarios (nome, email, senha) VALUES
('Marina', 'marina@gmail.com', 'marina');

-- =========================
-- PRODUTOS (SEED NORMALIZADO)
-- =========================

-- Bolsas
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Bolsa 1','Bolsa lisa',599.90,'imagens/bolsas/bolsa_1.png',1),
('Bolsa 2','Bolsa texturizada',699.90,'imagens/bolsas/bolsa_2.png',1),
('Bolsa 3','Bolsa de alça',499.90,'imagens/bolsas/bolsa_3.png',1);

-- Calças
INSERT INTO produtos VALUES
(NULL,'Calça 1','Calça jeans',199.90,'imagens/calcas/calca_1.png',2),
(NULL,'Calça 2','Calça cinza',299.90,'imagens/calcas/calca_2.png',2),
(NULL,'Calça 3','Calça jeans marrom',399.90,'imagens/calcas/calca_3.png',2);

-- Camisas
INSERT INTO produtos VALUES
(NULL,'Camisa 1','Camisa bege',199.90,'imagens/camisas/camisa_1.png',3),
(NULL,'Camisa 2','Camisa azul',199.90,'imagens/camisas/camisa_2.png',3);

-- Casacos
INSERT INTO produtos VALUES
(NULL,'Casaco 1','Casaco bege',999.90,'imagens/casacos/casaco_1.png',4),
(NULL,'Casaco 2','Casaco verde',899.90,'imagens/casacos/casaco_2.png',4);

-- Sapatos
INSERT INTO produtos VALUES
(NULL,'Sapato 1','Sapato preto',499.90,'imagens/sapatos/sapato_1.png',5),
(NULL,'Sapato 2','Sapato bege',599.90,'imagens/sapatos/sapato_2.png',5);

-- Joias (exemplo)
INSERT INTO produtos VALUES
(NULL,'Joia 1','Brincos prata',999.90,'imagens/joias/joia_1.png',10),
(NULL,'Joia 2','Alianças douradas',4999.90,'imagens/joias/joia_2.png',10);