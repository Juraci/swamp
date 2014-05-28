module Swamp
  class Setup
    attr_reader :scope

    def initialize
      @scope = "page"
    end

    def handle_command(input)
      @input = input
      remove_white_spaces
      result = split_between_key_and_value
      @scope = result[1]
      ["Option :scope setted to #{result[1]}"]
    end

    private

    def remove_white_spaces
      @input = @input.gsub(/\s+/, "")
    end

    def split_between_key_and_value
      @input.split("=")
    end

  end
end
