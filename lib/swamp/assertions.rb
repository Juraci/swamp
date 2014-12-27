module Swamp
  module Assertions
    def assert &block
      raise ArgumentError unless block.call
    end
  end
end
