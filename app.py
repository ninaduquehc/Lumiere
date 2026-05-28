from flask import Flask, render_template
from flask_mysqldb import MySQL
from dotenv import load_dotenv
import os

load_dotenv(dotenv_path=os.path.join(os.path.dirname(__file__), ".env"))

app = Flask(__name__)

# MYSQL
app.config["MYSQL_HOST"] = os.getenv("MYSQL_HOST")
app.config["MYSQL_USER"] = os.getenv("MYSQL_USER")
app.config["MYSQL_PASSWORD"] = os.getenv("MYSQL_PASSWORD")
app.config["MYSQL_DB"] = os.getenv("MYSQL_DB")

mysql = MySQL(app)

# HOME
@app.route("/")
def home():
    return render_template("home.html")

# CATÁLOGO
@app.route("/catalogo")
def catalogo():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM produtos")
    dados = cursor.fetchall()

    produtos = []

    for produto in dados:
        produtos.append({
            "id": produto[0],
            "nome": produto[1],
            "descricao": produto[2],
            "preco": produto[3],
            "imagem": produto[4]
        })

    cursor.close()

    return render_template("catalogo.html", produtos=produtos)

# ITEM
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
        SELECT * FROM produtos
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

    return render_template("item.html", produto=produto, produtos=produtos)

# LOGIN
@app.route("/login")
def login():
    return render_template("login.html")

if __name__ == "__main__":
    app.run(debug=True)