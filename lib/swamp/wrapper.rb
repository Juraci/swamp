module Swamp
  class Wrapper < Base

    def explore(url)
      visit url
    end

    def scan
      snippets = []
      fields.each do | field |
        snippets << "def type_#{field}(input)\n  source.fill_in(\"#{field}\", with: input)\nend"
      end
      snippets
    end

    def fields
      elements = []
      all('input').map do |element|
        if element.visible? and has_name?(element) and valid_type?(element)
          elements << element['name']
        end
      end
      elements
    end

    def has_name?(element)
      element['name'] != "" ? true : false
    end

    def valid_type?(element)
      element['type'] != "radio" and element['type'] != "checkbox" ? true : false
    end
  end
end
