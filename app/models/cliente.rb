class Cliente < ApplicationRecord
    validates :nome, presence: true

    validates :telefone, presence: true,
    numericality: { only_integer: true, message: "deve conter apenas números" }

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
end
