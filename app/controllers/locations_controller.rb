class LocationsController < ApplicationController

    def drilldown
        root = Location.find_by(id: params[:id])
        children = root.nil? ? Location.roots : root.children

        render json: {
            root: root.nil? ? nil : root.simple,
            children: children.map { |c| c.simple  }
        }
    end

end
