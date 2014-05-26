module Swamp
  class Builder

    attr_reader :element

    def initialize(element)
      @element = element
    end

    def build_snippet
      if element.name
        [method_definition, element.method_signature, line_break, identation, prefix, element.accessor, line_break, method_end].join
      else
        [prefix, element.accessor].join
      end
    end

    def method_definition
      "def "
    end

    def method_end
      "end"
    end

    def prefix
      "page."
    end

    def identation
      "  "
    end

    def line_break
      "\n"
    end
  end
end
