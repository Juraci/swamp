module Swamp
	class Interface

		MESSAGE = 'Enter the url for the page to be scanned:'
		WARNING_MESSAGE = 'Please enter a valid url!'
    attr_accessor :page_scanned

		def initialize(output, wrapper)
			@output = output
			@wrapper = wrapper
      @page_scanned = false
		end

		def run
			@output.puts(MESSAGE)
		end

		def scan(url)
			if is_valid_url?(url)
				@wrapper.explore(url)
				snippets = @wrapper.scan
				present(snippets)
        @page_scanned = true
      elsif is_enter?(url) and @page_scanned
				snippets = @wrapper.scan
				present(snippets)
			else
				@output.puts(WARNING_MESSAGE)
			end
		end

    def is_enter?(input)
      input == "\n"
    end

		def is_valid_url?(url)
			url.match(/^(http|https|file):\/\/.*$/i) ? true : false
		end

		def present(snippets)
			snippets.each do |snippet|
				@output.puts(snippet) unless snippet == nil
			end
		end
	end
end
