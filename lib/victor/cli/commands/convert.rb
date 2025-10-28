module Victor
  module CLI
    module Commands
      class Convert < Base
        summary 'Convert SVG to Ruby code'

        usage 'victor convert SVG_FILE [--save RUBY_FILE --template NAME]'
        usage 'victor convert (-h|--help)'

        option '-t, --template NAME', <<~USAGE
          Name of the Ruby template to use. Can be:
            standalone   a full standalone Ruby script
            dsl          a Victor DSL script
            cli          a Victor CLI compatible DSL script (default)
        USAGE

        option '-o, --save RUBY_FILE', 'Save to RUBY file instead of printing to stdout'

        param 'RUBY_FILE', 'Output Ruby file. Leave empty to write to stdout'

        example 'victor convert example.svg --save example.rb'

        def run
          validate_template template if template

          if ruby_file
            File.write ruby_file, code
            say "Saved #{ruby_file}"
          else
            puts code
          end
        end

      protected

        def svg_file = args['SVG_FILE']
        def template = args['--template']
        def ruby_file = args['--save']

        def svg_node = @svg_node ||= SVGNode.load_file(svg_file, layout: template)
        def code = @code ||= svg_node.render

      private

        def validate_template(template)
          allowed = %w[cli dsl standalone]
          return if allowed.include? template

          raise "Template not found #{template}\nAvailable templates: #{allowed.join ', '}"
        end
      end
    end
  end
end
