module Victor
  module CLI
    module PairSplit
      refine Array do
        def pair_split(operator = '=')
          return {} if empty?

          to_h { |pair| pair.split(operator, 2) }.transform_keys(&:to_sym)
        end
      end
    end
  end
end
