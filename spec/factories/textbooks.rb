FactoryGirl.define do
    factory :textbook do
        book
        edition { rand 1..6 }
        price { rand 1000 + 200 }
        condition :good
        comments { Faker::Lorem.sentence }
    end
end
