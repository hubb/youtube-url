module YoutubeDL
  class Application < Sinatra::Base

    helpers do
    # If @title is assigned, add it to the page's title.
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
      query = search.fetch("query") { raise "LOL" }
      lang = search.fetch("lang") { "en" }

      @results = YoutubeSearch.search(query, 'lr' => lang, 'max-result' => 50)
      erb :search
    end

  end
end
