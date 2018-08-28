require "extensions/enumerable"
require "parslet"


module Stone

  class Transform < Parslet::Transform

    rule(literal_boolean: simple(:b)) { AST::LiteralBoolean.new(b) }
    rule(literal_integer: simple(:i)) { AST::LiteralInteger.new(i) }
    rule(literal_text: simple(:t)) { AST::LiteralText.new(t) }
    rule(unary_operation: {operator: simple(:op), operand: simple(:arg)}) { AST::UnaryOperation.new(op, arg) }
    rule(binary_operation: subtree(:s)) { operators = s.rest.map_dig(:operator) ; operands = s.map_dig(:operand) ; AST::BinaryOperation.new(operators, operands) }

  end

end
