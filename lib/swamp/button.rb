module Swamp
  class Button
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
      formatter.format(@name)
    end

    def accessor
      "click_button(\"#{@selector}\")"
    end

    def formatter
      @formatter ||= Swamp::Formatter.new
    end
  end
end
