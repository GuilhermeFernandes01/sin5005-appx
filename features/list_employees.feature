Feature: List employees
  As a manager
  I want to see a list of employees
  So that I can view their details

  Scenario: Viewing the list of employees
    Given the following employees exist:
      | name       | salary | position  | admission_date | dismissal_date | password | password_confirmation | birth_date |
      | John Doe   | 50000  | Developer | 2020-01-01     | 2021-01-01     | 123456   | 123456                | 1990-01-01 |
      | Jane Smith | 60000  | Manager   | 2019-01-01     |                | 123456   | 123456                | 1985-01-01 |
    When I visit the employees page
    Then I should see the table of employees containing "Funcionários"
    And I should see the table of employees containing "<name>"
    And I should see the table of employees containing formatted salary "<salary>"
    And I should see the table of employees containing "<position>"
    And I should see the table of employees containing formatted date "<admission_date>"
    And I should see the table of employees containing formatted date "<birth_date>"
    And I should see the table of employees containing formatted date "<dismissal_date>" if "<dismissal_date>" is present

    Examples:
      | name       | salary | position  | admission_date | dismissal_date | birth_date  |
      | John Doe   | 50000  | Developer | 2020-01-01     | 2021-01-01     | 1990-01-01  |
      | Jane Smith | 60000  | Manager   | 2019-01-01     |                | 1985-01-01  |

  Scenario: Searching for an employee
    Given the following employees exist:
      | name       | salary | position  | admission_date | dismissal_date | password | password_confirmation | birth_date |
      | John Doe   | 50000  | Developer | 2020-01-01     | 2021-01-01     | 123456   | 123456                | 1990-01-01 |
      | Jane Smith | 60000  | Manager   | 2019-01-01     |                | 123456   | 123456                | 1985-01-01 |
    When I visit the employees page
    And I fill in "Buscar por nome:" with "John"
    And I press "Buscar"
    Then I should see the table of employees containing "John Doe"
    And I should not see the table of employees containing "Jane Smith"

  Scenario: Clearing the search
    Given the following employees exist:
      | name       | salary | position  | admission_date | dismissal_date | password | password_confirmation | birth_date |
      | John Doe   | 50000  | Developer | 2020-01-01     | 2021-01-01     | 123456   | 123456                | 1990-01-01 |
      | Jane Smith | 60000  | Manager   | 2019-01-01     |                | 123456   | 123456                | 1985-01-01 |
    When I visit the employees page
    And I press "Limpar"
    Then I should see the table of employees containing "John Doe"
    And I should see the table of employees containing "Jane Smith"
