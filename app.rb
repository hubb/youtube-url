$:.unshift File.join(__FILE__)

require 'sinatra'
require 'youtube_it'
require 'haml'

require './models/search'
require './helpers/base'

module YoutubeDL
  class Application < Sinatra::Base

    helpers Helpers::Pages, Helpers::Authentication

    get '/' do
      haml :welcome
    end

    get '/search' do
      @videos = []
      haml :videos
    end

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
