require 'spec_helper'

describe YoutubeDL::User do
	let(:valid_auth) {
		{
			"info" => {
				"email"=>"steve@example.com",
				"first_name"=>"Steve",
				"last_name"=>"Ballmer",
				"name"=>"Steve Ballmer"
			}
		}
	}

	describe '.login' do
		context 'new user' do

			let(:perform) { described_class.login(valid_auth) }

			it 'returns a user' do
				perform.should be_instance_of(described_class)
			end
		end

		context 'existing user' do
			before(:each) do
				@user = described_class.new(valid_auth["info"])
			end

			it 'returns the exisitng user' do
				described_class.login(valid_auth).should eq @user
			end

			it 'stores only 1 user' do
				expect {
					described_class.login(valid_auth)
				}.to_not change {
					described_class.class_variable_get(:@@users).size
				}
			end
		end
	end

	describe '.new' do

		context 'with valid params' do
			subject { described_class.new(valid_auth["info"]) }

			it { subject.first_name.should eq "Steve" }
			it { subject.last_name.should eq "Ballmer" }
			it { subject.name.should eq "Steve Ballmer" }
			it { subject.email.should eq "steve@example.com" }

			it 'stores the user in a hash' do
				subject
				described_class.class_variable_get(:@@users).size.should eq 1
			end
		end

		context 'with invalid params' do
			it 'raises an error if no info hash given' do
				expect { described_class.new("foo" => "bar") }.to raise_error
			end
		end
	end

	describe '#name' do
		it 'is first_name and last_name joined' do
			described_class.new(valid_auth["info"]).name.should eq valid_auth["info"]["name"]
	  end
	end

end
