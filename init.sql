CREATE DATABASE IF NOT EXISTS lumiere;
USE lumiere;

-- =========================
-- TABELA USUARIOS
-- =========================
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);

-- =========================
-- TABELA CATEGORIAS
-- =========================
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- =========================
-- TABELA PRODUTOS 
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
-- TABELA PEDIDOS 
-- =========================
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- =========================
-- TABELA ITENS_PEDIDO 
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
-- TABELA CARRINHO 
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
-- INSERT CATEGORIAS
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
-- INSERT PRODUTOS 
-- =========================

-- Bolsas
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Bolsa 1','Bolsa lisa',599.90,'imagens/bolsas/bolsa_1.png',1),
('Bolsa 2','Bolsa texturizada',699.90,'imagens/bolsas/bolsa_2.png',1),
('Bolsa 3','Bolsa de alça',499.90,'imagens/bolsas/bolsa_3.png',1),
('Bolsa 4','Bolsa sacola',799.90,'imagens/bolsas/bolsa_4.png',1),
('Bolsa 5','Bolsa de mão',699.90,'imagens/bolsas/bolsa_5.png',1),
('Bolsa 6','Bolsa cruzada',899.90,'imagens/bolsas/bolsa_6.png',1);

-- Calças
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Calça 1','Calça jeans',199.90,'imagens/calcas/calca_1.png',2),
('Calça 2','Calça cinza',299.90,'imagens/calcas/calca_2.png',2),
('Calça 3','Calça jeans marrom',399.90,'imagens/calcas/calca_3.png',2),
('Calça 4','Calça preta',299.90,'imagens/calcas/calca_4.png',2),
('Calça 5','Calça marrom veludo',199.90,'imagens/calcas/calca_5.png',2),
('Calça 6','Calça verde',299.90,'imagens/calcas/calca_6.png',2);

-- Camisas
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Camisa 1','Camisa bege',199.90,'imagens/camisas/camisa_1.png',3),
('Camisa 2','Camisa azul',199.90,'imagens/camisas/camisa_2.png',3),
('Camisa 3','Camisa preta de botão',399.90,'imagens/camisas/camisa_3.png',3),
('Camisa 4','Camisa verde',199.90,'imagens/camisas/camisa_4.png',3),
('Camisa 5','Camisa cinza',199.90,'imagens/camisas/camisa_5.png',3),
('Camisa 6','Camisa preta elegante',299.90,'imagens/camisas/camisa_6.png',3);

-- Casacos
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Casaco 1','Casaco bege',999.90,'imagens/casacos/casaco_1.png',4),
('Casaco 2','Casaco verde',899.90,'imagens/casacos/casaco_2.png',4),
('Casaco 3','Casaco de couro',1099.90,'imagens/casacos/casaco_3.png',4),
('Casaco 4','Casaco cinza',899.90,'imagens/casacos/casaco_4.png',4),
('Casaco 5','Casaco jeans',799.90,'imagens/casacos/casaco_5.png',4),
('Casaco 6','Casaco puffer',999.90,'imagens/casacos/casaco_6.png',4);

-- Sapatos
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Sapato 1','Sapato preto',499.90,'imagens/sapatos/sapato_1.png',5),
('Sapato 2','Sapato bege',599.90,'imagens/sapatos/sapato_2.png',5),
('Sapato 3','Sapato peep toe',399.90,'imagens/sapatos/sapato_3.png',5),
('Sapato 4','Sapato bota',699.90,'imagens/sapatos/sapato_4.png',5),
('Sapato 5','Sapato dourado',599.90,'imagens/sapatos/sapato_5.png',5),
('Sapato 6','Sapato transparente',599.90,'imagens/sapatos/sapato_6.png',5);

-- Chapéus
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Chapéu 1','Chapéu clássico',149.90,'imagens/chapeus/chapeu_1.png',6),
('Chapéu 2','Boina marrom',249.90,'imagens/chapeus/chapeu_2.png',6),
('Chapéu 3','Touca cinza',49.90,'imagens/chapeus/chapeu_3.png',6),
('Chapéu 4','Boina listrada',249.90,'imagens/chapeus/chapeu_4.png',6),
('Chapéu 5','Boina de couro',349.90,'imagens/chapeus/chapeu_5.png',6),
('Chapéu 6','Boina cinza',249.90,'imagens/chapeus/chapeu_6.png',6);

-- Pijamas
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Pijama 1','Pijama preto',249.90,'imagens/pijamas/pijama_1.png',7),
('Pijama 2','Pijama azul',349.90,'imagens/pijamas/pijama_2.png',7),
('Pijama 3','Pijama cinza',349.90,'imagens/pijamas/pijama_3.png',7),
('Pijama 4','Pijama veludo',449.90,'imagens/pijamas/pijama_4.png',7),
('Pijama 5','Pijama branco',349.90,'imagens/pijamas/pijama_5.png',7),
('Pijama 6','Pijama listrado',249.90,'imagens/pijamas/pijama_6.png',7);

-- Cintos
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Cinto 1','Cinto preto',179.90,'imagens/cintos/cinto_1.png',8),
('Cinto 2','Cinto marrom',279.90,'imagens/cintos/cinto_2.png',8),
('Cinto 3','Cinto de lenço estampado',79.90,'imagens/cintos/cinto_3.png',8),
('Cinto 4','Cinto texturizado',379.90,'imagens/cintos/cinto_4.png',8),
('Cinto 5','Cinto de lenço liso',79.90,'imagens/cintos/cinto_5.png',8),
('Cinto 6','Cinto textura bolinhas',279.90,'imagens/cintos/cinto_6.png',8);

-- Maquiagens
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Maquiagem 1','Blush',129.90,'imagens/maquiagens/maquiagem_1.png',9),
('Maquiagem 2','Sombra',429.90,'imagens/maquiagens/maquiagem_2.png',9),
('Maquiagem 3','Rímel',229.90,'imagens/maquiagens/maquiagem_3.png',9),
('Maquiagem 4','Pincel',229.90,'imagens/maquiagens/maquiagem_4.png',9),
('Maquiagem 5','Base',329.90,'imagens/maquiagens/maquiagem_5.png',9),
('Maquiagem 6','Corretivo',229.90,'imagens/maquiagens/maquiagem_6.png',9);

-- Joias
INSERT INTO produtos (nome, descricao, preco, imagem, categoria_id)
VALUES
('Joia 1','Brincos de argola prata',999.90,'imagens/joias/joia_1.png',10),
('Joia 2','Alianças douradas',4999.90,'imagens/joias/joia_2.png',10),
('Joia 3','Pulseira prata',1999.90,'imagens/joias/joia_3.png',10),
('Joia 4','Pulseira dourada',2999.90,'imagens/joias/joia_4.png',10),
('Joia 5','Anel prata',1999.90,'imagens/joias/joia_5.png',10),
('Joia 6','Brinco dourado',2999.90,'imagens/joias/joia_6.png',10);