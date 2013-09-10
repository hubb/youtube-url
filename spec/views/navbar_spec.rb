require 'spec_helper'

describe YoutubeDL::Application do

  context 'logged out' do
    before(:each) do
      described_class.any_instance.stub(:logged_in?).and_return(false)
    end

    it 'has a login link' do
      get '/'
      last_response.body.should include("a href='/login'")
    end

    it 'does not have a search link' do
      get '/'
      last_response.body.should_not include("a href='/search'")
    end
  end

  context 'logged in' do
    let(:user) { double('user', :email => "test@example.com", :name => "Test") }

    before do
      described_class.any_instance.stub(:logged_in?).and_return(true)
      described_class.any_instance.stub(:current_user).and_return(user)
      get '/'
    end

    it 'has a search link' do
      last_response.body.should include("a href='/search'")
    end

    it 'has a logout link' do
      last_response.body.should include("a href='/logout'")
    end

    it 'has an upload link' do
      last_response.body.should include("a href='/upload'")
    end
  end
end
