Given /^swamp is not yet running$/ do
end

When /^(?:I start it|that swamp is already running)$/ do
  swamp.run
end

Then /^I should see "(.*?)"$/ do |outcome|
  expect(fake_output.messages).to include(outcome)
end

Given /^I enter the url for this page: "(\w+\.html)"$/ do |page|
  path = File.join(File.dirname(__FILE__), '../support/page_examples/', page)
  @url = "file://#{path}"
end

When /^swamp scans that page$/ do
  swamp.scan(@url)
end

When /^I attempt to scan this page: "(\w+\.html)"$/ do |page|
  path = File.join(File.dirname(__FILE__), '../support/page_examples/', page)
  url = "file://#{path}"
  swamp.scan(url)
end

Then /^(?:swamp|it) should output the following code snippets?$/ do |string|
  expect(fake_output.messages).to include(string)
end

Then /^swamp should not output any snippet$/ do
  expect(fake_output.messages.size).to be <= 3
  fake_output.messages.each do |m|
    expect(m).not_to include("def")
    expect(m).not_to include("source.")
    expect(m).not_to include("page.")
  end
end

Given /^that swamp already have scanned a page$/ do
  swamp.run
  path = File.join(File.dirname(__FILE__), '../support/page_examples/', "button.html")
  @url = "file://#{path}"
  swamp.scan(@url)
  expect(fake_output.messages).to include("def sign_up\n  page.click_button(\"u_0_2\")\nend")
end

When /^I attempt to hit enter at the terminal$/ do
  swamp.scan("\n")
end

Then /^swamp should scan the current page$/ do
  expect(fake_output.messages.size).to be <= 5
  expect(fake_output.messages[3]).to eq "Scanning, please wait..."
  expect(fake_output.messages[4]).to eq "def sign_up\n  page.click_button(\"u_0_2\")\nend"
end

Then /^swamp should highlight this (element|link): "(.+)"$/ do |mode, selector|
  page = Capybara.current_session
  expect(page).to have_css "#{selector}[style]"
  if mode == "element"
    expect(page.find(selector)[:style]).to include("box-shadow: 0px 0px 15px rgb(81, 250, 200)")
    expect(page.find(selector)[:style]).to include("border: 1px solid rgb(81, 250, 200)")
  else
    expect(page.find(selector)[:style]).to include("background-color: rgb(255, 0, 0)")
  end
end

When /^I attempt to execute the command "(.*?)"$/ do |command|
  swamp.setup_command(command)
end

Given(/^its using "(.*?)" scope$/) do |scope|
  swamp.setup_command(":scope = #{scope}")
end

When(/^swamp scan this page: "(.*?)"$/) do |page|
  path = File.join(File.dirname(__FILE__), '../support/page_examples/', page)
  @url = "file://#{path}"
  swamp.scan(@url)
end
