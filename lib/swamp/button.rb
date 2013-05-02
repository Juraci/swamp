module Swamp
  class Button
    def initialize(name, selector)
      @name = name
      @selector = selector
    end

    def name
      @name
    end

    def selector
      @selector
    end
  end
end
