require 'rails_helper'

describe Advert do

    it 'can be constructed' do
        expect(Advert.new({
            title: 'Something for sale!',
            description: 'The description of the item'
        })).to be_valid
    end

end
