module Swamp
  class Interface
    require 'colorize'

    WELCOME_MESSAGE = ['Enter the url for the page to be scanned:'.green]
    INVALID_REQUEST_MESSAGE = ['Please enter a valid url!'.red]

    def initialize(output, wrapper)
      @output = output
      @wrapper = wrapper
    end

    def run
      present(WELCOME_MESSAGE)
    end

    def scan(input)
      evaluator = Swamp::Evaluator.new(input, @wrapper)
      messages = (evaluator.valid_url? or evaluator.refresh_command?) ? request(input).map { |s| s.yellow } : INVALID_REQUEST_MESSAGE
      present messages
    end

    def request(input)
      @wrapper.explore(input)
      @wrapper.scan
    end

    def present(messages)
      messages.each do |message|
        @output.puts(message)
      end
    end
  end
end
