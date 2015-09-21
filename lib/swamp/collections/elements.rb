module JavaScript
  class Minifier
    def initialize
      @file_path = File.join(File.dirname(__FILE__), '../', 'js-modules', 'highlight.js')
    end

    def minify
      minified_js = ''
      file = File.new(file_path, 'r')
      file.each_line { |l| minified_js += l }
      file.close
      minified_js = minified_js.gsub("\n", "")
      minified_js = minified_js.gsub("\"", "'")
      minified_js = minified_js.gsub("    ", " ")
      minified_js = minified_js.gsub("  ", " ")
    end

    private
    attr_reader :file_path
  end
end

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

module Swamp
  class Elements < Base

    def has_id?(element)
      element['id'] != nil and element['id'] != "" ? true : false
    end

    def has_name?(element)
      element['name'] != nil and element['name'] != "" ? true : false
    end

    def has_value?(element)
      element['value'] != nil and element['value'] != "" ? true : false
    end

    def has_class?(element)
      element['class'] != nil and element['class'] != "" ? true : false
    end

    def has_valid_text?(element)
      element.text.length >= 3 and has_no_punctuation?(element.text)
    end

    def has_valid_value?(element)
      element["value"].length >= 3 and has_no_punctuation?(element["value"])
    end

    def has_no_punctuation?(string)
      string.match(/[.,]/) ? false : true
    end

    def has_valid_id?(element)
      element["id"].length <= 1 ? false : true
    end

    def formatter
      @formatter ||= Swamp::Formatter.new
    end

    def shine(selector)
      js = JavaScript::Minifier.new.minify
      script = JavaScript::FunctionBuilder.new(js).build_with(selector)
      page.execute_script(script) rescue false
    end

    def shine_link(selector)
      set_background_color selector, '#ff0000'
    end

    private

    def set_background_color(selector, color)
      page.execute_script %-document.querySelector("#{selector}").style.backgroundColor='#{color}'-
    end
  end
end

