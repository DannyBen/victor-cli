require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

require 'mister_bin'

include Victor
require_relative 'spec_mixin'

RSpec.configure do |c|
  c.include SpecMixin
end
