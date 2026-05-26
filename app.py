from flask import Flask, render_template

app = Flask(__name__)


# ========================================
# PRODUTOS
# ========================================

produtos = {

    1: {
        "id": 1,
        "nome": "BOLSA DO TIPO X",
        "descricao": "NOME Y DESCRIÇÃO W",
        "preco": "R$ 599,90",
        "imagem": "imagens/bolsas/bolsa_1.png"
    },

    2: {
        "id": 2,
        "nome": "BOLSA PREMIUM",
        "descricao": "MODELO ELEGANCE",
        "preco": "R$ 799,90",
        "imagem": "imagens/bolsas/bolsa_2.png"
    },

    3: {
        "id": 3,
        "nome": "COLAR LUXURY",
        "descricao": "ACABAMENTO DOURADO",
        "preco": "R$ 299,90",
        "imagem": "imagens/joias/colar_1.png"
    },

    4: {
        "id": 4,
        "nome": "CINTO CLASSIC",
        "descricao": "COURO LEGÍTIMO",
        "preco": "R$ 199,90",
        "imagem": "imagens/acessorios/cinto_1.png"
    }

}


# ========================================
# HOME
# ========================================

@app.route("/")
def home():

    return render_template(
        "home.html"
    )


# ========================================
# CATÁLOGO
# ========================================

@app.route("/catalogo")
def catalogo():

    return render_template(
        "catalogo.html",
        produtos=produtos.values()
    )

# ========================================
# LOGIN
# ========================================

@app.route("/login")
def login():

    return render_template("login.html")


# ========================================
# ITEM
# ========================================

@app.route("/item/<int:id_produto>")
def item(id_produto):

    produto = produtos.get(id_produto)

    return render_template(
        "item.html",
        produto=produto,
        produtos=produtos.values()
    )


# ========================================

if __name__ == "__main__":
    app.run(debug=True)