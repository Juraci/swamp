Feature: user scans submits in a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for inputs of type submit then swamp generates the code
  snippets to interact with those elements using capybara.

  Background: swamp is running
    Given that swamp is already running

  Scenario: A submit that has value and id
    Given I enter the url for this page: "input_submit.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def log_in
        source.find(:css, "#u_0_b").click
      end
      """

  Scenario: A submit that has no id
    Given I enter the url for this page: "input_submit_without_id.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def continue
        source.find(:css, "input.button.g-button.g-button-submit[value='Continue']").click
      end
      """
