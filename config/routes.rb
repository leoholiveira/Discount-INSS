# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_scope :user do
    # Redirests signing out users back to sign-in
    root to: 'devise/sessions#new'
    get 'users', to: 'devise/sessions#new'
  end
  devise_for :users

  get 'proponents/calculate_inss', to: 'proponents#discount_inss'
  get 'reports', to: 'reports#index'
  resources :proponents
  mount Sidekiq::Web => '/sidekiq'
end
