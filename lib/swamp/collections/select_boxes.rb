module Swamp
  class SelectBoxes < Elements
    def get
      elements = []
      page.all('select').map do | element |
        if element.visible?
          if has_id?(element)
            shine %/##{element["id"]}/
            select_box = Swamp::SelectBox.new(element["id"], element["id"])
            select_box.prism_selector = "'##{element['id']}'"
            elements << select_box
          elsif has_name?(element)
            shine %/select[name='#{element["name"]}']/
            select_box = Swamp::SelectBox.new(element["name"], element["name"])
            select_box.prism_selector = %\"select[name='#{element['name']}']"\
            elements << select_box
          else
            shine %/select.#{element["class"]}/
            select_box = Swamp::ComplexSelectBox.new(element["class"], element["class"])
            select_box.prism_selector = %\'select.#{element['class']}'\
            elements << select_box
          end
        end
      end
      elements
    end
  end
end
