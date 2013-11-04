Given /^swamp is not yet running$/  do
end

When /^(?:I start it|that swamp is already running)$/  do
  swamp.run
end

Then /^I should see "(.*?)"$/  do |outcome|
  output.messages.should include(outcome)
end

Given /^I enter the url for this page: "(\w+\.html)"$/  do |page|
  path = File.join(File.dirname(__FILE__), '../support/page_examples/', page)
  @url = "file://#{path}"
end

When /^swamp scans that page$/ do
  swamp.scan(@url)
end

Then /^(?:swamp|it) should output the following code snippets?$/ do |string|
  output.messages.should include(string)
end

Then /^swamp should not output any snippet$/ do
  output.should have_at_most(3).messages
  output.messages.each do |m|
    m.should_not include("def")
    m.should_not include("source.")
  end
end

Given /^that swamp already have scanned a page$/ do
  swamp.run
  path = File.join(File.dirname(__FILE__), '../support/page_examples/', "button.html")
  @url = "file://#{path}"
  swamp.scan(@url)
  output.messages.should include("def sign_up\n  source.click_button(\"Sign Up\")\nend")
end

When /^I attempt to hit enter at the terminal$/ do
  swamp.scan("\n")
end

Then /^swamp should scan the current page$/ do
  output.should have_at_most(5).messages
  output.messages[3].should == "Scanning, please wait..."
  output.messages[4].should == "def sign_up\n  source.click_button(\"Sign Up\")\nend"
end

Then /^swamp should highlight this element: "(.+)"$/ do |selector|
  page = Capybara.current_session
  page.should have_css "#{selector}[style]"
  page.find(selector)[:style].should include("border-width: 3px")
  page.find(selector)[:style].should include("border-color: rgb(255, 0, 0)")
end
