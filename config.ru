# encoding: UTF-8

app_root = File.expand_path('./app')
$:.unshift(app_root) unless $:.include?(app_root)

require 'app'

run YoutubeDL::Application
