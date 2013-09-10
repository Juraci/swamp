module Swamp
  class Link < Element
    def method_signature
      format(@name)
    end

    def accessor
      "click_link(\"#{@selector}\")"
    end
  end
end
