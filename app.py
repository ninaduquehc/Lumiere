from flask import Flask, render_template
from flask_mysqldb import MySQL

app = Flask(__name__)


# ========================================
# MYSQL
# ========================================

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'fatec'
app.config['MYSQL_DB'] = 'lumiere'

mysql = MySQL(app)


# ========================================
# HOME
# ========================================

@app.route("/")
def home():

    return render_template("home.html")


# ========================================
# CATÁLOGO
# ========================================

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

    return render_template(
        "catalogo.html",
        produtos=produtos
    )


# ========================================
# ITEM
# ========================================

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
        "imagem": dado[4]
    }

    return render_template(
        "item.html",
        produto=produto
    )


# ========================================
# LOGIN
# ========================================

@app.route("/login")
def login():

    return render_template("login.html")


# ========================================

if __name__ == "__main__":
    app.run(debug=True)