require 'rails_helper'

describe Accomodation, :type => :model do

    it 'can be constructed' do
        expect(build(:accomodation, :for_sale)).to be_valid
        expect(build(:accomodation, :for_rent)).to be_valid
    end

end
