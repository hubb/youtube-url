require 'rubygems'
require 'bundler'

Bundler.require

$:.unshift File.dirname(__FILE__)

require 'app'

map '/' do
  run YoutubeDL::Application
end
