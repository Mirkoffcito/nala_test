Rails.application.routes.draw do
  namespace :api do
    get 'fetch', to: 'spreadsheets#fetch'

    resources :employees do
      resources :vacations
    end
  end
end
