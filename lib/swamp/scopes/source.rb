module Swamp
  module Scope
    class Source
      def builder
        @builder ||= Swamp::Builders::Basic.new('source')
      end
    end
  end
end