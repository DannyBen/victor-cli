module Victor
  module CLI
    module Commands
      class Generate < Base
        summary "Generate Ruby code from SVG"

        usage "victor generate SVG_FILE [RUBY_FILE]"
        usage "victor generate (-h|--help)"

        param "SVG_FILE", "Input SVG file"
        param "RUBY_FILE", "Output Ruby file"

        example "victor generate example.svg example.rb"

        def run
          svg_file = File.read(args["SVG_FILE"])
          svg_tree = Parser.new(svg_file).parse
          code = CodeGenerator.new(svg_tree).generate
          ruby_path = args["RUBY_FILE"]

          if ruby_path.nil?
            puts code
          else
            ruby_file = File.open(ruby_path, "w")
            ruby_file.write(code)
            ruby_file.close
          end
        end
      end
    end
  end
end
