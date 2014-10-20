module Swamp
  class InputButton < Element
    attr_accessor :prism_selector
    def method_signature
      format(@name)
    end

    def accessor
      "find(:css, \"#{@selector}\").click"
    end
  end
end
