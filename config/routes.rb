Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'homes#index'
  get 'homes/index'

  devise_for :users
  get '/admin/dashboard' => 'admin/dashboard#index'

  # Admin sidebar manus
  namespace :admin do
    get '/admin/dashboard' => 'admin/dashboard#index'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, path: '', path_names: {
        sign_in: 'signin',
        sign_out: "signout",
        registration: "signup",
        password: "forgot_password"
      },
      devise_for :users, controllers: {
        passwords: 'api/v1/passwords',
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      }
    end
  end
end
