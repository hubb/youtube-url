require 'digest/sha1'

module YoutubeDL
  class User

    Error = Class.new(ArgumentError)

    def self.login(auth = {})
      raise Error.new("Provide proper auth info!") unless auth.key?("info")

      if users.key?(auth["info"]["email"])
        return users[auth["info"]["email"]]
      else
        user = new(auth["info"])
        users.store(user.email, user)
      end

      user
    end

    def self.logout(email)
      users.delete(email)
    end

    def self.find(email = nil)
      if email
        if user = users[email]
          return user
        else
          raise Error.new("User not found")
        end
      else
        raise Error.new("Cant find a user without an email")
      end
    end


    attr_reader :id, :email, :first_name, :last_name

    def initialize(params = {})
      raise Error.new("Invalid parameters") unless params.key?("email")

      @email      = params["email"]
      @first_name = params["first_name"]
      @last_name  = params["last_name"]
      @id         = Digest::SHA1.hexdigest(@email)
    end

    def full_name
      "#{first_name} #{last_name}"
    end


    private

    def self.users
      $users ||= {}
    end

  end
end
