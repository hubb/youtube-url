module YoutubeDL
  class Application < Sinatra::Base

    helpers do
    def title
      if @title
        "#{@title} -- Youtube URL Downloader"
      else
        "Youtube URL Downloader"
      end
    end

  end

    get '/' do
      @search = ""
      erb :search
    end

    post '/search' do

      @search = params.fetch("search") { raise "Give me something to search!" }
      @lang   = params.fetch("lang")   { "en" }

      client = YouTubeIt::Client.new

      @results = client.videos_by(
        :query    => @search,
        :hl       => @lang,
        :per_page => 50
      ).videos

      erb :search
    end

  end
end
