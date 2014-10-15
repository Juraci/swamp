Feature: User chooses the source scope

  As a Swamp user
  I want to change the scope to "source"
  So I can have snippets that are compatible with capybara-page-object gem

  Scenario: User changes the scope from page to source
    Given that swamp is already running
    When I attempt to execute the command ":scope = source"
    And I attempt to scan this page: "button.html"
    Then swamp should output the following code snippet
      """
      def sign_up
        source.click_button("Sign Up")
      end
      """
