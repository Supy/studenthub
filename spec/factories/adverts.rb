FactoryGirl.define do

    factory :advert do
        title 'Something being sold'
        description 'Some long piece of descriptive text. It just seems to go on and on.'
        field_values({})
        price 12.34
        category { FactoryGirl.create(:category) }
    end

    factory :car_advert, class: Advert do
        title 'Selling my Toyota Yarris'
        description 'Some long piece of descriptive text. It just seems to go on and on.'
        field_values({
            'Make' => 'Toyota',
            'Body Type' => 'Sedan',
            'Fuel' => 'Petrol',
            'Colour' => 'Blue'
        })
        price 59_000
        category { FactoryGirl.create(:car_category) }
    end
end
