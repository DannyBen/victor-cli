module Victor
  module CLI
    module Refinements
      refine String do
        def format_as_key
          gsub('-', '_')
        end

        def format_as_value
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