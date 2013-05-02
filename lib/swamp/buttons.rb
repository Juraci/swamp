module Swamp
  class Buttons < Base
    def get
      elements = []
      all("button").map do |element|
        if element.visible? and has_text?(element)
          elements << element.text
        end
      end
      elements
    end

    def has_text?(element)
      element.text.empty? ? false : true
    end
  end
end
