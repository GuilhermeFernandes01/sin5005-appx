class Supplier < ApplicationRecord
  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d{14}\z/, message: "must have 14 digits" }
  validates :phone, format: { with: /\A\(\d{2}\) \d{4,5}-\d{4}\z/, message: "must follow the format (XX) XXXX-XXXX or (XX) XXXXX-XXXX" }, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }, allow_blank: true
  validates :segment, presence: true
  validates :code, presence: true, uniqueness: true

  before_validation :set_code, on: :create
  validate :products_are_present_and_unique

  private
  def set_code
    existing_supplier = Supplier.find_by(cnpj: self.cnpj)

    if existing_supplier
      self.code = existing_supplier.code
    else
      # Inicia uma transação para garantir a atomicidade
      Supplier.transaction do
        max_code = Supplier.maximum(:code) || "SUP000"
        # Extrai o número do código existente e incrementa
        new_number = max_code.gsub("SUP", "").to_i + 1
        self.code = "SUP#{new_number.to_s.rjust(3, '0')}"
      end
    end
  end

  private

  def products_are_present_and_unique
   if products.blank?
    errors.add(:products, "can't be blank")
    return
   end

   product_names = products.split(",").map(&:strip)
   if product_names.uniq.length < product_names.length
    errors.add(:products, "can't be duplicated products")
   end
 end
end
