module Swamp
  class Table < Element
    attr_accessor :prism_selector
    def method_signature
      format(@name)
    end

    def accessor
      "find(\"#{@selector}\")"
    end
  end
end
