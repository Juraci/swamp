module Swamp
  class ComplexSelectBox < Element
    attr_accessor :prism_selector

    def method_signature
      "#{format(@name)}(option)"
    end

    def accessor
      %/find(:css, \"select.#{@selector} option[value='\#{option}']\").click/
    end
  end
end
