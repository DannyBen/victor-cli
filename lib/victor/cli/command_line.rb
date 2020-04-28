require 'mister_bin'
require_relative 'commands/base'
require_relative 'commands/generate'

module Victor
  module CLI
    class CommandLine
      def self.router
        router = MisterBin::Runner.new version: VERSION,
          header: "Victor SVG Utilities"

        router.route 'generate', to: Commands::Generate

        router
      end
    end

  end
end