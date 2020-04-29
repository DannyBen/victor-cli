require "rufo"

module Victor
  module CLI
    class CodeGenerator
      attr_reader :svg_tree, :format

      def initialize(svg_tree, format: :cli)
        @svg_tree = svg_tree
        @format = format
      end

      def generate
        Rufo::Formatter.format(code_for_node(svg_tree))
      end

    private

      def code_for_node(node)
        case node.first
        when "svg"
          root_to_ruby node
        else
          node_to_ruby node
        end
      end

      def node_to_ruby(node)
        name, attrs, children = node
        code = "#{name} #{attrs_to_ruby(attrs)} "
        unless children.empty?
          code << " do\n"
          code << nodes_to_ruby(children)
          code << "\nend\n"
        end
        code
      end

      def nodes_to_ruby(nodes)
        nodes.map(&method(:code_for_node)).join("\n")
      end

      def attrs_to_ruby(attrs)
        attrs.reduce([]) do |acc, (k, v)|
          acc << "#{k.to_sym.inspect[1..-1]}: #{v.inspect}"
          acc
        end.join(",")
      end

      def root_to_ruby(node)
        values = { attributes: node[1], children: node[2] }

        template(:standalone) % values

        # case format
        # when :standalone
        #   standalone_template children
        # when :dsl
        #   dsl_template children
        # else # :cli
        #   cli_template children
        # end
      end

      def template(name)
        filename = File.join templates_path, "#{name}.rb"
        File.read filename
      end

      def templates_path
        @templates_path ||= File.expand_path "templates", __dir__
      end

      # def standalone_template
      #   <<~RUBY
      #     require "victor"

      #     svg = Victor::SVG.new #{attrs_to_ruby(attrs)}
      #     svg.build do
      #       #{nodes_to_ruby(children)}
      #     end

      #     svg.save "generated"
      #   RUBY
      # end
    end
  end
end
