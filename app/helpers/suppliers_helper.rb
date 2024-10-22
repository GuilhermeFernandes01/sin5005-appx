module SuppliersHelper
  def format_products(products)
    products.join(", ")
  end

  def format_supplier_code(supplier)
    "Supplier Code: #{supplier.code}"
  end

  def format_phone(phone)
    cleaned = phone.gsub(/\D/, "")
    if cleaned.length == 10
      "(#{cleaned[0..1]}) #{cleaned[2..5]}-#{cleaned[6..9]}"
    elsif cleaned.length == 11
      "(#{cleaned[0..1]}) #{cleaned[2..6]}-#{cleaned[7..10]}"
    else
      phone
    end
  end

  def format_supplier_name(supplier)
    "#{supplier.name} (#{supplier.code})"
   end
end
