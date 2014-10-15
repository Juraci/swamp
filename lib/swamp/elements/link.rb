module Swamp
  class Link < Element
    attr_accessor :prism_selector
    def method_signature
      format(@name)
    end

    def accessor
      "click_link(\"#{@selector}\")"
    end
  end
end
