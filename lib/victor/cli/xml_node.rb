module Victor
  module CLI
    class XMLNode
      attr_reader :type, :attributes, :children

      def initialize(type, attributes, children)
        @type = type
        @attributes = attributes
        @children = children
      end

    end
  end
end
