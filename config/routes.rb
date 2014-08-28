Rails.application.routes.draw do
    resources :textbooks
    resources :accommodations

    get 'site/home'
    root 'site#home'
end
