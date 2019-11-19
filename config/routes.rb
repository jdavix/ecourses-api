Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :chapters, only: [:index, :create, :update, :show] do
        # post :sample1 , on: :member
      end
      resources :contents, only: [:index, :create, :update, :show] do
        # post :sample1 , on: :member
      end
      resources :courses, only: [:index, :create, :update, :show] do
        # post :sample1 , on: :member
      end
    end
  end
end
