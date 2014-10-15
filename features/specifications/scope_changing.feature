Feature: user changes the scope in the runtime

  As a swamp user
  I want to change Swamp's scope
  So I can have snippets that are compatible me favorite framework

  Scenario Outline: User receives feedback from swamp on command execution
    Given that swamp is already running
    When I attempt to execute the command <command>
    Then I should see <expected>

  Examples: Happy paths
    | command           | expected                      |
    | ":scope = source" | "Option :scope set to source" |
    | ":scope = page"   | "Option :scope set to page"   |
    | ":scope = prism"  | "Option :scope set to prism"  |

  Examples: Corner cases
    | command              | expected                      |
    | ":scope=source"      | "Option :scope set to source" |
    | ":scope =  page"     | "Option :scope set to page"   |
    | ":scope = "          | "Invalid command"             |
    | ":whatever = random" | "Invalid command"             |
    | ": = "               | "Invalid command"             |