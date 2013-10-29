module Swamp
  class Fields < Elements
    def get
      elements = []
      page.all('input').map do |element|
        if element.visible? and valid_type?(element)
          if has_id?(element) and has_name?(element)
            elements << Swamp::Field.new(element['name'], element['id'])
          elsif has_id?(element)
            elements << Swamp::Field.new(element['id'], element['id'])
          elsif has_name?(element)
            elements << Swamp::Field.new(element['name'], element['name'])
          end
        end
      end
      elements
    end

    def valid_type?(element)
      element['type'] != "button" and element['type'] != "radio" and element['type'] != "checkbox" and element['type'] != "submit" ? true : false
    end
  end
end
