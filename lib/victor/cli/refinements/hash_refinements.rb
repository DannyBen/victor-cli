module Victor
  module CLI
    module Refinements
      refine Hash do
        def render
          map do |key, value|
            key = key.format_as_key if key.is_a? String
            value = value.format_as_value if value.is_a? String
            "#{key}: #{value}"
          end.join ", "
        end
      end
    end
  end
end