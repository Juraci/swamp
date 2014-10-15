module Swamp
  module Scope
    class Source
      def builder
        @builder ||= Swamp::Builder.new('source')
      end
    end
  end
end