class FreightCalculatorService
  def initialize(client_address)
    @client_address = client_address
    @store_coords = "-46.500493,-23.482264" # Coordenadas fixas da loja (EACH)
  end

  # -23.482263954867012, -46.500492719666696

  def calculate_freight
    response = get_route_data

    if response.code == 200
      data = JSON.parse(response.body)
      routes = data["routes"]
      if routes.empty?
        nil
      else
        distance = routes.first["legs"].first["distance"]
        distance_in_km = distance / 1000.0 # Converte de metros para quilômetros
        calculate_freight_value(distance_in_km) # Chama o método que calcula o valor do frete
      end
    else
      raise "Erro ao obter dados de rota: #{response.code}"
    end
  rescue StandardError => e
    raise "Erro ao calcular o frete: #{e.message}"
  end

  private

  def calculate_freight_value(distance_in_km)
    rate_per_km = 2.0
    (distance_in_km * rate_per_km).round(2)*0.8
  end

  def get_route_data
    client_coords = geocode_address(@client_address)
    url = "http://router.project-osrm.org/route/v1/driving/#{client_coords};#{@store_coords}"
    headers = { "User-Agent" => "MinhaAppFrete/1.0 (contato@minhaapp.com)" }  # Adicionando User-Agent

    response = HTTParty.get(url, headers: headers)

    if response.code == 200
      response
    else
      raise RuntimeError, "Erro ao obter dados de rota: #{response.code}"
    end
  end

  def geocode_address(address)
    url = "https://nominatim.openstreetmap.org/search?q=#{CGI.escape(address)}&format=json"
    headers = { "User-Agent" => "MinhaAppFrete/1.0 (contato@minhaapp.com)" }  # Adicionando User-Agent

    response = HTTParty.get(url, headers: headers)

    if response.code == 200
      result = JSON.parse(response.body).first
      if result
        lat = result["lat"]
        lon = result["lon"]
        "#{lon},#{lat}"
      else
        raise "Endereço não encontrado: #{address}"
      end
    else
      raise "Erro ao geocodificar o endereço: #{response.code}"
    end
  end
end
