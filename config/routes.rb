# frozen_string_literal: true

Rails.application.routes.draw do
  draw :sidekiq if %w[admin all].include?(ENV['APP_TYPE'])

  resources :custom_leads, only: %i[create new]

  root to: 'custom_leads#new'
end
