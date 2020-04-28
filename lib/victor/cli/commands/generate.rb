module Victor
  module CLI
    module Commands
      class Generate < Base
        summary "Generate Ruby code from SVG"

        usage "victor generate SVG_FILE [RUBY_FILE]"
        usage "victor generate (-h|--help)"

        param "SVG_FILE", "Input SVG file"
        param "RUBY_FILE", "Output Ruby file. Leave empty to write to stdout"

        example "victor generate example.svg example.rb"

        def run
          svg_file = File.read(args["SVG_FILE"])
          svg_tree = Parser.new(svg_file).parse
          code = CodeGenerator.new(svg_tree).generate
          ruby_file = args["RUBY_FILE"]

          if ruby_file
            File.write ruby_file, code
          else
            puts code
          end
        end
      end
    end
  end
end
