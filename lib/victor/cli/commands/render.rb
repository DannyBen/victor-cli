require 'listen'

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
          l = listener do |modified, added, _removed|
            changes = modified + added
            yield unless changes.empty?
          end
          l.start
          sleep
        end

        def watch_and_generate
          say "Watching #{ruby_file} for changes"
          safe_generate
          begin
            watch { safe_generate }
          rescue Interrupt
            say "\nGoodbye"
          end
        end

        def safe_generate
          generate
        rescue => e
          say! "ru`#{e.class}`\n#{e.message}"
        end

        def listener(&)
          Listen.to(ruby_dir, force_polling: true, latency: 3, only: ruby_glob, &)
        end

        def ruby_dir = @ruby_dir ||= File.dirname(ruby_file)
        def ruby_glob = @ruby_glob ||= /\A#{Regexp.escape(File.basename(ruby_file))}\z/
      end
    end
  end
end
