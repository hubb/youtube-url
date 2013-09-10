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

  subject { described_class.new(valid_auth["info"]) }

  describe '.login' do
    context '(a new user)' do

      let(:perform) { described_class.login(valid_auth) }

      it 'is stored' do
        perform
        described_class.users.size.should eq 1
      end

      it 'returns a user' do
        perform.should be_instance_of(described_class)
      end
    end

    context '(an existing user)' do
      before(:each) do
        subject
        described_class.stub(:login => subject)
      end

      it 'is returned from the store' do
        described_class.should_not_receive(:new)
        described_class.login(valid_auth).should eq subject
      end

      it 'is not stored twice' do
        expect {
          described_class.login(valid_auth)
        }.to_not change { described_class.users.size }
      end
    end
  end

  describe '.new' do

    context 'with valid params' do
      its(:first_name) { should eq "Steve" }
      its(:last_name)  { should eq "Ballmer" }
      its(:full_name)  { should eq "Steve Ballmer" }
      its(:email)      { should eq "steve@example.com" }
    end

    context 'with invalid params' do
      it 'raises an error if no info hash given' do
        expect { described_class.new("foo" => "bar") }.to raise_error
      end
    end

  end

  describe '.find' do

    it 'responds to find' do
      described_class.should respond_to(:find)
    end

    it 'returns the user if he exists' do
      described_class.find("steve@example.com").should be_instance_of(described_class)
    end

    it 'raises an error if user not found' do
      expect { described_class.find("michel@test.com") }.to raise_error
    end

    it 'raises an error if no email given' do
      expect { described_class.find(nil) }.to raise_error
    end
  end
end
