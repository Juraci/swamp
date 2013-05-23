module Swamp
  class Builder
    def initialize(element)
      @element = element
    end

    def build_snippet
      if @element.name
        "#{method_definition}#{@element.method_signature}\n#{identation}#{prefix}#{@element.accessor}\n#{method_end}"
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
  end
end
