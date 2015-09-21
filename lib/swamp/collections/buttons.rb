module Swamp
  class Buttons < Elements
    def get
      elements = []
      page.all('button').map do |element|
        if element.visible?
          if has_valid_text?(element) and has_id?(element)
            shine %/##{element['id']}/
            button = Swamp::Button.new(element.text, element['id'])
            button.prism_selector = "'##{element['id']}'"
            elements << button
          elsif has_id?(element) and has_valid_id?(element)
            shine %/##{element['id']}/
            button = Swamp::Button.new(element['id'], element['id'])
            button.prism_selector = "'##{element['id']}'"
            elements << button
          elsif has_value?(element) and has_valid_value?(element)
            shine %/button[value="#{element['value']}"]/
            button = Swamp::Button.new(element['value'], element['value'])
            button.prism_selector = %\"[value='#{element['value']}']"\
            elements << button
          elsif has_valid_text?(element)
            button = Swamp::Button.new(element.text, element.text)
            button.prism_selector = %\'button', text: '#{element.text}'\
            elements << button
          end
        end
      end
      elements
    end
  end
end
