# LUMIÈRE
Site de Loja de Roupas

Uma aplicação web desenvolvida em Python + Flask para gerenciamento e comercialização de produtos de moda feminina, oferecendo catálogo dinâmico, autenticação de usuários, carrinho de compras e histórico de pedidos.

---

## Descrição do Sistema

O Lumière é um sistema web de e-commerce criado para simular um ambiente real de vendas online, permitindo que usuários naveguem por diferentes categorias de produtos, realizem cadastro, efetuem compras e acompanhem seus pedidos.

O projeto foi desenvolvido com foco na aplicação prática dos conceitos estudados em disciplinas de desenvolvimento web, banco de dados, computação em nuvem e conteinerização, integrando tecnologias modernas utilizadas no mercado.

A aplicação utiliza Flask como framework principal, MySQL para persistência de dados, Docker para empacotamento da aplicação e AWS EC2 para hospedagem em nuvem, proporcionando um ambiente completo de desenvolvimento e implantação.

---

## Tecnologias Utilizadas

### Backend

* Python 3.12
* Flask
* Flask-MySQLdb
* Werkzeug

### Banco de Dados

* MySQL 8.4

### Infraestrutura

* Docker
* Docker Compose
* AWS EC2
* Docker Hub

### Frontend

* HTML5
* CSS3
* Jinja2

### Controle de Versão

* Git
* GitHub

---

## Funcionalidades Principais

### Usuários

* Cadastro de usuários
* Login
* Logout
* Criptografia de senhas

### Catálogo

* Listagem dinâmica de produtos
* Organização por categorias
* Página individual de produto
* Busca de produtos

### Carrinho

* Adicionar produtos
* Remover produtos
* Alterar quantidade

### Pedidos

* Finalização de compra
* Histórico de pedidos

### Administração do Banco

* Banco MySQL
* Script de criação automática das tabelas
* Popularização automática com produtos e categorias

---

# Prints das Telas

> Inserir imagens da aplicação nesta seção.

## Página Inicial

```md
![Home](print_home_1.png)
![Home](print_home_2.png)
```

## Catálogo + Carrinho

```md
![Catálogo](print_catalogo_1.png)
![Catálogo](print_catalogo_2.png)
![Catálogo](print_catalogo_busca.png)
![Carrinho](print_carrinho.png)
```

## Ítem

```md
![Item](print_item_1.png)
![Item](print_item_1.png)
```

## Login + Cadastro

```md
![Login](print_login.png)
![Cadastro](print_cadastro.png)
```

## Meus pedidos + Perfil

```md
![Meus_pedidos](print_meus_pedidos.png)
![Perfil](print_perfil.png)

---

# Estrutura de Pastas
```
LUMIERE/
├── 📁 static
│   ├── 📁 css
│   │   └── 🎨 style.css
│   └── 📁 imagens
│       ├── 📁 banner
│       │   ├── 🖼️ banner_bolsa.jpeg
│       │   ├── 🖼️ banner_conjunto.jpeg
│       │   └── 🖼️ banner_sapato.jpeg
│       ├── 📁 bolsas
│       │   ├── 🖼️ bolsa_1.png
│       │   ├── 🖼️ bolsa_2.png
│       │   ├── 🖼️ bolsa_3.png
│       │   ├── 🖼️ bolsa_4.png
│       │   ├── 🖼️ bolsa_5.png
│       │   └── 🖼️ bolsa_6.png
│       ├── 📁 calcas
│       │   ├── 🖼️ calca_1.png
│       │   ├── 🖼️ calca_2.png
│       │   ├── 🖼️ calca_3.png
│       │   ├── 🖼️ calca_4.png
│       │   ├── 🖼️ calca_5.png
│       │   └── 🖼️ calca_6.png
│       ├── 📁 camisas
│       │   ├── 🖼️ camisa_1.png
│       │   ├── 🖼️ camisa_2.png
│       │   ├── 🖼️ camisa_3.png
│       │   ├── 🖼️ camisa_4.png
│       │   ├── 🖼️ camisa_5.png
│       │   └── 🖼️ camisa_6.png
│       ├── 📁 casacos
│       │   ├── 🖼️ casaco_1.png
│       │   ├── 🖼️ casaco_2.png
│       │   ├── 🖼️ casaco_3.png
│       │   ├── 🖼️ casaco_4.png
│       │   ├── 🖼️ casaco_5.png
│       │   └── 🖼️ casaco_6.png
│       ├── 📁 chapeus
│       │   ├── 🖼️ chapeu_1.png
│       │   ├── 🖼️ chapeu_2.png
│       │   ├── 🖼️ chapeu_3.png
│       │   ├── 🖼️ chapeu_4.png
│       │   ├── 🖼️ chapeu_5.png
│       │   └── 🖼️ chapeu_6.png
│       ├── 📁 cintos
│       │   ├── 🖼️ cinto_1.png
│       │   ├── 🖼️ cinto_2.png
│       │   ├── 🖼️ cinto_3.png
│       │   ├── 🖼️ cinto_4.png
│       │   ├── 🖼️ cinto_5.png
│       │   └── 🖼️ cinto_6.png
│       ├── 📁 home
│       │   ├── 🖼️ bolsa.png
│       │   ├── 🖼️ calca.png
│       │   ├── 🖼️ camisa.png
│       │   ├── 🖼️ casaco.png
│       │   ├── 🖼️ chapeu.png
│       │   ├── 🖼️ cinto.png
│       │   ├── 🖼️ joias.png
│       │   ├── 🖼️ maquiagem.png
│       │   ├── 🖼️ pijama.png
│       │   └── 🖼️ salto.png
│       ├── 📁 joias
│       │   ├── 🖼️ joia_1.png
│       │   ├── 🖼️ joia_2.png
│       │   ├── 🖼️ joia_3.png
│       │   ├── 🖼️ joia_4.png
│       │   ├── 🖼️ joia_5.png
│       │   └── 🖼️ joia_6.png
│       ├── 📁 maquiagens
│       │   ├── 🖼️ maquiagem_1.png
│       │   ├── 🖼️ maquiagem_2.png
│       │   ├── 🖼️ maquiagem_3.png
│       │   ├── 🖼️ maquiagem_4.png
│       │   ├── 🖼️ maquiagem_5.png
│       │   └── 🖼️ maquiagem_6.png
│       ├── 📁 pijamas
│       │   ├── 🖼️ pijama_1.png
│       │   ├── 🖼️ pijama_2.png
│       │   ├── 🖼️ pijama_3.png
│       │   ├── 🖼️ pijama_4.png
│       │   ├── 🖼️ pijama_5.png
│       │   └── 🖼️ pijama_6.png
│       ├── 📁 prints
│       │   ├── 🖼️ print_cadastro.png
│       │   ├── 🖼️ print_carrinho.png
│       │   ├── 🖼️ print_catalogo_1.png
│       │   ├── 🖼️ print_catalogo_2.png
│       │   ├── 🖼️ print_catalogo_busca.png
│       │   ├── 🖼️ print_home_1.png
│       │   ├── 🖼️ print_home_2.png
│       │   ├── 🖼️ print_item_1.png
│       │   ├── 🖼️ print_item_2.png
│       │   ├── 🖼️ print_login.png
│       │   ├── 🖼️ print_meus_pedidos.png
│       │   └── 🖼️ print_perfil.png
│       ├── 📁 sapatos
│       │   ├── 🖼️ sapato_1.png
│       │   ├── 🖼️ sapato_2.png
│       │   ├── 🖼️ sapato_3.png
│       │   ├── 🖼️ sapato_4.png
│       │   ├── 🖼️ sapato_5.png
│       │   └── 🖼️ sapato_6.png
│       ├── 🖼️ bem-vindo.png
│       └── 🖼️ logo_lumiere.png
├── 📁 templates
│   ├── 🌐 base.html
│   ├── 🌐 cadastro.html
│   ├── 🌐 carrinho.html
│   ├── 🌐 catalogo.html
│   ├── 🌐 home.html
│   ├── 🌐 item.html
│   ├── 🌐 login.html
│   ├── 🌐 meus_pedidos.html
│   └── 🌐 perfil.html
├── ⚙️ .gitignore
├── 📝 README.md
└── 🐍 app.py
```

---

# Instalação do Projeto

## 1. Clonar o Repositório

```bash
git clone https://github.com/SEU-USUARIO/Lumiere.git

