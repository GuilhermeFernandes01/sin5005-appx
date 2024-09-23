require 'rails_helper'

RSpec.describe Cliente, type: :model do
  before do
    @cliente = Cliente.new(
      nome: 'Maria Antonieta',
      telefone: '(11) 9 5448-8088',
      email: 'maria_antonieta@email.com',
      endereco: 'Rua um, 2',
      observacoes: 'Cliente preferencial'
    )
  end

  it "é válido com todos os atributos preenchidos" do
    expect(@cliente).to be_valid
  end

  #########################################################
  it "não é válido sem nome" do
    @cliente.nome = nil
    expect(@cliente).not_to be_valid
  end

  it "não é válido com nome vazio" do
    @cliente.nome = ""
    expect(@cliente).not_to be_valid
  end
  
  #########################################################
  it "não é válido sem telefone" do
    @cliente.telefone = nil
    expect(@cliente).not_to be_valid
  end

  it "não é válido com telefone vazio" do
    @cliente.telefone = ""
    expect(@cliente).not_to be_valid
  end
  
  #########################################################
  it "é válido sem email" do
    @cliente.email = nil
    expect(@cliente).to be_valid
  end

  it "é válido com email correto" do
    @cliente.email = 'maria_antonieta@email.com'
    expect(@cliente).to be_valid
  end

  #########################################################

  it "é válido sem endereço" do
    @cliente.endereco = nil
    expect(@cliente).to be_valid
  end

  it "é válido sem observações como nil" do
    @cliente.observacoes = nil 
    expect(@cliente).to be_valid
  end
end
