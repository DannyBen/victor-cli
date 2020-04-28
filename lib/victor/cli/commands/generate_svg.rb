module Victor
  module CLI
    module Commands
      class GenerateSVG < Base
        summary "Convert Ruby code to SVG"

        usage "victor to-svg RUBY_FILE [SVG_FILE]"
        usage "victor to-svg (-h|--help)"

        param "RUBY_FILE", "Input Ruby file"
        param "SVG_FILE", "Output SVG file. Leave empty to write to stdout"

        example "victor to-svg input.rb output.svg"

        def run
          ruby_file = args["RUBY_FILE"]
          svg_file = args["SVG_FILE"]

          svg = Victor::SVG.new
          eval File.read(ruby_file)
          
          unless svg.is_a? Victor::SVG
            raise "Invalid Victor Ruby code. Expected Victor::SVG, got #{svg.class}"
          end

          if svg_file
            svg.save svg_file
            say "Saved #{svg_file}"
          else
            puts svg.render
          end
        end
      end
    end
  end
end
