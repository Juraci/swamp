Feature: user changes the scope in the runtime

  As a swamp user
  I want to change the scope from "page" to "source"
  So I can have snippets that are compatible with capybara-page-object gem

  Scenario: User receives feedback from swamp on successful command execution
    Given that swamp is already running
    When I attempt to change the scope to "source" with the command
      """
      :scope = source
      """
      Then I should see "Option :scope setted to source"


  Scenario: User changes the scope from page to source
    Given that swamp is already running
    When I attempt to change the scope to "source" with the command
      """
      :scope = source
      """
    And I attempt to scan this page: "button.html"
    Then swamp should output the following code snippet
      """
      def sign_up
        source.click_button("Sign Up")
      end
      """
