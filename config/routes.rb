Rails.application.routes.draw do
    get 'site/home'

    # Accomodation can be handled as a CRUD resource:
    # accomodation_index  GET    /accomodation(.:format)          accomodation#index
    # accomodation_index  POST   /accomodation(.:format)          accomodation#create
    # new_accomodation    GET    /accomodation/new(.:format)      accomodation#new
    # edit_accomodation   GET    /accomodation/:id/edit(.:format) accomodation#edit
    # accomodation        GET    /accomodation/:id(.:format)      accomodation#show
    # accomodation        PATCH  /accomodation/:id(.:format)      accomodation#update
    # accomodation        PUT    /accomodation/:id(.:format)      accomodation#update
    # accomodation        DELETE /accomodation/:id(.:format)      accomodation#destroy
    resources :accomodation

    root 'site#home'



end
