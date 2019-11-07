Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/searches', to: 'searches#index'
      get '/dog_pics/random', to: 'dog_pics#show'
    end
  end
end
