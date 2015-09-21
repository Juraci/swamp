module Swamp
  class InputButtons < Elements
    def get
      elements = []
      page.all('input[type="submit"],input[type="button"]').map do | element |
        if element.visible?
          if has_value?(element)
            if has_id?(element)
              shine %/##{element["id"]}/
              button = Swamp::InputButton.new(element["value"], "##{element["id"]}")
              button.prism_selector = %\'##{element['id']}'\
              elements << button
            elsif has_class?(element)
              shine %/input.#{formatter.format_class(element["class"])}[value="#{element["value"]}"]/
              capybara_selector = "input.#{formatter.format_class(element["class"])}[value='#{element["value"]}']"
              button = Swamp::InputButton.new(element["value"], capybara_selector)
              button.prism_selector = %\"#{capybara_selector}"\
              elements << button
            end
          end
        end
      end
      elements
    end
  end
end
