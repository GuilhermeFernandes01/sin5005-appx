@javascript
Feature: Delete a supplier
  As a employee
  I want to delete a registered supplier
  So that I can remove outdated supplier

  Scenario: Successfully delete a supplier
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I press the button "Excluir" from "Supplier 1"
    And I confirm the deletion
    Then I should no longer see "Supplier 1" in the suppliers list
    And I should see a message saying "Supplier was successfully deleted."

    OR

    Given there are registered suppliers
    When I visit the suppliers listing page
    And I click 'Ver' for "Supplier 1"
    Then I should be on the show page for "Supplier 1"
    Then I click "Excluir"
    And I confirm the deletion
    Then I should no longer see "Supplier 1" in the suppliers show
    And I should see a message saying "Supplier was successfully deleted."

  Scenario: Not successfully delete a supplier
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I press the button "Excluir" from "Supplier 1"
    When I don't confirm the deletion
    Then I should see "Supplier 1" in the suppliers list
    And I should not see any messages
