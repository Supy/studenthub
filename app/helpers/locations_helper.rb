module LocationsHelper

    def build_location_levels_for_location(location)
        location_levels = []
        unless location.nil?
            p = location.parent
            while not p.nil?
                location_levels << p.children
                p = p.parent
            end
        end
        location_levels << Location.roots

        location_levels
    end

end
