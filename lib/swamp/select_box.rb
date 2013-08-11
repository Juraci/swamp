module Swamp
  class SelectBox < Element
    def method_signature
      "select_#{format(@name)}(option)"
    end

    def accessor
      "select(option, :from => \"#{@selector}\")"
    end
  end
end
