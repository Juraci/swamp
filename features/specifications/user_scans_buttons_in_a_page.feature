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

  Scenario: A button that doesn't has text
    Given I enter the url for this page: "button_without_text.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def search_button
        source.click_button("search-button")
      end
      """

  Scenario: A button whose the text is not eligible to be the methods name
    Given I enter the url for this page: "button_with_bad_text.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      source.click_button("R$ 9,90 Comprar")
      """
