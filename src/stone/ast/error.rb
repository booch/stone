module Stone

  module AST

    class Error

      attr_reader :name
      attr_reader :description

      # TODO: We should also get the source location of the error.
      def initialize(name, description = nil)
        @name = name
        @description = description
      end

      def evaluate
        self
      end

      def type
        name
      end

      def to_s
        "#{type}: #{description}."
      end

    end

  end

end
