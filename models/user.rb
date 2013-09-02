require 'securerandom'

module YoutubeDL
	class User

		@@users = {}

		def self.login(auth = {})
			raise ArgumentError.new("Provide proper auth info!") unless auth.key?("info")

			user = if @@users.key?(auth["info"]["email"])
				@@users[auth["info"]["email"]]
			else
				User.new(auth["info"])
			end

			user
		end

		def self.logout(email)
			@@users.delete(email)
		end


		attr_reader :id, :email, :first_name, :last_name

		def initialize(params = {})
			raise ArgumentError.new("Invalid parameters") unless params.key?("email")

			@id         = SecureRandom.hex(32)
			@email      = params["email"]
			@first_name = params["first_name"]
			@last_name  = params["last_name"]

			@@users.store(@email, self)
		end

		def name
			"#{first_name} #{last_name}"
		end

	end
end
