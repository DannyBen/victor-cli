require "rufo"

module Victor
  module CLI
    class CodeGenerator
      attr_reader :svg_tree, :template

      def initialize(svg_tree, template: nil)
        @svg_tree = svg_tree
        @template = template || :cli
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
        _, attrs, children = node
        values = {
          attributes: attrs_to_ruby(attrs),
          nodes: nodes_to_ruby(children)
        }

        template_content(template) % values
      end

      def template_content(name)
        filename = File.join templates_path, "#{name}.rb"

        unless File.exist? filename
          raise "Template not found #{name}\nAvailable templates: #{available_templates.join ', '}"
        end

        File.read filename
      end

      def templates_path
        @templates_path ||= File.expand_path "templates/import", __dir__
      end

      def available_templates
        @available_templates ||= Dir["#{templates_path}/*.rb"].map do |path|
          File.basename path, '.rb'
        end
      end
    end
  end
end
