module Victor
  module CLI
    class XmlNode
      def initialize(type, attributes, children)
        @type = type
        @attributes = attributes
        @children = children
      end

      attr_reader :type, :attributes, :children
    end
  end
end
