module Victor
  module CLI
    module Rendering
      refine Hash do
        def render
          # TODO: Reduce cognitive complexity
          map do |key, value|
            key = key.to_key if key.is_a? String

            if key == 'style'
              value = "{ #{value.style_to_hash.render} }"
            elsif value.is_a? String
              value = value.to_value
            end

            "#{key}: #{value}"
          end.join ', '
        end
      end

      refine String do
        def to_key
          tr('-', '_').to_sym.inspect[1..]
        end

        def to_value
          if (to_f.to_s == self) || (to_i.to_s == self)
            self
          else
            %["#{self}"]
          end
        end

        # Transforms the valus of a style attribute to a hash
        # Example: "color: black; top: 10" => { color: black, top: 10 }
        def style_to_hash
          parser = CssParser::Parser.new
          parser.load_string! "victor { #{self} }"
          parser.to_h['all']['victor']
        end
      end
    end
  end
end
