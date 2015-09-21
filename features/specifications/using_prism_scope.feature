Feature: User chooses the prism scope

  As a Swamp user
  I want to change the scope to "prism"
  So that I have snippets compatible with SitePrism page object

  Background: Swamp is running using prism scope
    Given that swamp is already running
    And its using "prism" scope

  Scenario: Scanning a button which has text
    When swamp scan this page: "button.html"
    Then it should output the following code snippet
    """
    element :sign_up, '#u_0_2'
    """

  Scenario: Scanning a button that doesn't has text but has id
    When swamp scan this page: "button_without_text.html"
    Then it should output the following code snippet
    """
    element :search_button, '#search-button'
    """

  Scenario: Scanning a button that doesn't has either text or id but has the value attribute
    When swamp scan this page: "button_without_text_without_id_with_value.html"
    Then it should output the following code snippet
    """
    element :buy_now, "[value='buy-now']"
    """

  Scenario: Scanning an input that has id, name and whose the type is text
    When swamp scan this page: "field.html"
    Then it should output the following code snippet
    """
    element :username, '#id_username'
    """

  Scenario: Scanning an input that has no name, has id and whose the type is text
    When swamp scan this page: "field_without_name.html"
    Then it should output the following code snippet
    """
    element :username, '#username'
    """

  Scenario: Scanning an input without the id attribute that has name and the type is text
    When swamp scan this page: "field_without_id.html"
    Then it should output the following code snippet
    """
    element :username, 'input[name="username"]'
    """

  Scenario: Scanning a submit that has value and id
    When swamp scan this page: "input_submit.html"
    Then it should output the following code snippet
    """
    element :log_in, '#u_0_b'
    """

  Scenario: Scanning a submit that has no id
    When swamp scan this page: "input_submit_without_id.html"
    Then it should output the following code snippet
    """
    element :continue, "input.button.g-button.g-button-submit[value='Continue']"
    """
  Scenario: Scanning a link that has id
    When swamp scan this page: "link_with_id.html"
    Then it should output the following code snippet
    """
    element :link_forgot_passwd, '#link-forgot-passwd'
    """

  Scenario: Scanning a select box that has id
    When swamp scan this page: "select_box_with_id.html"
    Then it should output the following code snippet
    """
    element :month, '#month'
    """
  Scenario: Scanning a select box that has name only
    When swamp scan this page: "select_box_with_name_only.html"
    Then it should output the following code snippet
    """
    element :region, "select[name='Region']"
    """

  Scenario: Scanning a select box that doesn't has either id or name
    When swamp scan this page: "select_without_id_and_name.html"
    Then it should output the following code snippet
    """
    element :provider_select, 'select.provider-select'
    """









