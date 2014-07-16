class Signup
  include ActiveModel::Model
  validates :email, format: /@gmail.com\Z/

  attr_accessor :email

  def submit
    valid?
    self
  end

  def error_messages
    errors.messages
  end
end
