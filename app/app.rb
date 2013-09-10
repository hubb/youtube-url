require 'omniauth-google-apps'
require 'openid/store/filesystem'
require 'openid'
require 'omniauth-openid'
require 'gapps_openid'

require 'models/search'
require 'models/user'
require 'helpers/base'

require 'pry-remote'

module YoutubeDL
  class Application < Sinatra::Base

    helpers Helpers::Page,
            Helpers::Authentication,
            Helpers::Authorization

    # Enable Sessions
    enable :sessions
    use Rack::Session::Cookie, :secret => ENV['APP_SESSION_SECRET'] || 'test'

    # Authentication
    use OmniAuth::Strategies::GoogleApps,
        :store  => OpenID::Store::Filesystem.new('./tmp'),
        :name   => 'admin',
        :domain => ENV['APP_DOMAIN'] || 'example.com'

    post '/auth/admin/callback' do
      auth_details = request.env['omniauth.auth']
      authenticate!(auth_details)

      redirect '/'
    end

    get '/auth/failure' do
      halt 400, params[:message]
    end

    get '/login' do
      redirect '/auth/admin'
    end

    get '/logout' do
      authorize!

      User.logout(session[:email])
      session[:email] = nil

      redirect '/'
    end

    # Home
    get '/' do
      haml :welcome
    end

    # Search
    get '/search' do
      authorize!

      @videos = []
      haml :videos
    end

    # Actually search stuff
    post '/search' do
      authorize!

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
