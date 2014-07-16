require 'capybara'

class WebClient
  def signup(attributes)
    Signup.new(attributes)
  end

  class Signup
    include Capybara::DSL

    attr_reader :email

    def initialize(attributes)
      @email = attributes[:email]
    end

    def submit
      visit '/'
      fill_in 'Email', with: email
      click_button 'Sign up'
      self
    end

    def valid?
      page.has_content?("Thanks!") && error_messages.empty?
    end

    def error_messages
      all(".control-group").each_with_object({}) { |group, errors|
        within(group) {
          attribute = group['class'].split(' ').grep(/signup_/).first.sub('signup_', '')
          messages = all('.help-inline').map(&:text)
          errors[attribute.to_sym] = messages if messages.any?
        }
      }
    end
  end
end

