When('preencho o campo {string} com {string}') do |field_name, field_value|
  fill_in field_name, with: field_value
end

Then('devo ter cadastrado o pedido no banco com meu nome {string} e com os produtos:') do |customer_name, table|
  orders =  Order.where(customer_name: customer_name)

  expect(orders.empty?).to be_equal(false)

  products = []
  table.hashes.each do |product|
    products << Product.find_by!(name: product[:name])
  end

  expect(table.hashes.map { |row| row[:name] }).to match_array(products.map(&:name))

  sorted_products = products.sort_by!(&:id)
  matching_order = orders.find do |order|
    sorted_products === order.products.order(:id)
  end

  expect(matching_order).not_to be_nil
end

Then('devo ver na página o pedido do {string} com os produtos:') do |customer_name, table|
  products = []
  table.hashes.each do |product|
    products << Product.find_by!(name: product[:name])
  end

  products_total = products.sum(&:price)

  order_regex = /Pedido #\d+ do #{Regexp.escape(customer_name)} - #{Regexp.escape(number_to_currency(products_total))}/

  expect(page).to have_css('div', text: order_regex)

  within(find('div', text: order_regex)) do
    products.each do |product|
      expect(page).to have_css('li', text: product.name)
    end
  end
end

Then('o carrinho deve estar vazio') do
  session = Capybara.current_session.driver.request.session

  expect(session[:cart]).to be_nil
end

Given('que possuo alguns pedidos cadastrados:') do |table|
  table.hashes.each do |row|
    order = Order.new(customer_name: row[:customer_name])

    row[:product_names].split(', ').map(&:strip).each do |product_name|
      order.products << Product.find_by!(name: product_name)
    end

    order.save!
  end
end

Given('estou na página de pedidos') do
  visit orders_path
end

When('clico no botão {string} do pedido do {string} com os seguintes itens:') do |button_name, customer_name, table|
  products = []
  table.hashes.each do |product|
    products << Product.find_by!(name: product[:name])
  end

  products_total = products.sum(&:price)

  order_regex = /Pedido #\d+ do #{Regexp.escape(customer_name)} - #{Regexp.escape(number_to_currency(products_total))}/

  within(find('div', text: order_regex)) do
    click_button button_name
  end
end

Then('não devo ver na página o pedido do {string} com os produtos:') do |customer_name, table|
  products = []
  table.hashes.each do |product|
    products << Product.find_by!(name: product[:name])
  end

  products_total = products.sum(&:price)

  order_regex = /Pedido #\d+ do #{Regexp.escape(customer_name)} - #{Regexp.escape(number_to_currency(products_total))}/

  expect(page).not_to have_css('div', text: order_regex)
end
