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
