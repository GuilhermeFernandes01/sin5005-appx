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
    Then I should see "Funcionários"
    And I should see "Nome: <name>"
    And I should see formatted salary "Salário: <salary>"
    And I should see "Cargo: <position>"
    And I should see formatted date "Data de admissão: <admission_date>"
    And I should see formatted date "Data de nascimento: <birth_date>"
    And I should see formatted date "Data de demissão: <dismissal_date>" if "<dismissal_date>" is present

    Examples:
      | name       | salary | position  | admission_date | dismissal_date | birth_date  |
      | John Doe   | 50000  | Developer | 2020-01-01     | 2021-01-01     | 1990-01-01  |
      | Jane Smith | 60000  | Manager   | 2019-01-01     |                | 1985-01-01  |
