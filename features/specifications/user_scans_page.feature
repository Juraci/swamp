Feature: user scans a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for fields, buttons and links
  then swamp generates the interfaces to interact with those elements using capybara

  Background: swamp is running
    Given that swamp is already running

  Scenario: User scans a page that contains a field
    Given user types the url "file:///home/juraci/projects/swamp/features/support/page_examples/field.html"
    When swamp scans that url
    Then swamp should output the following interface
      """
      def type_username(input)
        source.fill_in("username", with: input)
      end
      """

  @pending
  Scenario: User scans a page that contains a button
    Given user types the url "<url>"
    When swamp scans that url
    Then swamp should output the following interface
      """
      def log_in
        source.find("button.save.login_button").click
      end
      """

  @pending
  Scenario: User scans a page that contains a link
    Given user types the url "<url>"
    When swamp scans that url
    Then swamp should output the following interface
      """
      def go_to_help
        source.click_link("help")
      end
      """
