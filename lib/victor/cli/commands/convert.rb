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
          template = args['--template']
          svg_node = SVGNode.load_file svg_file, layout: template

          validate_template template

          code = svg_node.render
          ruby_file = args["RUBY_FILE"]

          if ruby_file
            File.write ruby_file, code
            say "Saved #{ruby_file}"
          else
            puts code
          end
        end

        def validate_template(template)
          allowed = %w[cli del standalone]
          unless allowed.include? template
            raise "Template not found #{template}\nAvailable templates: #{allowed.join ', '}"
          end
        end
      end
    end
  end
end
