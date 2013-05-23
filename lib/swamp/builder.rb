module Swamp
  class Builder
    def initialize(type, name, selector)
      @type = type
      @name = name
      @selector = selector
    end

    def build_snippet
      if @type == :field
        "#{method_definition}#{field_signature}\n#{identation}#{prefix}#{field_selector}\n#{method_end}"
      elsif @type == :button
        if @name != nil
          "#{method_definition}#{button_signature}\n#{identation}#{prefix}#{button_selector}\n#{method_end}"
        else
          "#{prefix}#{button_selector}"
        end
      end
    end

    def method_definition
      "def "
    end

    def method_end
      "end"
    end

    def prefix
      "source."
    end

    def field_signature
      "type_#{formatter.format(@name)}(input)"
    end

    def button_signature
      formatter.format(@name)
    end

    def identation
      "  "
    end

    def field_selector
      "fill_in(\"#{@selector}\", with: input)"
    end

    def button_selector
      "click_button(\"#{@selector}\")"
    end

    def formatter
      @formatter ||= Swamp::Formatter.new
    end
  end
end
