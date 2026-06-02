from werkzeug.security import generate_password_hash, check_password_hash
from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
from dotenv import load_dotenv
import os

# =========================
# ENV
# =========================
load_dotenv(dotenv_path=os.path.join(os.path.dirname(__file__), ".env"))

app = Flask(__name__)
app.secret_key = "lumiere_secret"

# =========================
# MYSQL CONFIG
# =========================
app.config["MYSQL_HOST"] = os.getenv("MYSQL_HOST")
app.config["MYSQL_USER"] = os.getenv("MYSQL_USER")
app.config["MYSQL_PASSWORD"] = os.getenv("MYSQL_PASSWORD")
app.config["MYSQL_DB"] = os.getenv("MYSQL_DB")

mysql = MySQL(app)


# =========================
# HOME
# =========================
@app.route("/")
def home():
    return render_template("home.html")


# =========================
# CATÁLOGO
# =========================
@app.route("/catalogo")
def catalogo():

    busca = request.args.get("busca")
    categoria = request.args.get("categoria")

    min_preco = request.args.get("min")
    max_preco = request.args.get("max")

    filtrado = bool(
        busca or
        categoria or
        min_preco or
        max_preco
    )

    query = "SELECT * FROM produtos WHERE 1=1"
    params = []

    # BUSCA AMPLIADA
    if busca:

        query += """
            AND (
                nome LIKE %s
                OR descricao LIKE %s
                OR categoria LIKE %s
            )
        """

        termo = f"%{busca}%"

        params.extend([
            termo,
            termo,
            termo
        ])

    # FILTRO DE CATEGORIA
    if categoria:

        query += " AND categoria = %s"
        params.append(categoria)

    # FILTRO PREÇO MÍNIMO
    if min_preco:

        query += " AND preco >= %s"
        params.append(min_preco)

    # FILTRO PREÇO MÁXIMO
    if max_preco:

        query += " AND preco <= %s"
        params.append(max_preco)

    cursor = mysql.connection.cursor()

    cursor.execute(query, params)

    dados = cursor.fetchall()

    cursor.close()

    produtos = [
        {
            "id": p[0],
            "nome": p[1],
            "descricao": p[2],
            "preco": p[3],
            "imagem": p[4],
            "categoria": p[5]
        }
        for p in dados
    ]

    categorias = {
        "bolsas": [],
        "calcas": [],
        "camisas": [],
        "casacos": [],
        "sapatos": [],
        "chapeus": [],
        "pijamas": [],
        "cintos": [],
        "maquiagens": [],
        "joias": []
    }

    for p in produtos:

        cat = p["categoria"]

        if cat in categorias:
            categorias[cat].append(p)

    nomes_categorias = {
        "bolsas": "Bolsas",
        "calcas": "Calças",
        "camisas": "Camisas",
        "casacos": "Casacos",
        "sapatos": "Sapatos",
        "chapeus": "Chapéus",
        "pijamas": "Pijamas",
        "cintos": "Cintos",
        "maquiagens": "Maquiagens",
        "joias": "Joias"
    }

    return render_template(
        "catalogo.html",
        categorias=categorias,
        nomes_categorias=nomes_categorias,
        busca=busca,
        categoria=categoria,
        min=min_preco,
        max=max_preco,
        filtrado=filtrado
    )

# =========================
# ITEM
# =========================
@app.route("/item/<int:id_produto>")
def item(id_produto):

    cursor = mysql.connection.cursor()

    cursor.execute("SELECT * FROM produtos WHERE id = %s", [id_produto])
    dado = cursor.fetchone()

    produto = {
        "id": dado[0],
        "nome": dado[1],
        "descricao": dado[2],
        "preco": dado[3],
        "imagem": dado[4],
        "categoria": dado[5]
    }

    cursor.execute("""
        SELECT *
        FROM produtos
        WHERE categoria = %s AND id != %s
        ORDER BY RAND()
        LIMIT 5
    """, [produto["categoria"], id_produto])

    relacionados = cursor.fetchall()
    cursor.close()

    produtos_relacionados = [
        {
            "id": r[0],
            "nome": r[1],
            "descricao": r[2],
            "preco": r[3],
            "imagem": r[4]
        }
        for r in relacionados
    ]

    return render_template(
        "item.html",
        produto=produto,
        produtos=produtos_relacionados
    )


