require 'spec_helper'

describe YoutubeDL::Application do

	describe '/' do
		it 'returns 200' do
			get '/'
			last_response.should be_ok
		end

		it 'has a title' do
			get '/'
			last_response.body.should include("Youtube URL Downloader")
		end

		context 'logged out' do
			before(:each) do
				described_class.any_instance.stub(:logged_in?).and_return(false)
			end

			it 'does not have a search form' do
				get '/'
				last_response.body.should_not include("form action='/search'")
			end
		end

		context 'logged in' do
			before do
				described_class.any_instance.stub(:logged_in?).and_return(true)
			end

			it 'has a search form' do
				get '/'
				last_response.body.should include("form action='/search'")
			end
		end
	end

	describe '/search' do
		it 'returns a 400 with a message if no search query given' do
			post '/search'
			last_response.should be_bad_request
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
