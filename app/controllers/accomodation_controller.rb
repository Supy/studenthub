class AccomodationController < ApplicationController

    def index
    end

    def new
    end

    def create
        render action: 'show'
    end

    def show

    end

    def update
        render action: 'show'
    end

    def destroy
        render action: 'index'
    end

end
