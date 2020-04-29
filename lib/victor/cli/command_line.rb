require 'mister_bin'
requires 'commands/base', 'commands'

module Victor
  module CLI
    class CommandLine
      def self.router
        router = MisterBin::Runner.new version: VERSION,
          header: "Victor SVG Utilities"

        router.route 'init',   to: Commands::Init
        router.route 'to-ruby', to: Commands::GenerateRuby
        router.route 'to-svg',  to: Commands::GenerateSVG

        router
      end
    end

  end
end