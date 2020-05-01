module Victor
  module CLI
    module Commands
      class GenerateSVG < Base
        summary "Convert Ruby code to SVG"

        usage "victor to-svg RUBY_FILE [SVG_FILE --template TEMPLATE]"
        usage "victor to-svg (-h|--help)"

        option '-t, --template TEMPLATE', "Set SVG template\n"+
          "Can be: default, html, minimal, or a file path"

        param "RUBY_FILE", "Input Ruby file"
        param "SVG_FILE", "Output SVG file. Leave empty to write to stdout"

        example "victor to-svg input.rb output.svg"
        example "victor to-svg input.rb --template minimal"

        def run
          ruby_file = args["RUBY_FILE"]
          svg_file = args["SVG_FILE"]
          template = args['--template']
          code = File.read ruby_file

          ruby_source = RubySource.new code
          ruby_source.evaluate
          ruby_source.template template if template
          
          if svg_file
            ruby_source.svg.save svg_file
            say "Saved #{svg_file}"
          else
            puts ruby_source.svg.render
          end
        end
      end
    end
  end
end
