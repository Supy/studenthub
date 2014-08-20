require 'rails_helper'

describe Accomodation, :type => :model do

    it 'can be constructed' do
        expect(build(:accomodation, :for_sale)).to be_valid
        expect(build(:accomodation, :for_rent)).to be_valid
    end

    it "can't be available in the past" do
        expect(build(:accomodation, :for_sale, available_from: Date.new(2000))).not_to be_valid
    end

    it "can't be available too far in the future" do
        expect(build(:accomodation, :for_sale, available_from: (Date.today + 365*2))).not_to be_valid
    end
end
