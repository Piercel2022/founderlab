
  # config/routes.rb
  Rails.application.routes.draw do
  # Root route
  root 'home#index'

  # Authentication routes
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # User and Profile Management
  namespace :api do
    resources :users do
      get 'profile', on: :member
      patch 'update_profile', on: :member
    end
  end

  # Projects and Development
  resources :projects do
    resources :development_projects
    resources :market_research
    resources :analytics_reports
    
    member do
      post 'archive'
      post 'activate'
      get 'dashboard'
    end
    
    collection do
      get 'archived'
      get 'active'
    end
  end

  # Subscription Management
  resources :subscriptions do
    member do
      post 'cancel'
      post 'renew'
    end
    collection do
      get 'plans'
      get 'pricing'
    end
  end

  # Mentorship Platform
  resources :mentors do
    resources :meetings
    collection do
      get 'available'
      get 'expertise/:category', to: 'mentors#by_expertise'
    end
  end

  resources :meetings do
    member do
      post 'cancel'
      post 'reschedule'
      get 'join'
    end
  end

  # Resource Hub
  resources :resources do
    collection do
      get 'search'
      get 'category/:category', to: 'resources#by_category'
    end
    member do
      get 'download'
      post 'favorite'
    end
  end

  # Community Features
  resources :events do
    member do
      post 'register'
      post 'cancel_registration'
    end
    collection do
      get 'upcoming'
      get 'past'
      get 'category/:category', to: 'events#by_category'
    end
  end

  resources :forums do
    resources :posts do
      member do
        post 'flag'
        post 'unflag'
      end
    end
    collection do
      get 'category/:category', to: 'forums#by_category'
    end
  end

  # Analytics and Reporting
  namespace :analytics do
    resources :reports do
      collection do
        get 'dashboard'
        get 'export'
      end
    end
    
    get 'metrics', to: 'metrics#index'
    get 'insights', to: 'insights#index'
  end

  # Admin Panel
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users
    resources :subscriptions
    resources :projects
    resources :mentors
    resources :events
    resources :forums
    
    # Admin specific analytics
    get 'analytics', to: 'analytics#index'
    get 'reports', to: 'reports#index'
  end

  # API endpoints
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :show, :create, :update]
      resources :analytics, only: [:index, :show]
      resources :mentors, only: [:index, :show]
      
      # API specific authentication
      post 'auth/login', to: 'authentication#login'
      post 'auth/refresh', to: 'authentication#refresh'
    end
  end

  # Static Pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  get 'help', to: 'pages#help'

  # Error pages
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
