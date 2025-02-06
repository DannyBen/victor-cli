lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'victor/cli/version'

Gem::Specification.new do |s|
  s.name        = 'victor-cli'
  s.version     = Victor::CLI::VERSION
  s.summary     = 'CLI for Victor, the SVG Library'
  s.description = 'CLI for Victor, the SVG Library'
  s.authors     = ['Danny Ben Shitrit', 'Max Brosnahan']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['victor']
  s.homepage    = 'https://github.com/dannyben/victor-cli'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.1'

  s.add_dependency 'colsole', '~> 1.0'
  s.add_dependency 'css_parser', '~> 1.7'
  s.add_dependency 'filewatcher', '~> 2.0'
  s.add_dependency 'mister_bin', '~> 0.7'
  s.add_dependency 'nokogiri', '~> 1.10'
  s.add_dependency 'pretty_trace', '~> 0.3'
  s.add_dependency 'requires', '~> 1.0'
  s.add_dependency 'rufo', '~> 0.12'
  s.add_dependency 'victor', '~> 0.4'
  
  # FIXME: Remove when resolved.
  #        This is a sub-dependency of filewatcher which does not bundle logger.
  #        ref: https://github.com/filewatcher/filewatcher/pull/272
  s.add_dependency 'logger', '~> 1.6'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/victor-cli/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/victor-cli/blob/master/CHANGELOG.md',
    'source_code_uri'       => 'https://github.com/DannyBen/victor-cli',
    'rubygems_mfa_required' => 'true',
  }
end
