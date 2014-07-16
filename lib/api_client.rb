require 'rest-client'

class APIClient
  attr_reader :base_uri

  def initialize(base_uri)
    @base_uri = base_uri
  end

  def signup(attributes)
    Signup.new(self, attributes)
  end

  class Signup
    attr_reader :email

    def initialize(app, attributes)
      @app = app
      @email = attributes[:email]
    end

    def submit
      RestClient.post(@app.base_uri + "/signup.json", signup: {email: email})
      self
    rescue RestClient::UnprocessableEntity => e
      @error_messages = JSON(e.response).fetch('errors').symbolize_keys
      self
    end

    def valid?
      error_messages.none?
    end

    def error_messages
      @error_messages || {}
    end
  end
end