cd Lumiere
```

---

## 2. Criar o Arquivo .env

Criar um arquivo chamado `.env` na raiz do projeto.

Exemplo:

```env
MYSQL_ROOT_PASSWORD=admin_lumiere

MYSQL_DB=lumiere

MYSQL_USER=lumiere_user

MYSQL_PASSWORD=lumiere123

SECRET_KEY=sua_chave_secreta
```

---

# Executando Localmente (Sem Docker)

Instalar dependências:

```bash
pip install -r requirements.txt
```

Executar aplicação:

```bash
python app.py
```

Acessar:

```text
http://localhost:5000
```

---

# Executando com Docker

## Construir os containers

```bash
sudo docker compose up --build -d
```

---

## Verificar containers

```bash
sudo docker ps
```

Saída esperada:

```text
lumiere_app
lumiere_mysql
```

---

## Verificar logs

Aplicação:

```bash
sudo docker logs lumiere_app
```

Banco:

```bash
sudo docker logs lumiere_mysql
```

---

## Parar containers

```bash
sudo docker compose down
```

---

# Implantação na AWS EC2

### Instalar Docker

```bash
sudo apt update

sudo apt install docker.io -y
```

---

### Instalar Docker Compose Plugin

```bash
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}

mkdir -p $DOCKER_CONFIG/cli-plugins

curl -SL \
https://github.com/docker/compose/releases/download/v2.39.1/docker-compose-linux-x86_64 \
-o $DOCKER_CONFIG/cli-plugins/docker-compose

chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
```

---

### Clonar Projeto

```bash
git clone https://github.com/SEU-USUARIO/Lumiere.git

cd Lumiere
```

---

### Criar .env

```bash
nano .env
```

Inserir as variáveis do projeto.

---

### Subir Containers

```bash
sudo docker compose up --build -d
```

---

### Verificar Containers

```bash
sudo docker ps
```

---

# Como Acessar o Sistema

## Local

```text
http://localhost:5000
```

## AWS EC2

```text
http://IP_PUBLICO_DA_INSTANCIA:5000
```

Exemplo:

```text
http://52.xxx.xxx.xxx:5000
```

---

# Banco de Dados

O banco de dados é criado automaticamente através do arquivo:

```text
init.sql
```

Ao iniciar o container MySQL pela primeira vez, são criadas:

* tabela usuarios
* tabela categorias
* tabela produtos
* tabela pedidos
* tabela itens_pedido
* tabela carrinho

Além disso, categorias e produtos são inseridos automaticamente no banco.

---

# Autora

**Marina Cavalcanti**

Projeto desenvolvido para a disciplina de Desenvolvimento Web / Banco de Dados, aplicando conceitos de:

* Flask
* MySQL
* Docker
* Docker Compose
* AWS EC2
* Docker Hub
* Modelagem Relacional