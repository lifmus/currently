Currently::Application.routes.draw do
  root to: 'static#home'
  match 'auth/:provider/callback', to: 'sessions#create', via: :get
  match 'auth/failure', to: redirect('/'), via: :get
  match 'signout', to: 'sessions#destroy', as: 'signout', via: :get
  match 'settings', to: 'settings#edit', as: 'settings', via: :get
  match 'settings', to: 'settings#update', as: 'update_settings', via: :put
  resources :statuses
  match ':slug', to: 'users#show', constraints: lambda { |r| User.find_by_slug(r.params[:slug]).present? }, as: 'user', via: :get
end
