module Swamp
  module Scope
    class Page
      def builder
        @builder ||= Swamp::Builders::Basic.new('page')
      end
    end
  end
end