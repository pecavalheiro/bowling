# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games, only: %i[index create]
end
