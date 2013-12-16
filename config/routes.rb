Currently::Application.routes.draw do
  root to: 'static#home'
  match 'auth/:provider/callback', to: 'sessions#create', via: :get
  match 'auth/failure', to: redirect('/'), via: :get
  match 'signout', to: 'sessions#destroy', as: 'signout', via: :get

  resources :users, path: "/", only: [:show], :constraints => lambda { |r| User.find(r.params[:id]).present? }
end
