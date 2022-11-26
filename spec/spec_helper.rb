require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include Victor::CLI

Dir.mkdir 'spec/tmp' unless Dir.exist? 'spec/tmp'

RSpec.configure do |config|
  config.strip_ansi_escape = true
end
