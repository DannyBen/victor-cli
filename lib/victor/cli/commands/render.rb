require 'filewatcher'

module Victor
  module CLI
    module Commands
      class Render < Base
        using PairSplit

        summary 'Render Ruby code to SVG'

        usage 'victor render RUBY_FILE [options] [PARAMS...]'
        usage 'victor render (-h|--help)'

        option '-t, --template TEMPLATE', <<~USAGE
          Set SVG template
          Can be: default, html, minimal, or a file path
        USAGE

        option '-w, --watch', 'Watch the source file and regenerate on change'
        option '-o, --save SVG_FILE', 'Save to SVG file instead of printing to stdout'

        param 'RUBY_FILE', 'Input Ruby file'
        param 'PARAMS', 'One or more key=value pairs that will be available in the `params` hash for the Ruby script'

        example 'victor render input.rb -o output.svg'
        example 'victor render input.rb --save output.svg --watch'
        example 'victor render input.rb --template minimal'
        example 'victor render input.rb color=black "text=Hello World"'

        def run
          args['--watch'] ? watch_and_generate : generate
        end

      protected

        def ruby_file = args['RUBY_FILE']
        def svg_file = args['--save']
        def template = args['--template']
        def params = @params ||= args['PARAMS'].pair_split

      private

        def generate
          code = File.read ruby_file

          ruby_source = RubySource.new code, filename: ruby_file, params: params
          ruby_source.evaluate
          ruby_source.template template if template

          if svg_file
            ruby_source.svg.save svg_file
            say "Saved #{svg_file}"
          else
            puts ruby_source.svg.render
          end
        end

        def watch
          say "Watching #{ruby_file} for changes"
          file_watcher.watch do |changes|
            changes.each_value do |event|
              yield unless event == :deleted
            end
          end
        end

        def watch_and_generate
          watch do
            generate
          rescue => e
            say! "ru`#{e.class}`\n#{e.message}"
          end
        end

        def file_watcher
          @file_watcher ||= Filewatcher.new(ruby_file, immediate: true)
        end
      end
    end
  end
end
