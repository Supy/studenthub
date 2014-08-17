require 'rails_helper'

describe Advert do

    it 'can be constructed' do
        expect(Advert.new({
            title: 'Something for sale!',
            description: 'The description of the item',
            price: 130.12
        })).to be_valid
    end

    it 'is invalid with bad title length' do
        expect(Advert.new(description: 'some description', price: 1)).not_to be_valid
        expect(Advert.new(title: '', description: 'some description', price: 1)).not_to be_valid
        expect(Advert.new({
            title: 'a' + 'title' * 20,
            description: 'some description',
            price: 1
        })).not_to be_valid
    end

    it 'is invalid with bad description length' do
        expect(Advert.new(title: 'some title', price: 1)).not_to be_valid
        expect(Advert.new(title: 'some title', description: '', price: 1)).not_to be_valid
        expect(Advert.new({
            title: 'some title',
            description: 'some description' * 5000,
            price: 1
        })).not_to be_valid
    end

    it 'is invalid with exact_price price type and no price' do
        expect(Advert.new({
            title: 'some title',
            description: 'some description'
        })).not_to be_valid
    end

    it 'is invalid with bad price' do
        # too small
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: -11212
        })).not_to be_valid

        # zero
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 0
        })).not_to be_valid

        # too large
        expect(Advert.new({
            title: 'some title',
            description: 'some description',
            price: 10_000_000
        })).not_to be_valid
    end

end
