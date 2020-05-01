module Victor
  module CLI
    module Refinements
      refine String do
        def formatted_value
          inspect
        end
      end
    end
  end
end