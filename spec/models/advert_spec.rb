require 'rails_helper'

describe Advert do

    let(:blank_category) do
        Category.create(name: 'Cars')
    end

    let(:car_category) do
        Category.create(name: 'Cars', fields: {
            'Make' => {'required' => true},
            'Body Type' => {'select' => ['Sedan', 'Hatchback', 'Bakkie']},
            'Fuel' => {'required' => true, 'select' => ['Petrol', 'Diesel']},
            'Colour' => {}
        })
    end

    context 'when constructed correctly' do
        it 'is valid with exact price value' do
            expect(Advert.new({
                title: 'Something for sale!',
                description: 'The description of the item',
                price: 130.12,
                category: blank_category
            })).to be_valid
        end

        it 'is valid when type is swap' do
            expect(Advert.new({
                title: 'Something for sale (SWAP)!',
                description: 'The description of the item',
                price_type: :swap,
                category: blank_category
            })).to be_valid
        end

        it 'is valid when type is free' do
            expect(Advert.new({
                title: 'Something for sale (FREE)!',
                description: 'The description of the item',
                price_type: :free,
                category: blank_category
            })).to be_valid
        end

        it 'is valid when type is poa' do
            expect(Advert.new({
                title: 'Something for sale (POA)!',
                description: 'The description of the item',
                price_type: :price_on_application,
                category: blank_category
            })).to be_valid
        end
    end

    context 'when constructed incorrectly' do
        it 'is invalid with missing title' do
            expect(Advert.new({
                description: 'some description',
                price: 1,
                category: blank_category
            })).not_to be_valid
        end

        it 'is invalid with empty title' do
            expect(Advert.new({
                title: '',
                description: 'some description',
                price: 1,
                category: blank_category
            })).not_to be_valid
        end

        it 'is invalid with title that is too long' do
            expect(Advert.new({
                title: 'a' + 'title' * 20,
                description: 'some description',
                price: 1,
                category: blank_category
            })).not_to be_valid
        end

        it 'is invalid with missing description' do
            expect(Advert.new({
                title: 'some title',
                price: 1,
                category: blank_category
            })).not_to be_valid
        end

        it 'is invalid with empty description' do
            expect(Advert.new({
                title: 'some title',
                description: '',
                price: 1,
                category: blank_category
            })).not_to be_valid
        end

        it 'is invalid with description that is too long' do
            expect(Advert.new({
                title: 'some title',
                description: 'some description' * 5000,
                price: 1,
                category: blank_category
            })).not_to be_valid
        end
    end

    it 'is invalid with exact_price price type and no price' do
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            category: blank_category
        })).not_to be_valid
    end

    it 'is invalid with bad price' do
        # valid example
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 1212.12,
            category: blank_category
        })).to be_valid

        # too small
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: -11212,
            category: blank_category
        })).not_to be_valid

        # zero
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 0,
            category: blank_category
        })).not_to be_valid

        # too large
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 10_000_000,
            category: blank_category
        })).not_to be_valid
    end

    it 'must match the field definition' do


        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol',
                'Colour' => 'Blue'
            }
        })).to be_valid

        # missing optional field
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
            }
        })).to be_valid

        # missing required field
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                #'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
            }
        })).not_to be_valid

        # empty required field
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => '',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
            }
        })).not_to be_valid

        # bad select value in optional field
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Truck', # <--
                'Fuel' => 'Petrol'
            }
        })).not_to be_valid

        # bad select value in required field
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Vodka' # <--
            }
        })).not_to be_valid

        # missing required select field
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                # 'Fuel' => 'Petrol'
            }
        })).not_to be_valid

        # unknown field
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol',
                'Lol' => 'Wut'
            }
        })).not_to be_valid

        # field value too long
        expect(Advert.new({
            title: 'selling my car',
            description: 'a valid advert',
            price: 100,
            category: car_category,
            field_values: {
                'Make' => 'long' * 100,
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
            }
        })).not_to be_valid
    end

end
