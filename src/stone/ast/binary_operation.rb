module Stone

  module AST

    class BinaryOperation < Operation

      PLUS = /[+➕]/
      MINUS = /[-−➖]/
      TIMES = /[*×·✖️]/

      attr_reader :operators
      attr_reader :operands

      def initialize(operators, operands)
        @operators = operators.map(&:to_s)
        @operands = operands
      end

      def to_s
        case operators.first
        when PLUS
          add(operands)
        when MINUS
          subtract(operands)
        when TIMES
          multiply(operands)
        else
          fail "Unknown binary operator: #{operator}"
        end
      end

      def add(operands)
        LiteralInteger.new(operands.map(&:value).inject(0, &:+)).to_s
      end

      def subtract(operands)
        LiteralInteger.new(operands[1..-1].map(&:value).inject(operands.first.value, &:-)).to_s
      end

      def multiply(operands)
        LiteralInteger.new(operands.map(&:value).inject(1, &:*)).to_s
      end

    end

  end

end
