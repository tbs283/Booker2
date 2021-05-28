Rails.application.routes.draw do
  resources :books
  devise_for :users, controllers: {
        sessions:      'users/sessions',
        passwords:     'users/passwords',
        registrations: 'users/registrations'
    }

  resources :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
end
