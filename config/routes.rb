# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :game do
    resources :throws, only: %i[create]
  end
  resources :games, only: %i[index create]
end
