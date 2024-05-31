# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get 'videos/index'

  post 'videos/:id/add_to_favorites', to: 'videos#add_to_favorites', as: 'add_to_favorites'
  post 'videos/:id/delete_from_favorites', to: 'videos#delete_from_favorites', as: 'delete_from_favorites'
  post 'videos/:id/delete_from_videos_favorites', to: 'videos#delete_from_videos_favorites',
                                                  as: 'delete_from_videos_favorites'

  post 'videos/:id/add_to_watched', to: 'videos#add_to_watched', as: 'add_to_watched'
  post 'videos/:id/delete_from_watched', to: 'videos#delete_from_watched', as: 'delete_from_watched'
  get 'videos/recommendations', to: 'videos#recommendations', as: 'recommendations'

  get 'users_control/index', to: 'users_control#index'

  get 'users_control/user_activity_report', to: "users_control#user_activity_report", format: :pdf
  get 'videos/popularity_report', to: "videos#popularity_report", format: :pdf
  get 'videos/count_report', to: "videos#count_report", format: :pdf

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  devise_for :users, controllers: { sessions: 'custom_sessions' }

  resources :users_control

  resources :languages
  resources :categories
  resources :tags
  resources :speakers
  resources :favorites, concerns: :paginatable

  resources :videos, concerns: :paginatable do
    resources :reviews
    resources :video_languages
    resources :video_categories
    resources :video_tags
    resources :video_speakers
    resources :marks
  end
end
