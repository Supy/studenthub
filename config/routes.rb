Rails.application.routes.draw do
    get 'site/home'
    root 'site#home'
end
