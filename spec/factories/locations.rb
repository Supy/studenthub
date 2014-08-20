FactoryGirl.define do
    factory :city_location, class: Location do
        name 'City'
        longitude 13.333
        latitude -24.111
    end

    factory :suburb_location, class: Location do
        name 'Suburb'
        longitude 14.01
        latitude -25.99
        association :parent, factory: :city_location
    end
end
