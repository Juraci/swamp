module Swamp
  module Scope
    class Prism
      def builder
        @builder ||= Swamp::Builders::Prism.new
      end
    end
  end
end