require 'spec_helper'

describe YoutubeDL::Helpers::Authentication do

	describe 'logged_in?' do
		it 'returns true if an user is logged in' do
			pending "Not yet implemented"
		end
	end

	describe 'log_in' do
		let(:user) { mock('user') }

		context 'without auth' do
			it 'halts with a message' do
				pending "Not yet implemented"
				# post '/auth/admin/callback'
				# last_response.should be_bad_request
			end
		end
	end

end
