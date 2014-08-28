FactoryGirl.define do
  factory :textbook do
    book
    edition 1
    price 300
    condition :good
    comments 'A few scribbles on some pages, but overall good condition.'
  end
end
