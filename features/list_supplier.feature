Feature: List suppliers
  As a employee
  I want to see a list of registered suppliers
  So that I can view all relevant supplier information.

  Scenario: Display the list of registered suppliers
    Given there are registered suppliers
    When I visit the suppliers listing page
    Then I should see a table with supplier information
    And the table should contain "Código", "Nome", "CNPJ", "Telefone", "Email", "Segmento" and "Produtos"
    And I should see supplier "Supplier 1"
    And I should see supplier "Supplier 2"
