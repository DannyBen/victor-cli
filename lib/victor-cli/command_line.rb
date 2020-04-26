require 'victor-cli/commands/base'
require 'victor-cli/commands/generate'

module Victor
  module CLI
    class CommandLine
      def self.router
        router = MisterBin::Runner.new version: VERSION,
          header: "Victor SVG Utilities"

        router.route 'generate',    to: Commands::Generate

        router
      end
    end

  end
end