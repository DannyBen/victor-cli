require 'mister_bin'
requires 'commands/base'
requires 'commands'

module Victor
  module CLI
    class CommandLine
      def self.router
        router = MisterBin::Runner.new version: VERSION,
          header: 'Victor SVG Utilities'

        router.route 'init',    to: Commands::Init
        router.route 'convert', to: Commands::Convert
        router.route 'render',  to: Commands::Render

        router
      end
    end
  end
end
