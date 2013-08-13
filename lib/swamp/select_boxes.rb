module Swamp
  class SelectBoxes < Elements
    def get
      elements = []
      all('select').map do | element |
        if has_id?(element)
          elements << Swamp::SelectBox.new(element["id"], element["id"])
        elsif has_name?(element)
          elements << Swamp::SelectBox.new(element["name"], element["name"])
        end
      end
      elements
    end
  end
end
