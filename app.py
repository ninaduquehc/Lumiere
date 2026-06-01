from werkzeug.security import (
    generate_password_hash,
    check_password_hash
)

from flask import (
    Flask,
    render_template,
    request,
    redirect,
    url_for,
    session
)

from flask_mysqldb import MySQL
from dotenv import load_dotenv
import os


# CARREGAR .env
load_dotenv(
    dotenv_path=os.path.join(
        os.path.dirname(__file__),
        ".env"
    )
)

app = Flask(__name__)

app.secret_key = "lumiere_secret"


# MYSQL CONFIG
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
# CATÁLOGO (COM BUSCA)
# =========================
@app.route("/catalogo")
def catalogo():

    busca = request.args.get("busca")

    cursor = mysql.connection.cursor()

    if busca:

        cursor.execute("""

            SELECT *
            FROM produtos
            WHERE nome LIKE %s
            OR categoria LIKE %s

        """, (
            f"%{busca}%",
            f"%{busca}%"
        ))

    else:

        cursor.execute("""
            SELECT *
            FROM produtos
        """)

    dados = cursor.fetchall()

    produtos = []

    for produto in dados:

        produtos.append({
            "id": produto[0],
            "nome": produto[1],
            "descricao": produto[2],
            "preco": produto[3],
            "imagem": produto[4],
            "categoria": produto[5]
        })

    cursor.close()

    return render_template(
        "catalogo.html",
        produtos=produtos,
        busca=busca
    )


# =========================
# ITEM
# =========================
@app.route("/item/<int:id_produto>")
def item(id_produto):

    cursor = mysql.connection.cursor()

    cursor.execute(
        "SELECT * FROM produtos WHERE id = %s",
        [id_produto]
    )

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
        WHERE categoria = %s
        AND id != %s
        ORDER BY RAND()
        LIMIT 5
    """, [produto["categoria"], id_produto])

    dados_relacionados = cursor.fetchall()

    produtos = []

    for relacionado in dados_relacionados:

        produtos.append({
            "id": relacionado[0],
            "nome": relacionado[1],
            "descricao": relacionado[2],
            "preco": relacionado[3],
            "imagem": relacionado[4]
        })

    cursor.close()

    return render_template(
        "item.html",
        produto=produto,
        produtos=produtos
    )


# =========================
# CADASTRO
# =========================
@app.route("/cadastro", methods=["GET", "POST"])
def cadastro():

    if request.method == "POST":

        nome = request.form["nome"]
        email = request.form["email"]

        senha = generate_password_hash(
            request.form["senha"]
        )

        cursor = mysql.connection.cursor()

        cursor.execute("""
            INSERT INTO usuarios
            (nome, email, senha)
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

        cursor.execute("""
            SELECT *
            FROM usuarios
            WHERE email = %s
        """, [email])

        usuario = cursor.fetchone()

        cursor.close()

        if usuario:

            senha_correta = check_password_hash(
                usuario[3],
                senha
            )

            if senha_correta:

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

    usuario = {
        "nome": session["nome"]
    }

    return render_template(
        "perfil.html",
        usuario=usuario
    )


# =========================
# LOGOUT
# =========================
@app.route("/logout")
def logout():

    session.clear()

    return redirect(url_for("login"))


# =========================
# CARRINHO - ADICIONAR
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
        WHERE usuario_id = %s
        AND produto_id = %s
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
            INSERT INTO carrinho
            (usuario_id, produto_id, quantidade)
            VALUES (%s,%s,1)
        """, (usuario_id, id_produto))

    mysql.connection.commit()
    cursor.close()

    return redirect(url_for("carrinho"))


# =========================
# AUMENTAR
# =========================
@app.route("/aumentar/<int:id_item>")
def aumentar(id_item):

    cursor = mysql.connection.cursor()

    cursor.execute("""
        UPDATE carrinho
        SET quantidade = quantidade + 1
        WHERE id=%s
    """, [id_item])

    mysql.connection.commit()
    cursor.close()

    return redirect(url_for("carrinho"))


# =========================
# DIMINUIR
# =========================
@app.route("/diminuir/<int:id_item>")
def diminuir(id_item):

    cursor = mysql.connection.cursor()

    cursor.execute("""
        UPDATE carrinho
        SET quantidade = GREATEST(1, quantidade-1)
        WHERE id=%s
    """, [id_item])

    mysql.connection.commit()
    cursor.close()

    return redirect(url_for("carrinho"))


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
        SELECT
            carrinho.id,
            produtos.nome,
            produtos.preco,
            produtos.imagem,
            carrinho.quantidade

        FROM carrinho
        JOIN produtos
        ON carrinho.produto_id = produtos.id

        WHERE carrinho.usuario_id = %s
    """, [usuario_id])

    dados = cursor.fetchall()

    produtos = []
    total = 0

    for item in dados:

        subtotal = float(item[2]) * item[4]
        total += subtotal

        produtos.append({
            "id": item[0],
            "nome": item[1],
            "preco": item[2],
            "imagem": item[3],
            "quantidade": item[4],
            "subtotal": subtotal
        })

    cursor.close()

    return render_template(
        "carrinho.html",
        produtos=produtos,
        total=total
    )


# =========================
# REMOVER DO CARRINHO
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
# RUN
# =========================
if __name__ == "__main__":
    app.run(debug=True)