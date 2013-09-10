require 'sinatra/base'

module YoutubeDL
  module Helpers
    module Page

      def title
        "Youtube URL Downloader"
      end

    end

    module Authorization
      def authorize!
        current_user || redirect('/login', 301)
      end
    end

    module Authentication

      def authenticate!(auth_details)
        if @current_user = YoutubeDL::User.login(auth_details)
          session[:email] = @current_user.email
        else
          halt 400, "Unable to authenticate you!"
        end
      end

      def logged_in?
        !! session[:email]
      end

      def current_user
        @current_user ||= begin
          YoutubeDL::User.find(session[:email])
        rescue
          halt 404, "I fucked up something, somewhere :("
        end
      end

    end
  end
end
