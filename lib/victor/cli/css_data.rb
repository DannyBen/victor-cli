require "css_parser"

module Victor
  module CLI
    class CSSData
      attr_reader :css_string

      def initialize(css_string)
        @css_string = css_string
      end

      def to_h
        parser.load_string! css_string
        parser.to_h['all']
      end

    private

      def parser
        @parser ||= CssParser::Parser.new
      end

    end
  end
end


