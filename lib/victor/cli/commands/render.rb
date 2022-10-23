require 'filewatcher'

module Victor
  module CLI
    module Commands
      class Render < Base
        summary "Render Ruby code to SVG"

        usage "victor render RUBY_FILE [SVG_FILE] [options]"
        usage "victor render (-h|--help)"

        option '-t, --template TEMPLATE', "Set SVG template\n"+
          "Can be: default, html, minimal, or a file path"

        option '-w, --watch', 'Watch the source file and regenerate on change'

        param "RUBY_FILE", "Input Ruby file"
        param "SVG_FILE", "Output SVG file. Leave empty to write to stdout"

        example "victor render input.rb output.svg"
        example "victor render input.rb output.svg --watch"
        example "victor render input.rb --template minimal"

        def run
          if args['--watch']
            watch_and_generate
          else
            generate
          end
        end

      private

        def generate
          code = File.read ruby_file

          ruby_source = RubySource.new code, ruby_file
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
            changes.each do |path, event|
              yield unless event == :deleted
            end
          end
        end

        def watch_and_generate
          watch do            
            generate
          rescue Exception => e
            say! "!undred!#{e.class}!txtrst!\n#{e.message}"
          end
        end

        def file_watcher
          @file_watcher ||= Filewatcher.new(ruby_file, immediate: true)
        end

        def ruby_file
          args["RUBY_FILE"]
        end

        def svg_file
          args["SVG_FILE"]
        end

        def template
          args['--template']
        end
      end
    end
  end
end
