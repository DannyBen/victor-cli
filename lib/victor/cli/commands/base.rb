require 'mister_bin'
require 'colsole'

module Victor
  module CLI
    module Commands
      class Base < MisterBin::Command
        include Colsole
      end
    end
  end
end
