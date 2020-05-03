module Victor
  module CLI
    module Rendering
      refine Hash do
        def render
          map do |key, value|
            key = key.to_key if key.is_a? String
            value = value.to_value if value.is_a? String
            "#{key}: #{value}"
          end.join ", "
        end
      end

      refine String do
        def to_key
          gsub '-', '_'
        end

        def to_value
          if to_f.to_s == self or to_i.to_s == self
            self
          else
            %Q["#{self}"]
          end
        end
      end
    end
  end
end