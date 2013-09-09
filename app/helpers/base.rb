require 'sinatra/base'

module YoutubeDL
  module Helpers
    module Page

      def title
        "Youtube URL Downloader"
      end

    end

    module Authentication

      def logged_in?
        !! session[:email]
      end

      def log_in(auth = nil)


        @current_user = User.login(auth).tap { |user|
          session[:email] = user.email
        }
      end

      def log_out
        if @current_user
          User.logout(current_user)
          session[:email] = nil
        end
        @current_user = nil
      end

      def current_user
        @current_user
      end

      def current_user=(user)
        @current_user = user
      end

    end
  end
end
