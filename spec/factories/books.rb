# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title 'Games of Strategy'
    author 'Dixit'
    description 'A summary of game theory.'
    thumbnail_url 'http://example.com/pic.png'
  end
end
