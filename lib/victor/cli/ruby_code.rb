module Victor
  module CLI
    class RubyCode
      include Victor::DSL
      attr_reader :code

      def initialize(code)
        @code = code
      end

      def evaluate
        instance_eval code
      end

      def template(template)
        template = template.to_sym if built_in_templates.include? template
        svg.template = template
      end

    private

      def built_in_templates
        %w[default minimal html]
      end

    end
  end
end
