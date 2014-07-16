Rails.application.routes.draw do
  resource :signup, only: [:new, :create] do
    get :confirmation, on: :member
  end

  get '/signup', to: redirect('/signup/new')
  root to: redirect('/signup/new')
end
