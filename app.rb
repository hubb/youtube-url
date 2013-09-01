require 'sinatra'
require 'haml'

require './models/search'
require './helpers/base'

require 'openid'
require 'omniauth-openid'
require 'omniauth-google-apps'
require 'gapps_openid'

require 'openid/store/filesystem'

module YoutubeDL
  class Application < Sinatra::Base

    helpers Helpers::Pages,
            Helpers::Authentication

    # Enable Sessions
    use Rack::Session::Cookie, :secret => ENV['APP_SESSION_SECRET'] || "test"

    # Authentication
    use OmniAuth::Strategies::GoogleApps,
        :store  => OpenID::Store::Filesystem.new('./tmp'),
        :name   => 'admin',
        :domain => ENV['APP_DOMAIN'] || 'example.com'

    post '/auth/admin/callback' do
      auth_details = request.env['omniauth.auth']
      log_in(auth_details)
      redirect '/'
    end

    get '/auth/failure' do
      halt 400, params[:message]
    end

    # Home
    get '/' do
      haml :welcome
    end

    # Search
    get '/search' do
      @videos = []
      haml :videos
    end

    # Actually search stuff
    post '/search' do
      begin
        @search = Search.new(params["search"])
      rescue ArgumentError => error
        halt 400, error.to_s
      end

      @videos = @search.results

      haml :videos
    end

  end
end
