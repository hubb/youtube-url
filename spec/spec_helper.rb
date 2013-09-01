ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require './app'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  def app
	  @app ||= YoutubeDL::Application.new
	end

end
