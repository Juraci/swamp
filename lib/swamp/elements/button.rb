module Swamp
  class Button < Element
    attr_accessor :prism_selector
    def method_signature
      format(@name)
    end

    def accessor
      "click_button(\"#{@selector}\")"
    end
  end
end
