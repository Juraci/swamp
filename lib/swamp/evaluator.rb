module Swamp
  class Evaluator
    def initialize(input, wrapper)
      @input = input
      @wrapper = wrapper
    end

    def valid_url?
      @input.match(/^(http|https|file):\/\/.*$/i) ? true : false
    end

    def refresh_command?
      enter_keystroke? and @wrapper.page_visited
    end

    def enter_keystroke?
      @input == "\n"
    end
  end
end
