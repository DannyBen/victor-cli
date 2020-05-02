module Victor
  module CLI
    class XMLText
      attr_reader :text

      def initialize(text)
        @text = text.strip
      end
    end
  end
end
