Feature: Search
  As a user
  I want to be able to search for products
  So that I can find what I'm looking for

  Scenario: Search for a product
    Given I am on the home page
    When I search for "blue shirt"
    Then I should see a list of search results
    And each result should contain the word "blue"

  Scenario: Search for a non-existent product
    Given I am on the home page
    When I search for "foobarbaz"
    Then I should see a message indicating no results were found

