module Swamp
  class Base

    require 'capybara'

    include Capybara::DSL

    def initialize
      setup_capybara
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
