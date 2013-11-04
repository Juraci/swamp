module Swamp
  class InputButtons < Elements
    def get
      elements = []
      page.all('input[type="submit"]').map do | element |
        if element.visible?
          if has_value?(element)
            if has_id?(element)
              shine %-##{element["id"]}-
              elements << Swamp::InputButton.new(element["value"], "##{element["id"]}")
            elsif has_class?(element)
              shine %-input.#{formatter.format_class(element["class"])}[value='#{element["value"]}']-
              elements << Swamp::InputButton.new(element["value"], "input.#{formatter.format_class(element["class"])}[value='#{element["value"]}']")
            end
          end
        end
      end
      elements
    end
  end
end
