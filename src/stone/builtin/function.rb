module Stone

  module Builtin

    class Function

      attr_reader :name
      attr_reader :arity
      attr_reader :proc

      def initialize(name, arity, proc)
        @name = name
        @arity = arity
        @proc = proc
      end

      def value
        self
      end

      def evaluate(_context)
        self
      end

      def call(parent_context, arguments)
        proc.call(parent_context, arguments)
      end

      def type
        "Builtin.Function"
      end

      def to_s(_untyped: false)
        "Function(name: #{name}, arity: #{arity})"
      end

    end

  end

end
