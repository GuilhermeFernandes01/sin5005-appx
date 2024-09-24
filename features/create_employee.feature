Feature: Create a new employee
  As a manager
  I want to create a new employee
  So that I can add them to the employee list

  Scenario: Successfully create a new employee
    Given I am on the new employee page
    When I fill in the new employee form with valid data
    And I submit the form
    Then I should see a success message
    And I should see the new employee in the employee list

  Scenario: Fail to create a new employee with invalid data
    Given I am on the new employee page
    When I fill in the new employee form with invalid data
    And I submit the form
    Then I should see error messages
    And I should see an alert message "Employee not created"
