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
          else
            elements << Swamp::Button.new(nil, element.text)
          end
        end
      end
      elements
    end

    def has_valid_text?(element)
      element.text.length >= 3 and not has_punctuation?(element) ? true : false
    end

    def has_punctuation?(element)
      element.text.match(/[.,]/) ? true : false
    end

    def has_valid_id?(element)
      element["id"].length <= 1 ? false : true
    end
  end
end
