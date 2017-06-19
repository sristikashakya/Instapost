Rails.application.routes.draw do
  get 'relationships/follow_user'

  get 'relationships/unfollow_user'
  post ':user_id/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_id/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get 'browse', to: 'posts#browse', as: :browse_posts

  devise_for :users
  root 'posts#index'
  resources :posts do
  	resources :comments
  	resources :upvotes, only: :create
  	resources :downvotes, only: :create
  end
  resources :users, only: :show
end

