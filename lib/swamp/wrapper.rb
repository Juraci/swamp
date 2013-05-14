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
      @fields.get.map do | field |
        "def type_#{formatter.format(field.name)}(input)\n  source.fill_in(\"#{field.selector}\", with: input)\nend"
      end
    end

    def snippets_for_buttons
      @buttons.get.map do | button |
        if button.name != nil
          "def #{formatter.format(button.name)}\n  source.click_button(\"#{button.selector}\")\nend"
        else
          "source.click_button(\"#{button.selector}\")"
        end
      end
    end

    def formatter
      @formatter ||= Swamp::Formatter.new
    end
  end
end

