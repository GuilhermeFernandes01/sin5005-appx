class Supplier < ApplicationRecord
  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d{14}\z/, message: "must have 14 digits" }
  validates :phone, format: { with: /\A\(\d{2}\) \d{4,5}-\d{4}\z/, message: "must follow the format (XX) XXXX-XXXX or (XX) XXXXX-XXXX" }, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }, allow_blank: true
  validates :segment, presence: true
  #validates :code, presence: true, uniqueness: true unless Rails.env.test?
  validates :code, presence: true, uniqueness: true

  before_validation :set_code, on: :create
  validate :products_are_present_and_unique

  private

  def set_code
    max_code = Supplier.maximum(:code) || "0"
    new_code = max_code.to_i + 1
    self.code = "SUP#{new_code.to_s.rjust(3, '0')}"
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
