module Swamp
  class Wrapper < Base
    def initialize(fields, buttons)
      @fields = fields
      @buttons = buttons
    end

    def explore(url)
      visit url
    end

    def scan
      snippets_for_fields + snippets_for_buttons
    end

    def snippets_for_fields
      @fields.get.map { | field | Swamp::Builder.new(:field, field.name, field.selector).build_method }
    end

    def snippets_for_buttons
      @buttons.get.map { | button | Swamp::Builder.new(:button, button.name, button.selector).build_method }
    end
  end
end