# =========================
# CADASTRO
# =========================
@app.route("/cadastro", methods=["GET", "POST"])
def cadastro():

    if request.method == "POST":

        nome = request.form["nome"]
        email = request.form["email"]
        senha = generate_password_hash(request.form["senha"])

        cursor = mysql.connection.cursor()

        cursor.execute("""
            INSERT INTO usuarios (nome, email, senha)
            VALUES (%s,%s,%s)
        """, (nome, email, senha))

        mysql.connection.commit()
        cursor.close()

        return redirect(url_for("login"))

    return render_template("cadastro.html")


# =========================
# LOGIN
# =========================
@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        email = request.form["email"]
        senha = request.form["senha"]

        cursor = mysql.connection.cursor()

        cursor.execute("SELECT * FROM usuarios WHERE email = %s", [email])
        usuario = cursor.fetchone()
        cursor.close()

        if usuario and check_password_hash(usuario[3], senha):

            session["usuario_id"] = usuario[0]
            session["nome"] = usuario[1]

            return redirect(url_for("perfil"))

    return render_template("login.html")


# =========================
# PERFIL
# =========================
@app.route("/perfil")
def perfil():

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    return render_template("perfil.html", usuario={"nome": session["nome"]})


# =========================
# LOGOUT
# =========================
@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))


# =========================
# CARRINHO
# =========================
@app.route("/carrinho")
def carrinho():

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    usuario_id = session["usuario_id"]

    cursor = mysql.connection.cursor()

    cursor.execute("""
        SELECT carrinho.id, produtos.descricao, produtos.preco,
               produtos.imagem, carrinho.quantidade
        FROM carrinho
        JOIN produtos ON carrinho.produto_id = produtos.id
        WHERE carrinho.usuario_id = %s
    """, [usuario_id])

    dados = cursor.fetchall()
    cursor.close()

    produtos = []
    total = 0

    for item in dados:
        subtotal = float(item[2]) * item[4]
        total += subtotal

        produtos.append({
        "id": item[0],
        "descricao": item[1],
        "preco": item[2],
        "imagem": item[3],
        "quantidade": item[4],
        "subtotal": subtotal
        })

    return render_template("carrinho.html", produtos=produtos, total=total)


# =========================
# ADICIONAR CARRINHO
# =========================
@app.route("/adicionar-carrinho/<int:id_produto>", methods=["POST"])
def adicionar_carrinho(id_produto):

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    usuario_id = session["usuario_id"]
    cursor = mysql.connection.cursor()

    cursor.execute("""
        SELECT id, quantidade
        FROM carrinho
        WHERE usuario_id = %s AND produto_id = %s
    """, (usuario_id, id_produto))

    item = cursor.fetchone()

    if item:
        cursor.execute("""
            UPDATE carrinho
            SET quantidade = quantidade + 1
            WHERE id = %s
        """, (item[0],))
    else:
        cursor.execute("""
            INSERT INTO carrinho (usuario_id, produto_id, quantidade)
            VALUES (%s,%s,1)
        """, (usuario_id, id_produto))

    mysql.connection.commit()
    cursor.close()

    return redirect(url_for("carrinho"))


# =========================
# DIMINUIR
# =========================
@app.route("/diminuir/<int:id_item>")
def diminuir(id_item):

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    cursor = mysql.connection.cursor()

    cursor.execute("""
        SELECT quantidade FROM carrinho WHERE id = %s
    """, [id_item])

    item = cursor.fetchone()

    if item:
        if item[0] > 1:
            cursor.execute("""
                UPDATE carrinho
                SET quantidade = quantidade - 1
                WHERE id = %s
            """, [id_item])
        else:
            cursor.execute("""
                DELETE FROM carrinho WHERE id = %s
            """, [id_item])

        mysql.connection.commit()

    cursor.close()
    return redirect(url_for("carrinho"))


