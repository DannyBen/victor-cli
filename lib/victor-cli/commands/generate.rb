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
          p args
        end
      end
    end
  end
end