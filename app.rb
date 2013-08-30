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
      erb :search
    end

    post '/search' do
      search = params["search"]
      query  = search.fetch("query") { raise "LOL" }
      lang   = search.fetch("lang") { "en" }

      @results = YoutubeSearch.search(query, 'lr' => lang, 'max-results' => 50)
      erb :search
    end

  end
end
