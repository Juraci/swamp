module Swamp
  class Wrapper < Base
    def initialize(fields, buttons, input_buttons)
      @fields = fields
      @buttons = buttons
      @input_buttons = input_buttons
      @page_visited = false
    end

    attr_accessor :page_visited

    def explore(url)
      if !page_visited
        visit url
        @page_visited = true
      end
    end

    def scan
      snippets_for_fields + snippets_for_buttons + snippets_for_input_buttons
    end

    def snippets_for_fields
      @fields.get.map { | field | Swamp::Builder.new(field).build_snippet }
    end

    def snippets_for_buttons
      @buttons.get.map { | button | Swamp::Builder.new(button).build_snippet }
    end

    def snippets_for_input_buttons
      @input_buttons.get.map { | input_button | Swamp::Builder.new(input_button).build_snippet }
    end
  end
end
