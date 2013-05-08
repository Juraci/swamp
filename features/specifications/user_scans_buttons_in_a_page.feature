Feature: user scans buttons in a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for buttons then swamp generates the code
  snippets to interact with those elements using capybara.

  Background: swamp is running
    Given that swamp is already running

  Scenario: User scans a page that contains a button
    Given user types the url "file:///home/juraci/projects/swamp/features/support/page_examples/button.html"
    When swamp scans that url
    Then swamp should output the following code snippet
      """
      def sign_up
        source.click_button("Sign Up")
      end
      """

  Scenario: User scans a page that contains a button that doesn't has text
    Given user types the url "file:///home/juraci/projects/swamp/features/support/page_examples/button_without_text.html"
    When swamp scans that url
    Then swamp should output the following code snippet
      """
      def search_button
        source.click_button("search-button")
      end
      """
