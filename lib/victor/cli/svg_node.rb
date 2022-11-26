require 'nokogiri'
require 'erb'
require 'rufo'

module Victor
  module CLI
    class SVGNode
      using Rendering
      attr_reader :node, :layout

      # Returns a new instance from an SVG file
      def self.load_file(path, layout: nil)
        load File.read(path), layout: layout
      end

      # Returns a new instance from raw SVG string
      def self.load(svg_string, layout: nil)
        doc = Nokogiri::XML svg_string
        root = doc.children.last
        new root, layout: layout
      end

      # Initializes with a Nokogiri XML node
      def initialize(node, layout: nil)
        @node = node
        @layout = layout || :cli
      end

      # Returns formatted Ruby code
      def render
        Rufo::Formatter.format ruby_code
      rescue Rufo::SyntaxError
        raise ruby_code
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

      # Returns the ruby code, unformatted
      def ruby_code
        erb erb_template
      end

    private

      # Returns true if the element should be ignored
      def rejected?
        (node.text? and node.text.strip.empty?) or type == :junk
      end

      # Renders ERB code
      def erb(code)
        ERB.new(code, trim_mode: '%-').result(binding)
      end

      # Returns the content of the appropriate ERB tempalte, based on type
      def erb_template
        @erb_template ||= File.read(erb_template_file)
      end

      # Returns the path to the appropriate ERB template, based on type
      def erb_template_file
        file = type == :root ? "root_#{layout}" : type
        File.expand_path "templates/nodes/#{file}.erb", __dir__
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
        node.attribute_nodes.to_h do |attr|
          name = attr.name
          value = attr.value
          key = attr.respond_to?(:prefix) ? "#{attr.prefix}:#{name}" : name

          [key, value]
        end
      end

      def content!
        if type == :css
          CSSData.new(node.content).to_h
        elsif node.content.is_a? String
          node.content.strip
        else
          # TODO: do we need this?
          # :nocov:
          node.content
          # :nocov:
        end
      end
    end
  end
end
