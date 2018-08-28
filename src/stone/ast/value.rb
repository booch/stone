module Stone

  module AST

    class Value

      attr_reader :value

      def initialize(parslet_slice)
        @value = parslet_slice.to_s
        normalize!
      end

      def evaluate
        self
      end

      def type
        fail NotImplementedError
      end

      def to_s
        "#{type}(#{value})"
      end

      def normalize!
      end

    end

  end

end


require "stone/ast/boolean"
require "stone/ast/integer"
require "stone/ast/text"