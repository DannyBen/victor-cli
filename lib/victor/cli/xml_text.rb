module Victor
  module CLI
    class XmlText
      def initialize(raw_text)
        @raw_text = raw_text
      end

      def cleaned_text
        raw_text.strip
      end

      private

      attr_reader :raw_text
    end
  end
end
