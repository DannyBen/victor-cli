require 'victor'
require 'requires'
requires 'cli/refinements'
require_relative 'cli/parser'
require_relative 'cli/svg_source'
require_relative 'cli/ruby_source'
require_relative 'cli/command_line'

require 'byebug' if ENV['BYEBUG']
