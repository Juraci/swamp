Feature: user scans select box elements in a page

  The user enters an url to a given page, swamp fires up the browser and go to that url
  once the page is loaded swamp start looking for select box elements in that page then swamp
  generates the code snippets to interact with those elements using capybara.

  Background: swamp is running
    Given that swamp is already running

  Scenario: A select box that has id
    Given I enter the url for this page: "select_box_with_id.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def select_month(option)
        source.select(option, :from => "month")
      end
      """

  Scenario: A select box that has name only
    Given I enter the url for this page: "select_box_with_name_only.html"
    When swamp scans that page
    Then swamp should output the following code snippet
      """
      def select_region(option)
        source.select(option, :from => "Region")
      end
      """
