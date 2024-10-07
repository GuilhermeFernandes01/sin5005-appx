class Cliente < ApplicationRecord
    validates :nome, presence: true

    validates :telefone, presence: true,
    numericality: { only_integer: true, message: "deve conter apenas números" }

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }

    validate :data_nascimento_valida

  private

  def data_nascimento_valida
    return if data_nascimento.nil?  # Ignorar se a data de nascimento não foi fornecida
    errors.add(:data_nascimento, "não pode ser uma data futura") if data_nascimento > Date.today
  end
  
end
