require 'rails_helper'

RSpec.describe Isbn do

    it 'can be constructed' do
        expect(build(:isbn)).to be_valid
    end

    # Invalid ISBNs
    context 'with an invalid ISBN' do
        context 'of incorrect type' do
            it 'should be invalid' do
                expect(build(:isbn, isbn: nil)).to_not be_valid
                expect(build(:isbn, isbn: 1234567890121)).to_not be_valid
            end
        end

        context 'of arbitrary length' do
            it 'should be invalid' do
                expect(build(:isbn, isbn: '12345678901234')).to_not be_valid
            end
        end

        context 'of length 13' do
            it 'should be invalid' do
                expect(build(:isbn, isbn: '1234567890123')).to_not be_valid
                expect(build(:isbn, isbn: 'ab12345678901')).to_not be_valid
            end
        end

        context 'of length 10' do
            it 'should be invalid' do
                expect(build(:isbn, isbn: '1234567890')).to_not be_valid
                expect(build(:isbn, isbn: 'ab12312345')).to_not be_valid
            end
        end
    end

    # Valid ISBNs
    context 'with a valid ISBN' do
        context 'of length 13' do
            it 'should be valid' do
                expect(build(:isbn, isbn: '9780393931129')).to be_valid
                expect(build(:isbn, isbn: '978 0393931129')).to be_valid
                expect(build(:isbn, isbn: '978-039-393-112-9')).to be_valid
            end
        end

        context 'of length 10' do
            it 'should be valid' do
                expect(build(:isbn, isbn: '0393931129')).to be_valid
                expect(build(:isbn, isbn: '03 9393 1129')).to be_valid
                expect(build(:isbn, isbn: '039-3931-129')).to be_valid
            end
        end
    end

    context 'with no associated book' do
        it 'should be invalid' do
            expect(build(:isbn, book: nil)).to_not be_valid
        end
    end
end