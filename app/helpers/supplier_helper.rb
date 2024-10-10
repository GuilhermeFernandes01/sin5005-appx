module SupplierHelper
  def format_products(products)
    products.join(", ")
  end

  def format_supplier_code(supplier)
    "Supplier Code: #{supplier.code}"
  end
end
