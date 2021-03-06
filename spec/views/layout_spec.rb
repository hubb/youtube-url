require 'spec_helper'

describe YoutubeDL::Application do
  it 'has a title' do
    get '/'
    last_response.body.should include(app.helpers.title)
  end

  context 'logged out' do
    before(:each) do
      described_class.any_instance.stub(:logged_in?).and_return(false)
    end


  end

  context 'logged in' do
    let(:user) { double('user', :email => "test@example.com", :name => "Test") }

    before do
      described_class.any_instance.stub(:logged_in?).and_return(true)
      described_class.any_instance.stub(:current_user).and_return(user)
    end


  end
end
