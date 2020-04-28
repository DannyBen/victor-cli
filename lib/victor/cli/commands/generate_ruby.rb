module Victor
  module CLI
    module Commands
      class GenerateRuby < Base
        summary "Convert SVG to Ruby code"

        usage "victor to-ruby SVG_FILE [RUBY_FILE]"
        usage "victor to-ruby (-h|--help)"

        param "SVG_FILE", "Input SVG file"
        param "RUBY_FILE", "Output Ruby file. Leave empty to write to stdout"

        example "victor to-ruby example.svg example.rb"

        def run
          svg_file = File.read(args["SVG_FILE"])
          svg_tree = Parser.new(svg_file).parse
          code = CodeGenerator.new(svg_tree).generate
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
