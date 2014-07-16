class SignupsController < ApplicationController
  respond_to :html, :json

  def new
    @signup = app.signup(params[:signup])
    respond_with @signup
  end

  def create
    @signup = app.signup(params[:signup])
    @signup.submit
    respond_with @signup, location: confirmation_signup_path
  end
end
