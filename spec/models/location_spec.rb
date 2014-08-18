require 'rails_helper'

describe Location, :type => :model do

    it 'can be constructed' do
        expect(build(:city_location)).to be_valid
        expect(build(:city_location, latitude: nil, longitude: nil)).to be_valid
    end

    it 'is invalid if name is missing' do
        expect(build(:city_location, name: nil)).not_to be_valid
    end

    it 'is invalid if name is blank' do
        expect(build(:city_location, name: '         ')).not_to be_valid
    end

    it 'is invalid if name is short' do
        expect(build(:city_location, name: 'aa')).not_to be_valid
    end

    it 'is invalid if longitude is out of range' do
        expect(build(:city_location, longitude: 100)).not_to be_valid
        expect(build(:city_location, longitude: -100)).not_to be_valid
    end

    it 'is invalid if latitude is out of range' do
        expect(build(:city_location, latitude: 100)).not_to be_valid
        expect(build(:city_location, latitude: -100)).not_to be_valid
    end

    it 'is invalid if location is bad format' do
        expect(build(:city_location, latitude: 0, longitude: nil)).not_to be_valid
        expect(build(:city_location, latitude: nil, longitude: 0)).not_to be_valid
    end

end
