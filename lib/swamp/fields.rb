module Swamp
  class Fields < Base
    def get
      elements = []
      all('input').map do |element|
        if element.visible? and has_name?(element) and valid_type?(element)
          if has_id?(element)
            elements << Swamp::Field.new(element['name'], element['id'])
          else
            elements << Swamp::Field.new(element['name'], element['name'])
          end
        end
      end
      elements
    end

    def has_id?(element)
      element['id'] != nil and element['id'] != "" ? true : false
    end

    def has_name?(element)
      element['name'] != "" ? true : false
    end

    def valid_type?(element)
      element['type'] != "radio" and element['type'] != "checkbox" and element['type'] != "submit" ? true : false
    end
  end
end
