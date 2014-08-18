class Location < ActiveRecord::Base
    """
    A Location is a specific area. It has a :name and a location (:longitude,
    :latitude). Locations are stored as a tree so that a City has a number of
    sub locations (suburbs/districts).
    """

    acts_as_tree order: 'name'

    validates :name, presence: true, allow_blank: false
    validates :name, length: {minimum: 3}
    validate :location_is_valid_or_blank

    private

        def location_is_valid_or_blank
            if longitude.nil? and latitude.nil?
                # nothing wrong with this
            elsif longitude.nil?
                errors.add(:longitude, 'Location must be provided as both latitude and longitude')
            elsif latitude.nil?
                errors.add(:latitude, 'Location must be provided as both latitude and longitude')
            elsif longitude < -90 or longitude > 90
                errors.add(:longitude, 'Longitude must be >= -90 and <= 90')
            elsif latitude < -90 or latitude > 90
                errors.add(:latitude, 'Latitude must be >= -90 and <= 90')
            end
        end
end
