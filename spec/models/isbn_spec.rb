require 'rails_helper'

RSpec.describe Isbn do

    it 'can be constructed' do
        expect(build(:isbn)).to be_valid
    end

    context 'with an invalid ISBN' do
        context 'of length 13' do
            it 'should be invalid' do
                expect(build(:isbn, isbn: '1234567890123')).to_not be_valid
            end
        end

        context 'of length 10' do
            it 'should be invalid' do
                expect(build(:isbn, isbn: '1234567890')).to_not be_valid
            end
        end
    end

    context 'with a valid ISBN' do
        context 'of length 13' do
            it 'should be valid' do
                expect(build(:isbn, isbn: '9780393931129')).to be_valid
            end
        end

        context 'of length 10' do
            it 'should be valid' do
                expect(build(:isbn, isbn: '0393931129')).to be_valid
            end
        end
    end

    context 'with no associated book' do
        it 'should be invalid' do
            expect(build(:isbn, book: nil)).to_not be_valid
        end
    end
end