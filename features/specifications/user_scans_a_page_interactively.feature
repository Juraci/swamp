Feature: user scans a page interactively

  As a swamp user
  I want to scan the page interactively
  So I can create the page objects faster

  Scenario: User scans the current page hiting enter
    Given that swamp already have scanned a page
    When I attempt to hit enter at the terminal
    Then swamp should scan the current page
    And I should see "Scanning, please wait..."
