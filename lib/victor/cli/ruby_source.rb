module Victor
  module CLI
    class RubySource
      include Victor::DSL
      attr_reader :code, :filename

      def initialize(code, filename = nil)
        @code = code
        @filename = filename
      end

      def evaluate
        if filename
          instance_eval code, filename
        else
          instance_eval code
        end
      end

      def template(template)
        if built_in_templates.include? template
          template = template.to_sym
        elsif !File.exist? template
          raise "Template not found #{template}\nAvailable templates: #{built_in_templates.join ', '}, or a file path"
        end

        svg.template = template
      end

    private

      def built_in_templates
        %w[default minimal html]
      end
    end
  end
end
