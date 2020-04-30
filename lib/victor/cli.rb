require 'victor'
require 'requires'
require_relative 'cli/parser'
require_relative 'cli/code_generator'
require_relative 'cli/ruby_code'
require_relative 'cli/command_line'

require 'byebug' if ENV['BYEBUG']
