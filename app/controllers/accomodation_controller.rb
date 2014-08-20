class AccomodationController < ApplicationController

    def index
        @accomodations = Accomodation.all
    end

    def new
        @accomodation = Accomodation.new

        if ['for_sale', 'for_rent', 'for_sharing'].include? params[:type]
            @accomodation.accomodation_type = params[:type]
            render action: "new_#{params[:type]}"
        else
            render action: 'new_without_type'
        end
    end

    def create
        # first make sure accomodation_type is valid
        if not ['for_sale', 'for_rent', 'for_sharing'].include? accomodation_params['accomodation_type']
            return redirect_to new_accomodation_path
        end

        # continue
        @accomodation = Accomodation.new(accomodation_params)
        if @accomodation.save
            redirect_to @accomodation
        else
            render action: "new_#{@accomodation.accomodation_type}"
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
