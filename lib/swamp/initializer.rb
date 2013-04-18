module Swamp
  class Initializer

    MESSAGE = 'Enter the url for the page to be scanned:'

    def initialize(output)
      @output = output
    end

    def run
      @output.puts(MESSAGE)
    end

    def scan(url)
      finder = Swamp::Finder.new
      finder.go_to(url)
      snippets = finder.get_fields
      present(snippets)
    end

    def present(snippets)
      snippets.each do |snippet|
        @output.puts(snippet)
      end
    end
  end
end

module Swamp
  class Finder

    require 'capybara'

    include Capybara::DSL

    def initialize
      setup_capybara
    end

    def go_to(url)
      visit url
    end

    def get_fields
      s = []
      all('input').each do |e|
        s << "def" + " " + "type_" + e['name'] + "(" + "input" + ")" + "\n" + "  " + "source.fill_in(\"" + e['name'] + "\", with: input)\nend"
      end
      s
    end

    def setup_capybara
      Capybara.register_driver :firefox do |app|
        Capybara::Selenium::Driver.new(app, :browser => :firefox)
      end

      Capybara.run_server = false
      Capybara.default_selector = :css
      Capybara.default_driver = :selenium
      Capybara.default_wait_time = 60

      Capybara.configure do |config|
        config.match = :one
        config.exact_options = true
        config.ignore_hidden_elements = true
        config.visible_text_only = true
      end
    end
  end
end

