require 'rails_helper'

describe Advert do

    it 'can be constructed' do
        expect(Advert.new).to be_valid
    end

end
