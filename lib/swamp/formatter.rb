module Swamp
  class Formatter

    def format(name)
      @name = name
      @name = replace_dashes
      @name = remove_white_spaces
      @name = replace_parentheses
      @name = replace_brackets
      @name = remove_suffix_symbols
      @name = downcase_name
    end

    def format_class(name)
      @name = name
      @name = replace_white_spaces_with_dots
    end

    def replace_white_spaces_with_dots
      @name.gsub(" ",".")
    end

    def replace_dashes
      @name.gsub("-","_")
    end

    def remove_white_spaces
      @name.gsub(" ", "_")
    end

    def replace_parentheses
      @name.gsub("(", "_").gsub(")", "_")
    end

    def replace_brackets
      @name.gsub("[", "_").gsub("]", "_")
    end

    def remove_suffix_symbols
      result = @name.match(/\w+?(?<symbols>[_]+\Z)/)
      if result != nil
        @name = @name.chomp(result[:symbols])
      end
      @name
    end

    def downcase_name
      @name.downcase
    end
  end
end
