module Swamp
  class Formatter

    def format(name)
      @name = name
      @name = replace_dashes
      @name = remove_white_spaces
      @name = remove_suffix_symbols
      @name = downcase_name
    end

    def replace_dashes
      @name.gsub("-","_")
    end

    def remove_white_spaces
      @name.gsub(" ", "_")
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
