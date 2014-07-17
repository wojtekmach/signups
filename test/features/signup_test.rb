require 'test_helper'
require 'webmock'
require 'app'
require 'api_client'
require 'web_client'

module SignupTests
  def test_success
    signup = @app.signup(email: 'example@gmail.com').submit
    assert signup.valid?
  end

  def test_failure
    signup = @app.signup(email: 'invalid').submit
    assert !signup.valid?
    assert_equal Hash[email: ['is invalid']], signup.error_messages
  end
end

class SignupAppTest < Minitest::Test
  include SignupTests

  def setup
    @app = App.new
  end
end

class SignupAPITest < Minitest::Test
  include SignupTests

  def setup
    WebMock.stub_request(:any, /signup.test/).to_rack(Rails.application.routes)
    @app = APIClient.new('http://signup.test')
  end
end

class SignupWebTest < Minitest::Test
  include SignupTests

  def setup
    Capybara.app = Rails.application
    @app = WebClient.new
  end
end

