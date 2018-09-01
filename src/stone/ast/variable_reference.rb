module Stone

  module AST

    class VariableReference < Base

      attr_reader :name

      def initialize(name)
        @name = name.to_s
      end

      def evaluate(context)
        context[name] || Error.new("UndefinedVariable", name)
      end

      def to_s
        name
      end

    end

  end

end
