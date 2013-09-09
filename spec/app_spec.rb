require 'spec_helper'

describe YoutubeDL::Application do

  describe '/' do
    it 'returns 200' do
      get '/'
      last_response.should be_ok
    end
  end

  describe '/search' do
    context 'no query given' do
      it 'returns a 400 with a message if no search query given' do
        post '/search'
        last_response.should be_bad_request
      end
    end

    it 'works with a query' do
      post '/search', "search" => { "query" => "this is a test" }

      last_response.should be_ok
    end

    it 'works with a query and a lang' do
      post '/search', "search" => { "query" => "this is a test", "lang" => "fr" }
      last_response.should be_ok
    end
  end
end
