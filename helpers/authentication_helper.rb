module YoutubeDL
	module Helpers::Authentication

		def logged_in?
			!! session[:email]
		end

		def log_in(auth = nil)
			halt 400, "Bad Authentication" unless auth

			current_user    = YoutubeDL::User.login(auth)
			session[:email] = @current_user.email
		end

		def log_out
			if current_user
				YoutubeDL::User.logout(current_user)
				session[:email] = nil
			end
		end

		def current_user
			@current_user
		end

		def current_user=(user)
			@current_user = user
		end

	end
end
