module Stone

  module AST

    class MethodCall < Base

      attr_reader :object
      attr_reader :method_name
      attr_reader :arguments

      def initialize(object, method_name, arguments)
        @object = object
        @method_name = method_name.to_sym
        @arguments = arguments
      end

      def evaluate(context) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        evaluated_object = object.evaluate(context)
        return error?(evaluated_object) if error?(evaluated_object)
        evaluated_arguments = arguments.map{ |a| a.evaluate(context) }
        return error?(evaluated_arguments) if error?(evaluated_arguments)
        method = evaluated_object.methods[method_name]
        if method.nil?
          Error.new("MethodNotFound", method_name.to_s)
        elsif arguments.count != method.arity
          Error.new("ArityError", "'#{method_name}' expects #{method.arity} arguments, got #{arguments.count}")
        else
          # TODO: Check argument types.
          method.call(*evaluated_arguments)
        end
      end

    end

  end

end
