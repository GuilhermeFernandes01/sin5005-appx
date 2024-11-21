# language: pt

# Iteração 5
Funcionalidade: Botão "Novo produto" na página principal de produtos

Como um funcionário da pizzaria
eu quero um botão "Novo produto" na página principal de produtos
de forma que seja possível acessar a página de inclusão de produtos a partir da página principal de produtos

Cenário: Acessar tela de novo produto através da tela principal de produtos
    Dado que estou na página principal de produtos
    Então pressionar o botão "Novo produto"
    Então devo acessar a página para inclusão de um produto
