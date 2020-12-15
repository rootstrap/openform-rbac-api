Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get :status, to: 'api#status'

      resources :users, only: %i[create update destroy] do
        resources :roles, only: %i[index]
        resources :permissions, only: %i[index]
      end

      resources :roles, only: %i[create destroy index] do
        resources :permissions, only: %i[index]
      end

      resources :permissions, only: %i[index create]

      resources :settings, only: [] do
        get :must_update, on: :collection
      end
    end
  end
end
