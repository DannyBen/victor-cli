require 'mister_bin'
require_relative 'commands/base'
require_relative 'commands/generate_ruby'
require_relative 'commands/generate_svg'

module Victor
  module CLI
    class CommandLine
      def self.router
        router = MisterBin::Runner.new version: VERSION,
          header: "Victor SVG Utilities"

        router.route 'to-ruby', to: Commands::GenerateRuby
        router.route 'to-svg',  to: Commands::GenerateSVG

        router
      end
    end

  end
end