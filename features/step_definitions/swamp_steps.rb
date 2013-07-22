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

Then /^swamp should output the following code snippets?$/ do |string|
  output.messages.should include(string)
end

Then /^swamp should not output any snippet$/ do
  prompt_message = "Enter the url for the page to be scanned:"
  output.messages.length.should == 1
  output.messages.should include(prompt_message)
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
  output.messages.length.should == 3
  output.messages.last.should == "def sign_up\n  source.click_button(\"Sign Up\")\nend"
end
