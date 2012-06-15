Klinkers::Application.routes.draw do

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'signup' => 'users#new', :as => 'signup'
  
  resources :sessions
  
  resources :users, except: [:index]

  match "overview" => "users#overview"
  match "settings" => "users#edit"

  resources :accounts do
    resources :transactions
  end
  resources :portfolios, only: [:index, :show] do
    resource :investments do
      collection do
        get "search" => 'investments#search', :as => 'search'
      end
    end
  end

  resources :budgets do
    resources :budget_categories
  end

  resources :categories

  root :to => 'pages#home'
end
