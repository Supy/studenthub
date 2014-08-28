FactoryGirl.define do
    factory :accommodation, class: Accommodation do
        title { Faker::Lorem.sentence }
        description { Faker::Lorem.paragraph }
        available_from Date.new(2014, 9, 9)
        bedrooms { rand 1..4 }
        bathrooms { rand 1..4 }
        association :location, factory: :suburb_location
        advertiser_type :current_resident

        trait :for_sale do
            accommodation_type :for_sale
            dwelling_type :house
            size_sqm 600
            parking_type :garage
            price { rand 800_000 + 300_000 }
        end

        trait :for_rent do
            accommodation_type :for_rent
            dwelling_type :apartment
            size_sqm 400
            parking_type :garage
            price { rand 10_000 + 2000 }

            pets_allowed false
            smoking_allowed true
            preferred_gender :male
            places_available 2
        end

        trait :for_share do
            accommodation_type :for_sharing
            dwelling_type :apartment
            size_sqm 200
            price { rand 10_000 + 2000 }
            places_available 1
            share_type :room_available
        end
    end
end
