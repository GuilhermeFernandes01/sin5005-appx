Feature: Calculating the shipping cost based on client address

  Scenario: When a client address is provided, the shipping cost should be calculated
    Given a client exists with address "Rua X, 123"
    When I calculate the shipping cost
    Then I should see the shipping cost as 16.0

  Scenario: Invalid address
    Given a client exists with address "Endereço Inválido"
    When I calculate the shipping cost
    Then I should see an error message "Erro ao calcular o frete: Erro ao geocodificar o endereço: 500"
