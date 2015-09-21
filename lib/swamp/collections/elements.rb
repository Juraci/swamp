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

