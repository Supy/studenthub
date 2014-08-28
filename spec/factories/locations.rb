FactoryGirl.define do
    factory :location do
        name { Faker::Address.city }
        latitude { rand * 180 - 90 }
        longitude { rand * 180 - 90 }
    end

    factory :suburb_location, class: Location do
        name { Faker::Address.city }
        latitude { rand * 180 - 90 }
        longitude { rand * 180 - 90 }
        association :parent, factory: :location
    end
end
