require 'rails_helper'

describe University, type: :model do

    context 'under validation' do

        it 'is invalid with missing name' do
            expect(build(:university, name: nil)).not_to be_valid
        end

        it 'is invalid with empty name' do
            expect(build(:university, name: '  ')).not_to be_valid
        end

        it 'is invalid with duplicate name' do
            create(:university, name: 'Blah Blah Blah', short_name: 'BBB')
            expect(build(:university, name: 'Blah Blah Blah', short_name: 'BBB2')).not_to be_valid
        end

        it 'is invalid with missing shortname' do
            expect(build(:university, short_name: nil)).not_to be_valid
        end

        it 'is invalid with empty shortname' do
            expect(build(:university, short_name: '    ')).not_to be_valid
        end

        it 'is invalid with duplicate shortname' do
            create(:university, name: 'Blah Blah Blah1', short_name: 'BBB')
            expect(build(:university, name: 'Blah Blah Blah2', short_name: 'BBB')).not_to be_valid
        end

    end

end
