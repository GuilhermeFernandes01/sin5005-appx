Feature: Delete a supplier
  As a employee
  I want to delete a registered supplier
  So that I can remove outdated supplier

  Scenario 1: Successfully delete a supplier from List Page
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I press the button "Excluir" from "Supplier 1"
    And I confirm the deletion
    Then I should no longer see "Supplier 1" in the suppliers list page
    And I should see a message saying "Supplier was successfully deleted."

  Scenario 2: Successfully delete a supplier from show Page
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I click 'Ver' for "Supplier 1"
    Then I should be on the show page for "Supplier 1"
    Then I click "Excluir"
    And I confirm the deletion
    Then I should no longer see "Supplier 1" in the suppliers show page
    And I should see a message saying "Supplier was successfully deleted."

  Scenario 3: Not successfully delete a supplier from List Page
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I press the button "Excluir" from "Supplier 1"
    When I don't confirm the deletion
    Then I should see "Supplier 1" in the suppliers list
    And I should not see any messages

  Scenario 4: Not successfully delete a supplier from Show Page
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I click 'Ver' for "Supplier 1"
    Then I should be on the show page for "Supplier 1"
    Then I click "Excluir"
    When I don't confirm the deletion
    Then I should see "Supplier 1" in the suppliers show
    And I should not see any messages
