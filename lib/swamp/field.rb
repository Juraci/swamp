module Swamp
  class Field
    def initialize(name, selector)
      @name = name
      @selector = selector
    end

    def name
      @name
    end

    def selector
      @selector
    end

    def method_signature
      "type_#{formatter.format(@name)}(input)"
    end

    def accessor
      "fill_in(\"#{@selector}\", with: input)"
    end

    def formatter
      @formatter ||= Swamp::Formatter.new
    end
  end
end
