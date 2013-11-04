module Swamp
  class SelectBoxes < Elements
    def get
      elements = []
      page.all('select').map do | element |
        if element.visible?
          if has_id?(element)
            shine %-##{element["id"]}-
            elements << Swamp::SelectBox.new(element["id"], element["id"])
          elsif has_name?(element)
            shine %-select[name='#{element["name"]}']-
            elements << Swamp::SelectBox.new(element["name"], element["name"])
          end
        end
      end
      elements
    end
  end
end
