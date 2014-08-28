class LocationsController < ApplicationController

    def drilldown
        @root = Location.find_by(id: params[:id])

        @locations = @root.nil? ? Location.roots : @root.children
    end

end
