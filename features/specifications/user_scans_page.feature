Feature: user scans a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for fields, buttons and links
  then swamp generates the code snippets to interact with those elements using capybara

  Background: swamp is running
    Given that swamp is already running

  Scenario: User scans a page that contains a field
    Given user types the url "file:///home/juraci/projects/swamp/features/support/page_examples/field.html"
    When swamp scans that url
    Then swamp should output the following code snippet
      """
      def type_username(input)
        source.fill_in("username", with: input)
      end
      """

  Scenario: User scans a page that contains a button
    Given user types the url "file:///home/juraci/projects/swamp/features/support/page_examples/button.html"
    When swamp scans that url
    Then swamp should output the following code snippet
      """
      def sign_up
        source.click_button("Sign Up")
      end
      """

  Scenario: User scans a page that contains a checkbox
    Given user types the url "file:///home/juraci/projects/swamp/features/support/page_examples/checkbox.html"
    When swamp scans that url
    Then swamp should not output any snippet

  Scenario: User scans a page that contains a radio
    Given user types the url "file:///home/juraci/projects/swamp/features/support/page_examples/radio.html"
    When swamp scans that url
    Then swamp should not output any snippet
