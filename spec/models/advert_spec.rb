require 'rails_helper'

describe Advert do

    let(:blank_category) { create(:category, name: 'Cars') }

    let(:car_category) { create(:car_category, name: 'Cars') }

    context 'when constructed correctly' do
        it 'is valid with exact price value' do
            expect(build(:car_advert, category: car_category)).to be_valid
        end

        it 'is valid when type is swap' do
            expect(build(:car_advert, category: car_category, price_type: :swap)).to be_valid
        end

        it 'is valid when type is free' do
            expect(build(:car_advert, category: car_category, price_type: :free)).to be_valid
        end

        it 'is valid when type is poa' do
            expect(build(:car_advert, category: car_category, price_type: :price_on_application)).to be_valid
        end
    end

    context 'when constructed incorrectly' do
        it 'is invalid with missing title' do
            expect(build(:car_advert, category: car_category, title: nil)).not_to be_valid
        end

        it 'is invalid with empty title' do
            expect(build(:car_advert, category: car_category, title: '  ')).not_to be_valid
        end

        it 'is invalid with title that is too long' do
            expect(build(:car_advert, category: car_category, title: 'a' * 141)).not_to be_valid
        end

        it 'is invalid with missing description' do
            expect(build(:car_advert, category: car_category, description: nil)).not_to be_valid
        end

        it 'is invalid with empty description' do
            expect(build(:car_advert, category: car_category, description: '')).not_to be_valid
        end

        it 'is invalid with description that is too long' do
            expect(build(:car_advert, category: car_category, description: 'some description' * 5000)).not_to be_valid
        end

        it 'is invalid with exact_price price type and no price' do
            expect(build(:car_advert, category: car_category, price: nil)).not_to be_valid
        end

        it 'is invalid with negative price' do
            expect(build(:car_advert, category: car_category, price: -1)).not_to be_valid
        end

        it 'is invalid with zero price' do
            expect(build(:car_advert, category: car_category, price: 0)).not_to be_valid
        end

        it 'is invalid with price that is too high' do
            expect(build(:car_advert, category: car_category, price: 10_000_000)).not_to be_valid
        end
    end

    it 'is valid with missing optional field' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
        })).to be_valid
    end

    it 'is invalid with missing required field' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
        })).not_to be_valid
    end

    it 'is invalid with empty required field' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Make' => '  ',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
        })).not_to be_valid
    end

    it 'is invalid with bad select field (optional)' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Truck', # <--
                'Fuel' => 'Petrol'
        })).not_to be_valid
    end

    it 'is invalid with bad select field (required)' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Vodka' # <--
        })).not_to be_valid
    end

    it 'is invalid with missing required select field' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan'
        })).not_to be_valid
    end

    it 'is invalid with unknown field' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Make' => 'Toyota',
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol',
                'Lol' => 'Wut'
        })).not_to be_valid
    end

    it 'is invalid with too long field' do
        expect(build(:car_advert, category: car_category, field_values: {
                'Make' => 'long' * 100,
                'Body Type' => 'Sedan',
                'Fuel' => 'Petrol'
        })).not_to be_valid
    end
end
