module Swamp
  module Scope

    SCOPES = {
        source: Swamp::Scope::Source.new,
        page: Swamp::Scope::Page.new
    }
    def Scope.from_value(value)
      SCOPES[value.to_sym]
    end
  end
end