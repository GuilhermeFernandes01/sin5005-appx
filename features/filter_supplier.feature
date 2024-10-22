Feature: Filter Supplier on Listing Page
  As a employee,
  I want to filter a supplier from the Listing page considering code, name, segment or products
  So that I can find the supplier completed information for some reason

  Scenario: User searches for suppliers by various attributes
    When I visit the suppliers listing page
    Given there are suppliers with various codes, names, segments, and products
    When I search with "SUP001, Supplier One, Segment A, Product A"
    Then I should see "Supplier One" on Listing Page
    And I clean the search bar
    Then I should see the Listing Page with all Suppliers
    And I search with "SUP001, Supplier One, Segment A, Product B"
    Then I should see the message "Não há Fornecedores cadastrados"
