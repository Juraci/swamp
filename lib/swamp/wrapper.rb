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
      snippets = []
      formatter = Swamp::Formatter.new
      @fields.get.each do | field |
        snippets << "def type_#{formatter.format(field.name)}(input)\n  source.fill_in(\"#{field.selector}\", with: input)\nend"
      end
      @buttons.get.each do | button |
        snippets << "def #{formatter.format(button.name)}\n  source.click_button(\"#{button.selector}\")\nend"
      end
      snippets
    end
  end
end