# =========================
# AUMENTAR
# =========================
@app.route("/aumentar/<int:id_item>")
def aumentar(id_item):

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    cursor = mysql.connection.cursor()

    cursor.execute("""
        UPDATE carrinho
        SET quantidade = quantidade + 1
        WHERE id = %s
    """, [id_item])

    mysql.connection.commit()
    cursor.close()

    return redirect(url_for("carrinho"))

# =========================
# REMOVER CARRINHO 
# =========================
@app.route("/remover-carrinho/<int:id_item>")
def remover_carrinho(id_item):

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    cursor = mysql.connection.cursor()

    cursor.execute("""
        DELETE FROM carrinho
        WHERE id = %s
    """, [id_item])

    mysql.connection.commit()
    cursor.close()

    return redirect(url_for("carrinho"))

# =========================
# FINALIZAR COMPRA
# =========================
@app.route("/finalizar-compra", methods=["POST"])
def finalizar_compra():

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    usuario_id = session["usuario_id"]
    cursor = mysql.connection.cursor()

    # 1. buscar itens do carrinho
    cursor.execute("""
        SELECT produtos.id, carrinho.quantidade, produtos.preco
        FROM carrinho
        JOIN produtos ON carrinho.produto_id = produtos.id
        WHERE carrinho.usuario_id = %s
    """, [usuario_id])

    itens = cursor.fetchall()

    # se carrinho vazio
    if not itens:
        cursor.close()
        return redirect(url_for("carrinho"))

    # 2. calcular total
    total = sum(quantidade * float(preco) for _, quantidade, preco in itens)

    # 3. criar pedido
    cursor.execute("""
        INSERT INTO pedidos (usuario_id, total)
        VALUES (%s, %s)
    """, (usuario_id, total))

    pedido_id = cursor.lastrowid

    # 4. inserir itens do pedido
    for produto_id, quantidade, preco in itens:
        cursor.execute("""
            INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco)
            VALUES (%s, %s, %s, %s)
        """, (pedido_id, produto_id, quantidade, preco))

    # 5. limpar carrinho
    cursor.execute("""
        DELETE FROM carrinho
        WHERE usuario_id = %s
    """, [usuario_id])

    mysql.connection.commit()
    cursor.close()

    return redirect(url_for("meus_pedidos"))

# =========================
# MEUS PEDIDOS
# =========================
@app.route("/meus-pedidos")
def meus_pedidos():

    if "usuario_id" not in session:
        return redirect(url_for("login"))

    cursor = mysql.connection.cursor()

    # pedidos do usuário
    cursor.execute("""
        SELECT id, total, data_pedido
        FROM pedidos
        WHERE usuario_id = %s
        ORDER BY id DESC
    """, (session["usuario_id"],))

    dados_pedidos = cursor.fetchall()

    pedidos = []

    contador = 1

    for pedido in dados_pedidos:

        pedido_id = pedido[0]

        # buscar itens daquele pedido
        cursor.execute("""
            SELECT
                produtos.descricao,
                produtos.imagem,
                itens_pedido.quantidade,
                itens_pedido.preco
            FROM itens_pedido
            JOIN produtos
            ON itens_pedido.produto_id = produtos.id
            WHERE itens_pedido.pedido_id = %s
        """, [pedido_id])

        itens = cursor.fetchall()

        produtos = []

        for item in itens:

            produtos.append({
                "descricao": item[0],
                "imagem": item[1],
                "quantidade": item[2],
                "preco": item[3]
            })

        pedidos.append({
            "numero": contador,
            "id": pedido_id,
            "total": pedido[1],
            "data": pedido[2],
            "produtos": produtos
        })

        contador += 1

    cursor.close()

    return render_template(
        "meus_pedidos.html",
        pedidos=pedidos
    )

# =========================
# RUN
# =========================
if __name__ == "__main__":
    app.run(debug=True)