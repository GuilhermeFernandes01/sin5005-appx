Feature: Edit Supplier on Show Page
  As a employee,
  I want to edit a supplier's information from the show page,
  So that I can update the supplier details directly after viewing them on Listing Supplier.

  Scenario: Successfully edit supplier details on the show page
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I click 'Ver' for "Supplier 1"
    Then I should be on the show page for "Supplier 1"
    Then I click "Editar"
    When I am on the edit page from "Supplier 1"
    Then I edit the name to "Supplier 1 Modified", phone to "(11) 98765-4321", email to "modified@example.com", segment to "Modified Segment", and products to "Modified Products"
    And I click on the "Salvar" button to confirm the new information
    Then I should see "Supplier 1 Modified" on the show page
    And I should see the updated details for phone, email, segment, and products
    And I should see a link to go back to the suppliers list
