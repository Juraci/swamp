module Swamp
  class Initializer
    MESSAGE = 'Enter the url for the page to be scanned:'

    def initialize(output)
      @output = output
    end

    def run
      @output.puts(MESSAGE)
    end

  end
end
