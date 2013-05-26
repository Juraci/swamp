module Swamp
  class InputButtons < Base
    def get
      elements = []
      all('input[type="submit"]').map do | element |
        if element.visible?
          elements << Swamp::InputButton.new(element["value"], "input##{element["id"]}")
        end
      end
      elements
    end
  end
end
