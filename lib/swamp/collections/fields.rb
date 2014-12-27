module Swamp
  class Fields < Elements
    def get
      elements = []
      page.all('input').map do |element|
        if element.visible? and valid_type?(element)
          if has_id?(element) and has_name?(element)
            shine (%/##{element['id']}/)
            field = Swamp::Field.new(element['name'], element['id'])
            field.prism_selector = "'##{element['id']}'"
            elements << field
          elsif has_id?(element)
            shine (%/##{element['id']}/)
            field = Swamp::Field.new(element['id'], element['id'])
            field.prism_selector = "'##{element['id']}'"
            elements << field
          elsif has_name?(element)
            shine (%/input[name=#{element['name']}]/)
            field = Swamp::Field.new(element['name'], element['name'])
            field.prism_selector = %/'input[name="#{element['name']}"]'/
            elements << field
          end
        end
      end
      elements
    end

    def valid_type?(element)
      element['type'] != 'button' and element['type'] != 'radio' and element['type'] != 'checkbox' and element['type'] != 'submit' ? true : false
    end
  end
end
