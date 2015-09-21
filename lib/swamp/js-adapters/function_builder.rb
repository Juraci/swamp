module JavaScript
  class FunctionBuilder
    def initialize(minified_js)
      @minified_js = minified_js
    end

    def build_with(css_selector)
      minified_js + ' ' + element_declaration + ' ' + query_dom(css_selector) + ' ' + function_caller
    end

    private
    attr_reader :minified_js

    def element_declaration
      'var element ='
    end

    def query_dom(css_selector)
      "document.querySelector('#{css_selector}');"
    end

    def function_caller
      'HIGHLIGHT.glow(element);'
    end
  end
end
