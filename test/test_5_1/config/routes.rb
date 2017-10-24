Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  namespace :api do
    resources :toolboxes, param: :name do
      resources :hydrospanners, param: :name
    end
  end
end