module Victor
  module CLI
    module Commands
      class Convert < Base
        summary "Convert SVG to Ruby code"

        usage "victor convert SVG_FILE [RUBY_FILE --template NAME]"
        usage "victor convert (-h|--help)"

        option "-t, --template NAME", "Name of the Ruby template to use. Can be:\n" +
          "  standalone   a full standalone Ruby script\n" +
          "  dsl          a Victor DSL script\n" +
          "  cli          a Victor CLI compatible DSL script (default)"

        param "SVG_FILE", "Input SVG file"
        param "RUBY_FILE", "Output Ruby file. Leave empty to write to stdout"

        example "victor convert example.svg example.rb"

        def run
          svg_file = args["SVG_FILE"]
          svg_node = SVGNode.load_file svg_file
          svg_node.layout = args['--template']

          code = svg_node.render
          ruby_file = args["RUBY_FILE"]

          if ruby_file
            File.write ruby_file, code
            say "Saved #{ruby_file}"
          else
            puts code
          end
        end
      end
    end
  end
end
