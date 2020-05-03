require "nokogiri"

module Victor
  module CLI
    class Parser
      attr_reader :raw_svg

      def initialize(raw_svg)
        @raw_svg = raw_svg
      end

      def parse
        parse_node svg_root
      end

    private

      def parse_node(node)
        case node
        when Nokogiri::XML::Comment
          nil
        when Nokogiri::XML::Text
          parse_text node
        else
          parse_normal_node node
        end
      end

      def parse_text(node)
        text_node = XMLText.new(node.text)
        return text_node if text_node.text.length > 0
      end

      def parse_normal_node(node)
        XMLNode.new(
          node.name,
          node_attrs(node),
          node.children.map(&method(:parse_node)).compact,
        )
      end

      def node_attrs(node)
        node.attributes.values.reduce({}) do |acc, attr|
          name = attr.name
          value = attr.value
          key = attr.respond_to?(:prefix) ? "#{attr.prefix}:#{name}" : name
          acc[key] = value
          acc
        end
      end

      def xml_doc
        Nokogiri::XML raw_svg
      end

      def svg_root
        xml_doc.children.last
      end
    end
  end
end
