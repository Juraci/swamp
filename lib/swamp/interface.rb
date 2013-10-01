module Swamp
  class Interface

    WELCOME_MESSAGE = ['Enter the url for the page to be scanned:']
    INVALID_REQUEST_MESSAGE = ['Please enter a valid url!']

    def initialize(output, wrapper)
      @output = output
      @wrapper = wrapper
    end

    def run
      present(WELCOME_MESSAGE)
    end

    def scan(input)
      @output.puts "Scanning, please wait..."
      evaluator = Swamp::Evaluator.new(input, @wrapper)
      messages = (evaluator.valid_url? or evaluator.refresh_command?) ? request(input) : INVALID_REQUEST_MESSAGE
      present messages
    end

    def request(input)
      @wrapper.explore(input)
      @wrapper.scan
    end

    private

    def present(messages)
      messages.each do |message|
        @output.puts(message)
      end
    end
  end
end
