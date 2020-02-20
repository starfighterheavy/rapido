Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  namespace :api do
    resources :toolboxes, param: :name do
      resources :hydrospanners, param: :name
      resource :virtual_widget
      resources :empty_widgets
    end

    resources :comlinks, only: [], param: :token do
      resources :messages
    end
  end
end
