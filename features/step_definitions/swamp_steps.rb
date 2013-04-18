Given /^swamp is not yet running$/  do
end

When /^(?:I start it|that swamp is already running)$/  do
  swamp.run
end

Then /^I should see "(.*?)"$/  do |outcome|
  output.messages.should include(outcome)
end

Given /^user types the url "(.*?)"$/  do |url|
  @url = url
end

When /^swamp scans that url$/ do
  swamp.scan(@url)
end

Then /^swamp should output the following interface$/ do |string|
  output.messages.should include(string)
end


class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def swamp
  @swamp ||= Swamp::Initializer.new(output)
end

def output
  @output ||= Output.new
end
