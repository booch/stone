require "stone/ast/literal"

require "parslet"


module Stone

  module ParsletExtensions

    # A rule that outputs an AST node.
    def rule!(name, opts = {}, &definition)
      rule(name, opts) { self.instance_eval(&definition).as(name) }
    end

  end

  class Parser < Parslet::Parser

    extend ParsletExtensions

    root(:top)
    rule(:top) { (literal | whitespace).repeat(1) }
    rule(:literal) { literal_integer }
    rule!(:literal_integer) { literal_binary_integer | literal_octal_integer | literal_hexadecimal_integer | literal_decimal_integer }
    rule(:literal_decimal_integer) { match["+-"].maybe >> match["0-9"].repeat(1) }
    rule(:literal_hexadecimal_integer) { match["+-"].maybe >> str("0x") >> match["0-9a-fA-F"].repeat(1) }
    rule(:literal_octal_integer) { match["+-"].maybe >> str("0o") >> match["0-7"].repeat(1) }
    rule(:literal_binary_integer) { match["+-"].maybe >> str("0b") >> match["0-1"].repeat(1) }
    rule(:whitespace) { match["\n\s\r\t"].repeat(1) }

  end


  class Transform < Parslet::Transform

    rule(literal_integer: simple(:i)) { AST::LiteralInteger.new(i) }

  end

end
