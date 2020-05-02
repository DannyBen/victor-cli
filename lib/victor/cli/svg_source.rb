require "rufo"

module Victor
  module CLI
    class SVGSource
      using Refinements
      attr_reader :svg_tree, :template

      def initialize(svg_tree, template: nil)
        @svg_tree = svg_tree
        @svg_tree = Parser.new(@svg_tree).parse if @svg_tree.is_a? String
        @template = template || :cli
      end

      def ruby_code
        @ruby_code ||= Rufo::Formatter.format(code_for_node(svg_tree))
      end

      private

      def code_for_node(node)
        return text_to_ruby node if node.is_a?(XMLText)
        
        case node.type
        when "svg"
          root_to_ruby node
        when "text", "tspan"
          text_node_to_ruby node
        else
          node_to_ruby node
        end
      end

      def text_node_to_ruby(node)
        children = node.children
        if children.length == 1 && children.first.is_a?(XMLText)
          short_text_to_ruby node
        else
          node_to_ruby node
        end
      end

      def short_text_to_ruby(node)
        attrs = node.attributes.empty? ? "" : ",#{attrs_to_ruby(node.attributes)}"
        inner_text = node.children.first.text
        "text #{inner_text.inspect} #{attrs}"
      end

      def node_to_ruby(node)
        code = "#{node.type} #{attrs_to_ruby(node.attributes)} "
        unless node.children.empty?
          code << " do\n"
          code << nodes_to_ruby(node.children)
          code << "\nend\n"
        end
        code
      end

      def nodes_to_ruby(nodes)
        nodes.map do |node|
          code_for_node node
        end.join "\n"
      end

      def text_to_ruby(node)
        "_ #{node.text.inspect}"
      end

      def attrs_to_ruby(attrs)
        attrs.map do |key, value|
          "#{key.format_as_key}: #{value.format_as_value}"
        end.join ", "
      end

      def root_to_ruby(node)
        values = {
          attributes: attrs_to_ruby(node.attributes),
          nodes: nodes_to_ruby(node.children),
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
        end.sort
      end
    end
  end
end
