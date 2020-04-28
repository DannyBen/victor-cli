module Victor
  module CLI
    module Commands
      class GenerateSVG < Base
        summary "Convert Ruby code to SVG"

        usage "victor to-svg RUBY_FILE [SVG_FILE --template TEMPLATE]"
        usage "victor to-svg (-h|--help)"

        option '-t, --template TEMPLATE', "Set SVG template\n"+
          "Can be: default, html, minimal or a file path"

        param "RUBY_FILE", "Input Ruby file"
        param "SVG_FILE", "Output SVG file. Leave empty to write to stdout"

        example "victor to-svg input.rb output.svg"
        example "victor to-svg input.rb --template minimal"

        def run
          ruby_file = args["RUBY_FILE"]
          svg_file = args["SVG_FILE"]

          svg = setup_svg args['--template']
          eval File.read(ruby_file)
          
          unless svg.is_a? Victor::SVG
            raise "Invalid Victor Ruby code - expected Victor::SVG, got #{svg.class}"
          end

          if svg_file
            svg.save svg_file
            say "Saved #{svg_file}"
          else
            puts svg.render
          end
        end

      private

        def setup_svg(template)
          svg = Victor::SVG.new
          
          if template
            template = template.to_sym if built_in_templates.include? template
            svg.template = template
          end

          svg
        end

        def built_in_templates
          %w[default minimal html]
        end
      end
    end
  end
end
