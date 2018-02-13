Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  namespace :api do
    resources :toolboxes, param: :name do
      resources :hydrospanners, param: :name
    end

    resources :comlinks, only: [], param: :token do
      resources :messages, only: [:create]
    end
  end

  namespace :user do
    resources :protocol_droids, param: :name
  end

  resources :toolboxes, param: :name do
    resources :hydrospanners, param: :name
  end

  root to: 'toolboxes#index'
end
