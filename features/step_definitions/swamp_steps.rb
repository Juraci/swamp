Given /^swamp is not yet running$/  do
end

When /^I start it$/  do
  swamp = Swamp::Initializer.new(output)
  swamp.run
end

Then /^I should see "(.*?)"$/  do |outcome|
  output.messages.should include(outcome)
end

class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end
