ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require './app'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  def app
	  @app ||= YoutubeDL::Application.new
	end

end
