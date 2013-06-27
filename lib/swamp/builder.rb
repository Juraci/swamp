module Swamp
  class Builder
    def initialize(element)
      @element = element
    end

    def build_snippet
      if @element.name
        "#{method_definition}#{@element.method_signature}#{line_break}#{identation}#{prefix}#{@element.accessor}#{line_break}#{method_end}"
      else
        "#{prefix}#{@element.accessor}"
      end
    end

    def method_definition
      "def "
    end

    def method_end
      "end"
    end

    def prefix
      "source."
    end

    def identation
      "  "
    end

    def line_break
      "\n"
    end
  end
end
