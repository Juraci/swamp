module Swamp
  class Element
    def initialize(name, selector)
      @name = name
      @selector = selector
    end

    attr_reader :name
    attr_reader :selector

    def method_signature
      raise NotImplementedError, "Must be implemented by subtypes"
    end

    def accessor
      raise NotImplementedError, "Must be implemented by subtypes"
    end

    def prism_selector
      raise NotImplementedError, "Must be implemented by subtypes"
    end

    def prism_selector=(value)
      raise NotImplementedError, "Must be implemented by subtypes"
    end

    def formatted_name
      format(name)
    end

    def format(text)
      Swamp::Formatter.new.format(text)
    end
  end
end
