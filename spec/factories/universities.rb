FactoryGirl.define do
    factory :university do
        name { Faker::Lorem.words(2).join(' ').titleize }
        short_name { Faker::Lorem.characters(2).upcase }
        latitude 0
        longitude 0
    end
end
