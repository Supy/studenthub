FactoryGirl.define do

    sequence :cat_names do |n|
        "Test Category #{n}"
    end

    factory :category do
        name {FactoryGirl.generate(:cat_names)}
        fields({})
    end

    factory :car_category, class: Category do
        name {'Cars' + FactoryGirl.generate(:cat_names)}
        fields({
            'Make' => {required: true},
            'Body Type' => {select: ['Sedan', 'Hatchback', 'Bakkie']},
            'Fuel' => {required: true, select: ['Petrol', 'Diesel']},
            'Colour' => {}
        })
    end

end
