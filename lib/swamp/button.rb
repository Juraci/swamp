module Swamp
  class Button < Element
    def method_signature
      format(@name)
    end

    def accessor
      "click_button(\"#{@selector}\")"
    end
  end
end
