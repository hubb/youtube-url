ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'

app_root = File.expand_path('./app')
$:.unshift(app_root) unless $:.include?(app_root)

require 'app'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  def app
	  @app ||= YoutubeDL::Application.new
	end

	def session
	  last_request.env['rack.session']
	end
end
