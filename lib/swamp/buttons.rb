module Swamp
  class Buttons < Elements
    def get
      elements = []
      page.all("button").map do |element|
        if element.visible?
          if has_valid_text?(element)
            shine %\//button[text()='#{element.text}']\, :xpath
            elements << Swamp::Button.new(element.text, element.text)
          elsif has_id?(element) and has_valid_id?(element)
            shine %/##{element["id"]}/
            elements << Swamp::Button.new(element["id"], element["id"])
          elsif has_value?(element) and has_valid_value?(element)
            shine %/button[value='#{element["value"]}']/
            elements << Swamp::Button.new(element["value"], element["value"])
          end
        end
      end
      elements
    end
  end
end
