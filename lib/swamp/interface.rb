module Swamp
  class Interface

    MESSAGE = 'Enter the url for the page to be scanned:'

    def initialize(output, wrapper)
      @output = output
      @wrapper = wrapper
    end

    def run
      @output.puts(MESSAGE)
    end

    def scan(url)
      @wrapper.explore(url)
      snippets = @wrapper.scan
      present(snippets)
    end


    def present(snippets)
      snippets.each do |snippet|
        @output.puts(snippet)
      end
    end
  end
end

