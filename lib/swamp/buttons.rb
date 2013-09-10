module Swamp
  class Buttons < Elements
    def get
      elements = []
      page.all("button").map do |element|
        if element.visible?
          if has_valid_text?(element)
            elements << Swamp::Button.new(element.text, element.text)
          elsif has_id?(element) and has_valid_id?(element)
            elements << Swamp::Button.new(element["id"], element["id"])
          elsif has_value?(element) and has_valid_value?(element)
            elements << Swamp::Button.new(element["value"], element["value"])
          end
        end
      end
      elements
    end
  end
end
