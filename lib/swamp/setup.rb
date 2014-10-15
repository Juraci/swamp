module Swamp
  class Setup
    attr_reader :scope

    COMMAND_LIST = {
      ":scope" => ["source", "page"]
    }

    include Swamp::Assertions

    def initialize
      @scope = Swamp::Scope.from_value('page')
    end

    def handle_command(input)
      @input = input
      remove_white_spaces

      begin
        assert { COMMAND_LIST[command] && COMMAND_LIST[command].include?(value) }
      rescue ArgumentError
        return ["Invalid command"]
      end

      @scope = Swamp::Scope.from_value(value)

      [success_message]
    end

    def builder
      @scope.builder
    end

    private

    def success_message
      ["Option", " ",  command, " ", "set", " ", "to", " ", value].join
    end

    def command
      @input.split("=")[0]
    end

    def value
      @input.split("=")[1]
    end

    def remove_white_spaces
      @input = @input.gsub(/\s+/, "")
    end

  end
end
