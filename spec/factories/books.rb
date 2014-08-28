FactoryGirl.define do
    factory :book do
        title 'Games of Strategy'
        author 'Dixit'
        description 'A summary of game theory.'
        thumbnail_url 'http://example.com/pic.png'

        factory :book_with_isbn do
            isbns { build_list :isbn, 1 }
        end
    end
end
