require 'rails_helper'

describe Advert do

    let(:test_category) { Category.create(name: 'Some Category') }

    it 'can be constructed' do
        expect(Advert.new({
            title: 'Something for sale!',
            description: 'The description of the item',
            price: 130.12,
            category: test_category
        })).to be_valid

        expect(Advert.new({
            title: 'Something for sale (SWAP)!',
            description: 'The description of the item',
            price_type: :swap,
            category: test_category
        })).to be_valid

        expect(Advert.new({
            title: 'Something for sale (FREE)!',
            description: 'The description of the item',
            price_type: :free,
            category: test_category
        })).to be_valid

        expect(Advert.new({
            title: 'Something for sale (POA)!',
            description: 'The description of the item',
            price_type: :price_on_application,
            category: test_category
        })).to be_valid
    end

    it 'is invalid with bad title length' do
        expect(Advert.new({
            description: 'some description',
            price: 1,
            category: test_category
        })).not_to be_valid
        expect(Advert.new({
            title: '',
            description: 'some description',
            price: 1,
            category: test_category
        })).not_to be_valid
        expect(Advert.new({
            title: 'a' + 'title' * 20,
            description: 'some description',
            price: 1,
            category: test_category
        })).not_to be_valid
    end

    it 'is invalid with bad description length' do
        expect(Advert.new({
            title: 'some title',
            price: 1,
            category: test_category
        })).not_to be_valid
        expect(Advert.new({
            title: 'some title',
            description: '',
            price: 1,
            category: test_category
        })).not_to be_valid
        expect(Advert.new({
            title: 'some title',
            description: 'some description' * 5000,
            price: 1,
            category: test_category
        })).not_to be_valid
    end

    it 'is invalid with exact_price price type and no price' do
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            category: test_category
        })).not_to be_valid
    end

    it 'is invalid with bad price' do
        # valid example
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 1212.12,
            category: test_category
        })).to be_valid

        # too small
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: -11212,
            category: test_category
        })).not_to be_valid

        # zero
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 0,
            category: test_category
        })).not_to be_valid

        # too large
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 10_000_000,
            category: test_category
        })).not_to be_valid
    end

end
