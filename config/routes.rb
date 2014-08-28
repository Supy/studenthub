Rails.application.routes.draw do
    post 'book/load'

    resources :textbooks
    resources :accommodations

    get 'site/home'
    root 'site#home'
end
