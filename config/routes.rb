Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/users/signup" => "users#signup"
  post "/users/signin" => "users#signin"

  resources :teams
  resources :fixtures do
    get 'completed_fixtures', on: :collection
    get 'pending_fixtures', on: :collection
    put 'update_scores', on: :member
  end

  get '/search' => "search#index"
end
