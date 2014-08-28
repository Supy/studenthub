require 'rails_helper'

RSpec.describe Textbook, :type => :model do
    it 'should be constructable' do
        expect(build(:textbook)).to be_valid
    end

    context 'when edition is invalid' do
        it { expect(build(:textbook, edition: nil)).to_not be_valid }
        it { expect(build(:textbook, edition: 0)).to_not be_valid }
    end

    context 'when price is invalid' do
        it { expect(build(:textbook, price: nil)).to_not be_valid }
        it { expect(build(:textbook, price: -1)).to_not be_valid }
    end

    context 'when condition is invalid' do
        it { expect(build(:textbook, condition: nil)).to_not be_valid }
    end
end
