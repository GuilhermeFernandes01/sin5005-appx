class Order < ApplicationRecord
  has_and_belongs_to_many :products

  validates :customer_name, presence: { message: "can't be empty" }

    def total_price
      products.sum(&:price)
    end
end
