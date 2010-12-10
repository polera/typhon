class Typhon
  class AST

    Nodes = Hash.new

    # Converts a ruby sexp (array literals) into Typhon AST
    def self.from_sexp(sexp)
      return nil if sexp.nil? || sexp.empty?
      name = sexp.first
      rest = sexp[1..-1]
      type = Nodes[name]
      raise "Unknown sexp type: #{name}" unless type
      body = rest.map { |e| if e.kind_of?(Array) then from_sexp(e) else e end }
      line = 0
      ast = type.new(line, *body)
      ast
    end

    class Node < Rubinius::AST::Node
      def self.name(name)
        Nodes[name] = self
      end
    end

  end
end
