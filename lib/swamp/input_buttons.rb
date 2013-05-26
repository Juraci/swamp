module Swamp
  class InputButtons < Base
    def get
      all('input[type="submit"]').map do | element |
        Swamp::InputButton.new(element["value"], "input##{element["id"]}")
      end
    end
  end
end

module Swamp
  class InputButton < Element
    def method_signature
      format(@name)
    end

    def accessor
      "find(:css, \"#{@selector}\").click"
    end
  end
end
