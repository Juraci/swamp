module Swamp
  class Interface

    WELCOME_MESSAGE = ['Enter the url for the page to be scanned:']
    INVALID_REQUEST_MESSAGE = ['Please enter a valid url!']
    NO_ELEMENTS_MESSAGE = ['No elements were detected']

    def initialize(output, wrapper)
      @output = output
      @wrapper = wrapper
    end

    def run
      present(WELCOME_MESSAGE)
    end

    def scan(input)
      @output.puts "Scanning, please wait..."
      messages = valid_request?(input) ? request(input) : INVALID_REQUEST_MESSAGE
      present messages
    end

    private

    def present(messages)
      messages.each do |message|
        @output.puts(message)
      end
    end

    def valid_request?(input)
      evaluator(input).valid_url? or evaluator(input).refresh_command?
    end

    def evaluator(input)
      Swamp::Evaluator.new(input, @wrapper)
    end

    def request(input)
      @wrapper.explore(input)
      @wrapper.scan.empty? ? NO_ELEMENTS_MESSAGE : @wrapper.scan
    end
  end
end
