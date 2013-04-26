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
      @fields.get.each do | field |
        snippets << "def type_#{format(field)}(input)\n  source.fill_in(\"#{field}\", with: input)\nend"
      end
      @buttons.get.each do | button |
        snippets << "def #{format(button)}\n  source.click_button(\"#{button}\")\nend"
      end
      snippets
    end

    def format(name)
      name.gsub("-","_").gsub(" ","_")
      name = name.gsub("-","_").gsub(" ","_")
      result = name.match(/\w+?(?<symbols>[_]+\Z)/)
      if result != nil
        name = name.chomp(result[:symbols])
      end
      name.downcase
    end
  end
end
