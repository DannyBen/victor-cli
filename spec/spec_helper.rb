require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

# require 'mister_bin'

include Victor::CLI
require_relative 'spec_mixin'

