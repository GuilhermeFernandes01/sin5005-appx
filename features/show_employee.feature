Feature: Show Employee Details
  As a manager
  I want to see the details of an employee
  So that I can view their information

  Scenario: Viewing the details of an employee
    Given the following employees exist:
      | name       | salary | position | admission_date | dismissal_date | password | password_confirmation | birth_date |
      | John Doe   | 50000  | Developer| 2020-01-01     |                |  123456  | 123456                | 1990-01-01 |
    When I visit the employees page
    And I click the button to show details of the employee "John Doe"
    Then I should see the employee details containing "Nome: John Doe"
    And I should see the employee details containing "Salário: R$50.000,00"
    And I should see the employee details containing "Cargo: Developer"
    And I should see the employee details containing "Data de admissão: 01/01/2020"
    And I should see the employee details containing "Data de nascimento: 01/01/1990"
