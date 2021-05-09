require "stone/language/operators"


module Stone
  module Language
    class Functions < Operators

      def grammar
        Class.new(super) do |_klass|
          override rule(:expression) { function | operation | function_call | literal | block | parenthetical_expression }
          rule!(:function) { lambda_operator >> parens(parameter_list) >> whitespace >> function_body }
          rule!(:parameter_list) { (parameter >> (str(",") >> whitespace >> parameter).repeat(0)).repeat(0) }
          rule!(:parameter) { identifier }
          rule(:function_body) { block }
          rule(:block) { curly_braces((whitespace | eol).repeat(0) >> block_body.as(:block) >> (whitespace | eol).repeat(0)) }
          rule(:block_body) { (statement >> (whitespace | eol).repeat(0)).repeat(1) }
          # TODO: This should really be an expression instead of a variable reference.
          rule!(:function_call) { identifier.as(:identifier) >> parens(argument_list.maybe) }
          rule!(:argument_list) { (argument >> (str(",") >> whitespace >> argument).repeat(0)).repeat(0) }
          rule!(:argument) { expression }
          rule(:lambda_operator) { (str("λ") | str("->")).ignore }
        end
      end

      def transforms
        Class.new(super) do |_klass|
          rule(argument: simple(:argument)) {
            argument
          }
          rule(function_call: {identifier: simple(:function_name), argument_list: sequence(:arguments)}) {
            AST::FunctionCall.new(function_name, arguments)
          }
          rule(block: sequence(:block_body)) {
            AST::Block.new(block_body)
          }
          rule(parameter: simple(:parameter)) {
            parameter
          }
          rule(function: {parameter_list: sequence(:parameters), block: sequence(:body)}) {
            AST::Function.new(parameters, body)
          }
        end
      end
    end
  end
end
