FactoryGirl.define do
    factory :book do
        title { Faker::Lorem.words(2..6).join(' ').titleize }
        author { Faker::Name.name }
        description { Faker::Lorem.sentences(1..3).join(' ') }
        thumbnail_url 'http://example.com/pic.png'

        factory :book_with_isbn do
            isbns { build_list :isbn, 1 }
        end
    end
end
