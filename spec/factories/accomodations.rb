FactoryGirl.define do
    factory :accomodation, class: Accomodation do
        title 'Awesome accomodation'
        description 'This is an awesome place! Filled with awesome people'
        available_from Date.new(2014, 9, 9)
        bedrooms 3
        bathrooms 2
        association :location, factory: :suburb_location
        advertiser_type :current_resident

        trait :for_sale do
            accomodation_type :for_sale
            dwelling_type :house
            size_sqm 600
            parking_type :garage
            price 700_000
        end

        trait :for_rent do
            accomodation_type :for_rent
            dwelling_type :apartment
            size_sqm 400
            parking_type :garage
            price 4000.12

            pets_allowed false
            smoking_allowed true
            preferred_gender :male
            places_available 2
        end

        trait :for_share do
            accomodation_type :sharing
            dwelling_type :apartment
            size_sqm 200
            places_available 1
            share_type :home_share
        end
    end
end
