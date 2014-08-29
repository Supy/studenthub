Rails.application.routes.draw do
    post 'book/load'

    resources :textbooks
    get '/locations/drilldown(/:id)', to: 'locations#drilldown', as: 'drilldown_location'
    resources :accommodations


    get 'site/home'
    root 'site#home'
end
