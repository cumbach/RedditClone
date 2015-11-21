Rails.application.routes.draw do
  resources :users
  resources :subs, except: :destroy do
    resources :posts, except: [:index, :show]
  end

  resource :session, only: [:new, :create, :destroy]
end
