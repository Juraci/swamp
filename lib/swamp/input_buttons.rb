module Swamp
  class InputButtons < Base
    def get
      elements = []
      all('input[type="submit"]').map do | element |
        if element.visible?
          if has_value?(element)
            if has_id?(element)
              elements << Swamp::InputButton.new(element["value"], "##{element["id"]}")
            elsif has_class?(element)
              elements << Swamp::InputButton.new(element["value"], "input.#{formatter.format_class(element["class"])}[value='#{element["value"]}']")
            end
          end
        end
      end
      elements
    end

    def has_value?(element)
      element['value'] != nil and element['value'] != "" ? true : false
    end

    def has_id?(element)
      element['id'] != nil and element['id'] != "" ? true : false
    end

    def has_class?(element)
      element['class'] != nil and element['class'] != "" ? true : false
    end

    def formatter
      @formatter ||= Swamp::Formatter.new
    end
  end
end
