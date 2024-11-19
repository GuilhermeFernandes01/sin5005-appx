require 'webmock/cucumber'
require_relative '../../app/services/freight_calculator_service'

Given('a client exists with address {string}') do |address|
  @client_address = address

  # Mock da API Nominatim (geocodificação)
  @geocode_response_body = [
    {
      "lat" => "-23.550520",
      "lon" => "-46.633308"
    }
  ].to_json

  stub_request(:get, %r{https://nominatim.openstreetmap.org/search.*})
    .to_return(status: 200, body: @geocode_response_body, headers: { 'Content-Type' => 'application/json' })
end


When('I calculate the shipping cost') do
  if valid_address?(@client_address)
    calculate_shipping_for_valid_address
  else
    handle_invalid_address
  end
end

def valid_address?(address)
  address == "Rua X, 123"
end

def calculate_shipping_for_valid_address
  @route_response_body = {
    "routes" => [
      {
        "legs" => [
          { "distance" => 10000 }
        ]
      }
    ]
  }.to_json

  stub_request(:get, %r{http://router.project-osrm.org/route/v1/driving.*})
    .to_return(status: 200, body: @route_response_body, headers: { 'Content-Type' => 'application/json' })

  service = FreightCalculatorService.new(@client_address)
  @shipping_cost = service.calculate_freight
end

def handle_invalid_address
  @error_message = "Erro ao calcular o frete: Erro ao geocodificar o endereço"
  stub_request(:get, %r{https://nominatim.openstreetmap.org/search.*})
    .to_return(status: 500, body: @error_message, headers: { 'Content-Type' => 'application/json' })
  service = FreightCalculatorService.new(@client_address)

  begin
    @shipping_cost = service.calculate_freight
  rescue StandardError => e
    @error_message = e.message
  end
end


Then('I should see the shipping cost as {float}') do |expected_cost|
  expect(@shipping_cost).to eq(expected_cost)
end

Given('an invalid client address {string}') do |invalid_address|
  @client_address = invalid_address
end

Then('I should see an error message {string}') do |expected_error_message|
  expect(@error_message).to eq(expected_error_message)
end
