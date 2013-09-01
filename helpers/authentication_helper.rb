module YoutubeDL
	module Helpers::Authentication

		def logged_in?
			session[:email]
		end

		def log_in(auth)
			session[:email] = auth.info['email']
		end

	end
end
