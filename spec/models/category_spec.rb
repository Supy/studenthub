require 'rails_helper'

describe Category do

    it 'can be constructed' do
        expect(build(:category)).to be_valid
        expect(build(:car_category)).to be_valid
    end

    it 'is invalid without a name' do
        expect(build(:category, name: '')).not_to be_valid
        expect(build(:category, name: nil)).not_to be_valid
    end

    it 'is invalid with a two character name' do
        expect(build(:category, name: '22')).not_to be_valid
    end

    it 'can\'t have duplicate sibling names' do
        create(:category, name: 'duplicate sibling')
        expect(build(:category, name: 'duplicate sibling')).not_to be_valid
    end

    it 'is invalid with blank field name' do
        expect(build(:category, fields: { '' => {} })).not_to be_valid
    end

    it 'is invalid with unknown sub field key' do
        expect(build(:category, fields: { 'field_1' => {'lol' => 'wut'} })).not_to be_valid
    end

    it 'is invalid with empty select array' do
        expect(build(:category, fields: { 'field_1' => {'select' => []} })).not_to be_valid
    end

    it 'can form a tree' do
        p1 = create(:category, name: 'parent', fields: { 'field_1' => {} })
        c2 = create(:category, name: 'child_1', fields: { 'field_1' => {'required' => true} })
        c3 = create(:category, name: 'child_2', fields: { 'field_2' => {} })

        p1.children << c2
        p1.children << c3

        expect(p1.children).to eq([c2, c3])

        expect(p1.build_fields).to eq({ 'field_1' => {} })

        expect(c2.build_fields).to eq({ 'field_1' => {'required' => true} })

        expect(c3.build_fields).to eq({ 'field_1' => {}, 'field_2' => {} })
    end

end
