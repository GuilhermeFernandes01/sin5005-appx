module SupplierHelper
  def format_products(products)
    products.join(", ")
  end

  def format_supplier_code(supplier)
    "Supplier Code: #{supplier.code}"
  end

  def format_phone(phone)
    phone.gsub(/\D/, '').gsub(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3')
  end
end
