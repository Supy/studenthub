class AccomodationController < ApplicationController

    def index
        @accomodation = Accomodation.all
    end

    def new
        @accomodation = Accomodation.new
    end

    def create
        @accomodation = Accomodation.new(accomodation_params)
        if @accomodation.save
            redirect_to @accomodation
        else
            render action: 'new'
        end
    end

    def show
        @accomodation = Accomodation.find(params[:id])
    end

    def edit
        @accomodation = Accomodation.find(params[:id])
    end

    def update
        @accomodation = Accomodation.find(params[:id])
        if @accomodation.update_attributes(accomodation_params)
            redirect_to @accomodation
        else
            render action: 'edit'
        end
    end

    def destroy
        accomodation = Accomodation.find(params[:id])
        accomodation.destroy
        redirect_to accomodation_index_path, notice: "Accomodation '#{accomodation.title}' removed"
    end

    private

        def accomodation_params
            params.require(:accomodation).permit(:title, :description,
                :accomodation_type, :dwelling_type, :size_sqm, :bedrooms,
                :bathrooms, :parking_type, :price, :available_from, :price,
                :pets_allowed, :smoking_allowed, :preferred_gender,
                :advertiser_type, :share_type, :places_available, :location_id)
        end
end
