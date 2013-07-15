module Swamp
  class Buttons < Base
    def get
      elements = []
      all("button").map do |element|
        if element.visible?
          if has_valid_text?(element)
            elements << Swamp::Button.new(element.text, element.text)
          elsif has_valid_id?(element)
            elements << Swamp::Button.new(element["id"], element["id"])
          elsif has_valid_value?(element)
            elements << Swamp::Button.new(element["value"], element["value"])
          end
        end
      end
      elements
    end

    def has_valid_text?(element)
      element.text.length >= 3 and has_no_punctuation?(element.text)
    end

    def has_valid_value?(element)
      element["value"].length >= 3 and has_no_punctuation?(element["value"])
    end

    def has_no_punctuation?(string)
      string.match(/[.,]/) ? false : true
    end

    def has_valid_id?(element)
      element["id"].length <= 1 ? false : true
    end
  end
end
