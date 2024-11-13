# language: pt

# Iteração 5
Funcionalidade: Cardápio de Produtos 
    Como um cliente ou funcionário da pizzaria
    eu quero consultar o cardápio
    de forma que seja possível verificar os produtos disponíveis para consumo

    Cenário: Visualizar todos as categorias de produtos cadastrados no cardápio
    Dado que temos alguns produtos cadastrados:
        | name               | price   | category  | 
        | Pizza de Pepperoni | 40.99   | Pizza     | 
        | Água               | 1.99    | Bebidas   | 
    Dado que eu acesso a página de cardápio
    Então devo ver essas categorias "Pizza" e "Bebidas" como opções

    Dado que cliquei no botão "Pizza" 
    Então devo Visualizar somente produtos da categoria "Pizza"

    