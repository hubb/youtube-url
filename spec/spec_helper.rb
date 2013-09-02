ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require './boot'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  def app
	  @app ||= YoutubeDL::Application.new
	end

	def session
	  last_request.env['rack.session']
	end
end
