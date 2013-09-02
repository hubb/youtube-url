require 'rubygems'
require 'bundler'

Bundler.require :default, ENV['RACK_ENV'] || :development

$:.unshift File.dirname(__FILE__)

require 'sinatra'
require 'haml'

require 'openid'
require 'omniauth-openid'
require 'gapps_openid'

require 'pry'
require 'pry-nav'
require 'pry-remote'

require 'app'
