module Swamp
  module Builders
    class Basic

      def initialize(base)
        @base = base
      end

      def build_snippet(element)
        if element.name
          [method_definition, element.method_signature, line_break, identation, base, element.accessor, line_break, method_end].join
        else
          [base, element.accessor].join
        end
      end

      def method_definition
        'def '
      end

      def method_end
        'end'
      end

      def base
        [@base, '.'].join
      end

      def identation
        '  '
      end

      def line_break
        "\n"
      end
    end
  end
end
