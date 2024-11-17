require "cgi"
require "httparty"

class FreightCalculatorService
  def initialize(client_address)
    @client_address = client_address
    @store_coords = "-46.732944,-23.559499" # Coordenadas fixas da loja (EACH)
  end

  def calculate_freight
    # Obter os dados da rota (inclui geocodificação e cálculo da distância)
    response = get_route_data
      puts "Calculating freight for #{@address}"



    # Processar a resposta da API de rota
    if response.code == 200
      data = JSON.parse(response.body)
      routes = data["routes"]
      if routes.empty?
        nil
      else
        distance = routes.first["legs"].first["distance"]
        distance / 1000.0 # Converter para quilômetros
      end
    else
      raise "Erro ao obter dados de rota: #{response.code}"
    end
  rescue StandardError => e
    raise "Erro ao calcular o frete: #{e.message}"
  end

  private

  def get_route_data
    # Geocodificar o endereço do cliente
    client_coords = geocode_address(@client_address)

    # Construir a URL da API de roteamento
    url = "http://router.project-osrm.org/route/v1/driving/#{client_coords};#{@store_coords}"

    # Fazer a requisição HTTP para obter os dados da rota
    response = HTTParty.get(url, query: { overview: "false" })

    if response.code == 200
      response
    else
      raise RuntimeError, "Erro ao obter dados de rota: #{response.code}"
    end
  end

  def geocode_address(address)
    # URL para a API Nominatim (OpenStreetMap)
    url = "https://nominatim.openstreetmap.org/search?q=#{CGI.escape(address)}&format=json"

    # Fazer a requisição HTTP para geocodificação
    response = HTTParty.get(url)

    if response.code == 200
      result = JSON.parse(response.body).first
      if result
        lat = result["lat"]
        lon = result["lon"]
        "#{lon},#{lat}" # Retornar coordenadas no formato lon,lat
      else
        raise "Endereço não encontrado: #{address}"
      end
    else
      raise "Erro ao geocodificar o endereço: #{response.code}"
    end
  end
end
