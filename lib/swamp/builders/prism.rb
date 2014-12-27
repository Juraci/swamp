module Swamp
  module Builders
    class Prism
      def build_snippet element
        "element :#{element.formatted_name}, #{element.prism_selector}"
      end
    end
  end
end
