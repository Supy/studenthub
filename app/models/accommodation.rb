class Accommodation < ActiveRecord::Base

    # has a location
    belongs_to :location

    # enumerated types
    enum accommodation_type: [:for_rent, :for_sale, :for_sharing]
    enum dwelling_type: [:apartment, :house, :other]
    enum parking_type: [:garage, :on_property, :street]
    enum preffered_gender: [:male, :female]
    enum advertiser_type: [:owner, :agency, :current_resident]
    enum share_type: [:room_available, :bed_available]

    # validations
    validates :title, presence: true, length: { minimum: 10 }
    validates :description, presence: true, length: { in: 50..5000 }
    validates :accommodation_type, presence: true
    validates :dwelling_type, presence: true
    validates :size_sqm, numericality: { greater_than: 0 }, allow_nil: true
    validates :bedrooms, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :bathrooms, presence: true, numericality: { greater_than_or_equal_to: 0 }
    # validates :parking_type
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :available_from, presence: true, if: :for_rent? or :for_sharing?
    #validates :pets_allowed
    #validates :smoking_allowed
    #validates :preffered_gender
    validates :advertiser_type, presence: true
    validates :share_type, presence: true, if: :for_sharing?
    validates :places_available, presence: true, numericality: { greater_than: 0 }, if: Proc.new {|a| a.for_rent? or a.for_sharing? }
    validates :location_id, presence: true

    # more complex validations
    validate :available_from_must_be_sensible

    private

        def available_from_must_be_sensible
            unless available_from.nil?
                if available_from < Date.today
                    errors.add(:available_from, "can't be in the past")
                elsif available_from > (Date.today + 365)
                    errors.add(:available_from, 'must be within a years time')
                end
            end
        end
end
