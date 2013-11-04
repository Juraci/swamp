Feature: user scans links in a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for links elements in that page then swamp
  generates the code snippets to interact with those elements using capybara.

  Background: swamp is running
    Given that swamp is already running

  Scenario: A link that has id
    Given I enter the url for this page: "link_with_id.html"
    When swamp scans that page
    Then swamp should highlight this link: "#link-forgot-passwd"
    And it should output the following code snippet
      """
      def link_forgot_passwd
        source.click_link("link-forgot-passwd")
      end
      """
