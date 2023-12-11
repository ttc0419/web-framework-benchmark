Rails.application.routes.draw do
  root to: redirect('/records', status: 301)
  resources :genres, :records
end
