module Swamp
  class ComplexSelectBox < Element
    def method_signature
      "#{format(@name)}(option)"
    end

    def accessor
      %/find(:css, \"select.#{@selector} option[value='\#{option}']\").click/
    end
  end
end
