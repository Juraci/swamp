Feature: user starts swamp

  As a swamp user
  I want to start the application
  So that I can magically create my page-objects

  Scenario: Start swamp
    Given swamp is not yet running
    When I start it
    Then I should see "Enter the url for the page to be scanned:"
