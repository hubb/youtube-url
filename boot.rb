require 'rubygems'
require 'bundler'

Bundler.require :default, ENV['RACK_ENV'] || :development

$:.unshift File.dirname(__FILE__)

require 'app'
