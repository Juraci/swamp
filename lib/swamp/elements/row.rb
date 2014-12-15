module Swamp
  class Row < Element
    attr_accessor :prism_selector
    def method_signature
      format(@name)
    end

    def accessor
      "find(:css, \"#{@selector}\")"
    end
  end
end
