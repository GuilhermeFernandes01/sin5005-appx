require 'rails_helper'
require 'webmock/rspec'

RSpec.describe FreightCalculatorService do
  describe '#calculate_freight' do
    let(:client_address) { 'Rua Alguma Coisa, 120' }
    let(:service) { described_class.new(client_address) }
    let(:store_coords) { '-46.732944,-23.559499' }
    let(:geocode_response_body) do
      [
        {
          "lat" => "-23.550520",
          "lon" => "-46.633308"
        }
      ].to_json
    end
    let(:route_response_body) do
      {
        "routes" => [
          {
            "legs" => [
              { "distance" => 15000 } # 15 km
            ]
          }
        ]
      }.to_json
    end

    before do
      # Mock da requisição para a API Nominatim (geocodificação)
      stub_request(:get, %r{https://nominatim.openstreetmap.org/search.*})
        .to_return(status: 200, body: geocode_response_body, headers: { 'Content-Type' => 'application/json' })

      # Mock da requisição para a API OSRM (cálculo de rota)
      stub_request(:get, %r{http://router.project-osrm.org/route/v1/driving.*})
        .to_return(status: 200, body: route_response_body, headers: { 'Content-Type' => 'application/json' })
    end

    it 'retorna o valor do frete baseado na distância' do
      freight_value = service.calculate_freight
      expect(freight_value).to eq(24.0)
    end

    context 'quando a API de geocodificação retorna um erro' do
      before do
        stub_request(:get, %r{https://nominatim.openstreetmap.org/search.*})
          .to_return(status: 404)
      end

      it 'levanta um erro apropriado' do
        expect { service.calculate_freight }.to raise_error(RuntimeError, /Erro ao geocodificar o endereço/)
      end
    end

    context 'quando a API de rota retorna um erro' do
      before do
        stub_request(:get, %r{http://router.project-osrm.org/route/v1/driving.*})
          .to_return(status: 500)
      end

      it 'levanta um erro apropriado' do
        expect { service.calculate_freight }.to raise_error(RuntimeError, /Erro ao obter dados de rota/)
      end
    end

    context 'quando nenhuma rota é encontrada' do
      let(:route_response_body) do
        {
          "routes" => []
        }.to_json
      end

      it 'retorna nil' do
        freight_value = service.calculate_freight
        expect(freight_value).to be_nil
      end
    end

    context 'quando a geocodificação não encontra o endereço' do
      before do
        # Mock para retornar uma resposta sem resultado
        stub_request(:get, %r{https://nominatim.openstreetmap.org/search.*})
          .to_return(status: 200, body: "[]", headers: { 'Content-Type' => 'application/json' })
      end

      it 'levanta um erro apropriado' do
        expect { service.calculate_freight }.to raise_error(RuntimeError, /Endereço não encontrado: Rua Alguma Coisa, 120/)
      end
    end
  end
end
