module Swamp
  class Builder

    attr_reader :element

    def initialize(element, setup)
      @element = element
      @setup = setup
    end

    def build_snippet
      if element.name
        [method_definition, element.method_signature, line_break, identation, scope, element.accessor, line_break, method_end].join
      else
        [scope, element.accessor].join
      end
    end

    def method_definition
      "def "
    end

    def method_end
      "end"
    end

    def scope
      [@setup.scope, "."].join
    end

    def identation
      "  "
    end

    def line_break
      "\n"
    end
  end
end
