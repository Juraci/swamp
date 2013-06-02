module Swamp
	class Interface

		MESSAGE = 'Enter the url for the page to be scanned:'
		WARNING_MESSAGE = 'Please enter a valid url!'

		def initialize(output, wrapper)
			@output = output
			@wrapper = wrapper
		end

		def run
			@output.puts(MESSAGE)
		end

		def scan(url)
			if is_valid_url?(url)
				@wrapper.explore(url)
				snippets = @wrapper.scan
				present(snippets)
			else
				@output.puts(WARNING_MESSAGE)
			end
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
