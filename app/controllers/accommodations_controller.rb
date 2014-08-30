class AccommodationsController < ApplicationController

    def index
        @accommodations = Accommodation.all
    end

    def new
        @accommodation = Accommodation.new
        if params[:type] and Accommodation.accommodation_types.include? params[:type]
            @accommodation.accommodation_type = params[:type]
            render action: 'new'
        else
            render action: 'new_without_type'
        end
    end

    def create
        # first make sure accommodation_type is valid
        if Accommodation.accommodation_types.include? accommodation_params['accommodation_type']
            @accommodation = Accommodation.new(accommodation_params)
            if @accommodation.save
                redirect_to @accommodation
            else
                render action: 'new'
            end
        else
            redirect_to new_accommodation_path
        end
    end

    def show
        @accommodation = Accommodation.find(params[:id])
    end

    def edit
        @accommodation = Accommodation.find(params[:id])
    end

    def update
        @accommodation = Accommodation.find(params[:id])
        if @accommodation.update_attributes(accommodation_params)
            redirect_to @accommodation
        else
            render action: 'edit'
        end
    end

    def destroy
        accommodation = Accommodation.find(params[:id])
        accommodation.destroy
        redirect_to accommodations_path, notice: "Accommodation '#{accommodation.title}' removed"
    end

    private

        def accommodation_params
            params.require(:accommodation).permit(:title, :description,
                :accommodation_type, :dwelling_type, :size_sqm, :bedrooms,
                :bathrooms, :parking_type, :price, :available_from, :price,
                :pets_allowed, :smoking_allowed, :preferred_gender,
                :advertiser_type, :share_type, :places_available, :location_id)
        end
end
