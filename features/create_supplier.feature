Feature: Create a new supplier registration
  As a employee
  I want to create a new supplier registration
  So that I can add them to the supplier list

Scenario: Successfully create a new supplier registration
  Given I am on the create supplier registration page
  When I fill "name" with "Supplier Name"
  And I fill "cnpj" with "12345678000199"
  And I fill "phone" with "(11) 99999-9999"
  And I fill "email" with "supplier@teste.com"
  And I fill "segment" with "Some Segment"
  And I fill "products" with "Product A"
  And I submit the supplier form
  Then I must see a success message


  Scenario: Fail to create a new supplier registration with invalid data
    Given I am on the create supplier registration page
    When I fill in the new supplier form with invalid data or blank
    And I submit the supplier form
    Then I must see error messages
    And I must see an alert message
