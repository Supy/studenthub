require 'rails_helper'

describe Location, :type => :model do

    it 'can be constructed' do
        expect(build(:location)).to be_valid
        expect(build(:location, latitude: nil, longitude: nil)).to be_valid
    end

    it 'is invalid if name is missing' do
        expect(build(:location, name: nil)).not_to be_valid
    end

    it 'is invalid if name is blank' do
        expect(build(:location, name: '         ')).not_to be_valid
    end

    it 'is invalid if name is short' do
        expect(build(:location, name: 'aa')).not_to be_valid
    end

    it 'is invalid if longitude is out of range' do
        expect(build(:location, longitude: 100)).not_to be_valid
        expect(build(:location, longitude: -100)).not_to be_valid
    end

    it 'is invalid if latitude is out of range' do
        expect(build(:location, latitude: 100)).not_to be_valid
        expect(build(:location, latitude: -100)).not_to be_valid
    end

    it 'is invalid if location is bad format' do
        expect(build(:location, longitude: nil)).not_to be_valid
        expect(build(:location, latitude: nil)).not_to be_valid
    end

end
