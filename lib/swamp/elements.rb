module Swamp
  class Elements < Base

    BORDER_SIZE = "3px"
    BORDER_COLOR = "#ff0000"
    BACKGROUND_COLOR = "#ff0000"

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

    def shine(selector, mode = :css)
      set_border_size(selector, BORDER_SIZE, mode)
      set_border_color(selector, BORDER_COLOR, mode)
    end

    def shine_link(selector)
      set_background_color selector, BACKGROUND_COLOR
    end

    private

    def set_border_size(selector, size, mode)
      if mode == :css
        page.execute_script %-document.querySelector("#{selector}").style.borderWidth='#{size}'-
      elsif mode == :xpath
        page.execute_script %-document.evaluate("#{selector}", document, null, 9, null).singleNodeValue.style.borderWidth='#{size}';- rescue false
      else
        raise "Mode #{mode} not found"
      end
    end

    def set_border_color(selector, color, mode = :css)
      if mode == :css
        page.execute_script %-document.querySelector("#{selector}").style.borderColor='#{color}'-
      elsif mode == :xpath
        page.execute_script %-document.evaluate("#{selector}", document, null, 9, null).singleNodeValue.style.borderColor='#{color}';- rescue false
      else
        raise "Mode #{mode} not found"
      end
    end

    def set_background_color(selector, color)
      page.execute_script %-document.querySelector("#{selector}").style.backgroundColor='#{color}'-
    end
  end
end
