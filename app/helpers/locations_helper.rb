module LocationsHelper

    def build_location_levels_for_location(location)
        location_levels = []
        unless location.nil?
            # first add children
            location = location.reload
            unless location.leaf?
                location_levels.unshift(({
                    items: location.children.to_a,
                    selected: nil
                }))
            end

            p = location
            while p.child?
                location_levels.unshift(({
                    items: p.self_and_siblings.to_a,
                    selected: p.id
                }))
                p = p.parent
            end
        end
        location_levels.unshift(({
            items: Location.roots.to_a,
            selected: location.nil? ? nil : p.id
        }))

        location_levels
    end

end
