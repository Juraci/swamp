Feature: user changes the scope in the runtime

  As a swamp user
  I want to change the scope from "page" to "source"
  So I can have snippets that are compatible with capybara-page-object gem

  Scenario Outline: User receives feedback from swamp on command execution
    Given that swamp is already running
    When I attempt to execute the command <command>
    Then I should see <expected>

    Examples: Happy paths
      | command           | expected                         |
      | ":scope = source" | "Option :scope set to source" |
      | ":scope = page"   | "Option :scope set to page"   |

    Examples: Corner cases
      | command              | expected                         |
      | ":scope=source"      | "Option :scope set to source" |
      | ":scope =  page"     | "Option :scope set to page"   |
      | ":scope = "          | "Invalid command"                |
      | ":whatever = random" | "Invalid command"                |
      | ": = "               | "Invalid command"                |

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
