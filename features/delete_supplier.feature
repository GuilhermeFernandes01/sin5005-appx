Feature: Delete a supplier
  As a employee
  I want to delete a registered supplier
  So that I can remove outdated or incorrect supplier records

  Scenario: Successfully delete a supplier
    Given there are registered suppliers
    When I visit the suppliers listing page
    And I delete the supplier "Supplier 1"
    Then I should no longer see "Supplier 1" in the suppliers list
    And I should see a message saying "Supplier was successfully deleted."
