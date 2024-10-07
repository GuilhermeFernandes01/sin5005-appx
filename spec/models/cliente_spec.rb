require 'rails_helper'

RSpec.describe Cliente, type: :model do
  before do
    @cliente = Cliente.new(
      nome: "Maria Antonieta",
      telefone: "011954488088",
      email: "maria_antonieta@email.com",
      endereco: "Rua um, 2",
      data_nascimento: "2024-10-05",
      observacoes: "Cliente preferencial"
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

  #########################################################
  context 'validações de data de nascimento' do
    it "é válido sem data de nascimento" do
      @cliente.data_nascimento = nil
      expect(@cliente).to be_valid  
    end

    it "não é válido com data de nascimento futura" do
      @cliente.data_nascimento = Date.tomorrow
      expect(@cliente).not_to be_valid
      expect(@cliente.errors[:data_nascimento]).to include("não pode ser uma data futura")
    end

    it "é válido com data de nascimento válida" do
      @cliente.data_nascimento = Date.new(2000, 10, 10)
      expect(@cliente).to be_valid
    end

    it "verifica se o cliente tem aniversário no mês atual" do
      @cliente.data_nascimento = Date.new(Date.today.year, Date.today.month, 10)
      expect(@cliente.data_nascimento.month).to eq(Date.today.month)
    end
  end
end
