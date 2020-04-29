module Victor
  module CLI
    module Commands
      class Init < Base
        summary "Create a sample Victor Ruby script"

        usage "victor init RUBY_FILE [--template TEMPLATE]"
        usage "victor init (-h|--help)"

        option "-t, --template NAME", "Name of the Ruby template to use. Can be:\n" +
          "  standalone   a full standalone Ruby script\n" +
          "  dsl          a Victor DSL script\n" +
          "  cli          a Victor CLI compatible DSL script (default)"

        param "RUBY_FILE", "Output Ruby file"

        example "victor init ghost.rb"
        example "victor init ghost.rb --template standalone"

        def run
          filename = args["RUBY_FILE"]
          template = args['--template'] || 'cli'

          content = template_content(template) % { filename: filename }

          File.write filename, content
          say "Saved #{filename}"
          
          if template == 'cli'
            say %Q[Run !txtblu!victor to-svg "#{filename}"!txtrst! to render]
          else
            say %Q[Run !txtblu!ruby "#{filename}"!txtrst! to render]
          end
        end

      private

        def template_content(name)
          filename = File.join templates_path, "#{name}.rb"

          unless available_templates.include? name
            raise "Invalid template #{name}\nAvailable templates: #{available_templates.join ', '}"
          end

          File.read filename
        end

        def templates_path
          @templates_path ||= File.expand_path "../templates/init", __dir__
        end

        def available_templates
          ['cli', 'dsl', 'standalone']
        end
      end
    end
  end
end
