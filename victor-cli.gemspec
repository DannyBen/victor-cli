lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'victor/cli/version'

Gem::Specification.new do |s|
  s.name        = 'victor-cli'
  s.version     = Victor::CLI::VERSION
  s.date        = Date.today.to_s
  s.summary     = "CLI for Victor, the SVG Library"
  s.description = "CLI for Victor, the SVG Library"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['victor']
  s.homepage    = 'https://github.com/dannyben/victor-cli'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.4.0"

  s.add_runtime_dependency 'mister_bin', '~> 0.7'
  s.add_runtime_dependency 'colsole', '~> 0.7'
  s.add_runtime_dependency 'victor', '~> 0.2'
end
