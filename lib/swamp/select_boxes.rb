module Swamp
  class SelectBoxes < Base
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

    def has_id?(element)
      element['id'] != nil and element['id'] != "" ? true : false
    end

    def has_name?(element)
      element['name'] != nil and element['name'] != "" ? true : false
    end
  end
end
