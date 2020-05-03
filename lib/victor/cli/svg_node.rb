require 'nokogiri'
require 'erb'
require 'rufo'

module Victor
  module CLI
    class SVGNode
      using Refinements
      attr_reader :node

      # Returns a new instance from raw SVG string
      def self.load(svg_string)
        doc = Nokogiri::XML svg_string
        root = doc.children.last
        new root
      end

      # Initializes with a Nokogiri XML node
      def initialize(node)
        @node = node
      end

      def inspect
        "#<#{self.class} name=#{name}, type=#{type}>"
      end

      # Returns the tag name
      def name
        node.name
      end

      # Returns one of our internal types (symbol)
      def type
        @type ||= type!
      end

      # Returns a hash of attributes
      def attributes
        @attributes ||= attributes!
      end

      # Returns the content (body) of the lement
      def content
        @content ||= content!
      end

      # Returns an array of children elements (SVGNode)
      def children
        @children ||= children!
      end

      # Returns true if the element should be ignored
      def rejected?
        (node.text? and node.text.strip.empty?) or type == :junk
      end

      # Returns formatted Ruby code
      def render
        Rufo::Formatter.format ruby_code
      rescue Rufo::SyntaxError => e
        raise ruby_code
      end

      # Returns the ruby code, unformatted
      def ruby_code
        erb erb_template
      end

      # Renders ERB code
      def erb(code)
        ERB.new(code, nil, "%-").result(binding)
      end

    private

      # Returns the content of the appropriate ERB tempalte, based on type
      def erb_template
        @erb_template ||= File.read(erb_template_file)
      end

      # Returns the path to the appropriate ERB template, based on type
      def erb_template_file
        File.expand_path "templates/nodes/#{type}.erb", __dir__
      end

      # Returns the internal element type
      def type!
        if node.text?
          :text
        elsif node.comment?
          :junk
        elsif node.name == 'style'
          :css
        elsif node.name == 'svg'
          :root
        else
          :element
        end
      end

      # Returns a filtered list of SVGNode children
      def children!
        node.children.map do |child|
          SVGNode.new child
        end.reject(&:rejected?)
      end

      # Returns a hash of attributes
      def attributes!
        node.attribute_nodes.map do |attr|
          name = attr.name
          value = attr.value
          key = attr.respond_to?(:prefix) ? "#{attr.prefix}:#{name}" : name
          
          [key.to_sym, value]
        end.to_h
      end

      def content!
        if type == :css
          CSSData.new(node.content).to_h
        elsif node.content.is_a? String
          node.content.strip
        else
          node.content
        end
      end

    end
  end
end
