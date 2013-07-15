Feature: user scans buttons in a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for buttons then swamp generates the code
  snippets to interact with those elements using capybara.

  Background: swamp is running
    Given that swamp is already running

  Scenario: A button that has text
    Given I enter the url for this page: "button.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def sign_up
        source.click_button("Sign Up")
      end
      """

  Scenario: A button that doesn't has text but has id
    Given I enter the url for this page: "button_without_text.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def search_button
        source.click_button("search-button")
      end
      """

  Scenario: A button that doesn't has either text or id but has the value attribute
    Given I enter the url for this page: "button_without_text_without_id_with_value.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def buy_now
        source.click_button("buy-now")
      end
      """

  Scenario: A button without text id and value
    Given I enter the url for this page: "button_without_text_id_and_value.html"
    When swamp scans that page
    Then swamp should not output any snippet
