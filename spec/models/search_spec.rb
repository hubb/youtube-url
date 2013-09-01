require 'spec_helper'

describe YoutubeDL::Search do

	context 'invalid params' do
		it 'raises an error if no query given' do
			expect { subject }.to raise_error
		end

		it 'defaults lang to english' do
			search = described_class.new("query" => "test")
			search.lang.should eql("en")
		end
	end

end
