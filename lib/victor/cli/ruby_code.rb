require "rufo"

module Victor
  module CLI
    class RubyCode
      attr_reader :code

      def initialize(code)
        @code = code
      end

      def evaluate
        instance_eval code
      end

      def svg
        @svg ||= Victor::SVG.new
      end

      # DSL

      def setup(attributes)
        svg.setup attributes
      end

      def build(&block)
        svg.build &block
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
