require 'rails_helper'

RSpec.describe Book, :type => :model do
    it 'can be constructed' do
        expect(build(:book)).to be_valid
        expect(build(:book, description: nil, thumbnail_url: nil)).to be_valid
    end

    it 'is invalid if title is blank' do
        expect(build(:book, title: '')).to_not be_valid
    end

    it 'is invalid if author is blank' do
        expect(build(:book, author: '')).to_not be_valid
    end
end
