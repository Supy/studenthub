Rails.application.routes.draw do
    get 'site/home'

    # Accommodation can be handled as a CRUD resource:
    # accommodation_index  GET    /accommodations(.:format)          accommodations#index
    # accommodation_index  POST   /accommodations(.:format)          accommodations#create
    # new_accommodation    GET    /accommodations/new(.:format)      accommodations#new
    # edit_accommodation   GET    /accommodations/:id/edit(.:format) accommodations#edit
    # accommodations        GET    /accommodations/:id(.:format)      accommodations#show
    # accommodations        PATCH  /accommodations/:id(.:format)      accommodations#update
    # accommodations        PUT    /accommodations/:id(.:format)      accommodations#update
    # accommodations        DELETE /accommodations/:id(.:format)      accommodations#destroy
    resources :accommodations

    root 'site#home'



end
