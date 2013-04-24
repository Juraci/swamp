module Swamp
  class Wrapper < Base

    def initialize(fields)
      @fields = fields
    end

    def explore(url)
      visit url
    end

    def scan
      snippets = []
      @fields.get.each do | field |
        snippets << "def type_#{format(field)}(input)\n  source.fill_in(\"#{field}\", with: input)\nend"
      end
      snippets
    end

    def format(name)
      name.gsub("-","_").gsub(" ","_")
    end
  end
end
