Rails.application.routes.draw do
    get 'site/home'


    get '/accomodation', to: 'accomodation#index'
    get '/accomodation/new', to: 'accomodation#new'
    get '/accomodation/edit/:id', to: 'accomodation#edit'
    get '/accomodation/:id', to: 'accomodation#show'

    root 'site#home'



end
