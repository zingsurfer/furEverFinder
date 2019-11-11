Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :searches, only: [:create, :index, :show, :update, :destroy]
      get '/dog_pics/random', to: 'dog_pics#show'
    end
  end
  get '*other', to: redirect('/')
end
