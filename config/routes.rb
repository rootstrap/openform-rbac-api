Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get :status, to: 'api#status'
      resources :users, only: %i[create update destroy]
      resource :user, only: [] do
        scope module: 'users' do
          resources :roles, only: :index
        end
      end

      resource :resource, except: %i[new edit]
      resources :settings, only: [] do
        get :must_update, on: :collection
      end
    end
  end
end
