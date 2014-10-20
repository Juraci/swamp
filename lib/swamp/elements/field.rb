module Swamp
  class Field < Element
    attr_accessor :prism_selector
    def method_signature
      "type_#{format(@name)}(input)"
    end

    def accessor
      "fill_in(\"#{@selector}\", with: input)"
    end
  end
end
