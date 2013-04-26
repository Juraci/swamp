module Swamp
  class Buttons < Base
    def get
      elements = []
      all("button").map do |element|
        elements << element.text
      end
      elements
    end
  end
end
