Rails.application.routes.draw do
  namespace :api do
    #get 'fetch', to: 'spreadsheets#fetch'

    #resources :vacations, param: :vacation_id

    #resources :employees, param: :employee_id do
    #  resources :vacations, param: :vacation_id
    #end

    # Employees (index, show, destroy, update)
    post 'employees', to: 'employees#create'
    get 'employees', to: 'employees#index'
    get 'employees/:employee_id', to: 'employees#show'
    patch 'employees/:employee_id', to: 'employees#update'
    delete 'employees/:employee_id', to: 'employees#destroy'

    # Vacations (index, show, destroy)
    get 'vacations', to: 'vacations#index'
    get 'vacations/:vacation_id', to: 'vacations#show'
    delete 'vacations/:vacations_id', to: 'vacations#destroy'

    # Vacations FROM employee (update, index, show, destroy)
    post 'employees/:employee_id/vacations', to: 'vacations#create'
    get 'employees/:employee_id/vacations', to: 'vacations#index'
    get 'employees/:employee_id/vacations/:vacation_id', to: 'vacations#show'
    patch 'employees/:employee_id/vacations/:vacation_id', to: 'vacations#update'
    delete 'employees/:employee_id/vacations/:vacation_id', to: 'vacations#destroy'

    # Users registration and login
    post 'auth/register', to: 'auth#register'
    post 'auth/login', to: 'auth#login'

  end
end
