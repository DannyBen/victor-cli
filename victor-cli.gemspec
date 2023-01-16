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
  s.required_ruby_version = '>= 2.7.0'

  s.add_runtime_dependency 'colsole', '~> 0.7.2'
  s.add_runtime_dependency 'css_parser', '~> 1.7'
  s.add_runtime_dependency 'filewatcher', '~> 2.0'
  s.add_runtime_dependency 'mister_bin', '~> 0.7.3'
  s.add_runtime_dependency 'nokogiri', '~> 1.10'
  s.add_runtime_dependency 'pretty_trace', '~> 0.2.5'
  s.add_runtime_dependency 'requires', '~> 1.0'
  s.add_runtime_dependency 'rufo', '~> 0.12'
  s.add_runtime_dependency 'victor', '~> 0.3.4'
  s.metadata['rubygems_mfa_required'] = 'true'
end
