module Swamp
  module Scope
    class Page
      def builder
        @builder ||= Swamp::Builder.new('page')
      end
    end
  end
end