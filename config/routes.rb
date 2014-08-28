Rails.application.routes.draw do
    post 'book/load'

    resources :textbooks
    get '/accommodations/location(/:id)', to: 'locations#drilldown', as: 'drilldown_location'
    resources :accommodations


    get 'site/home'
    root 'site#home'
end
