require 'rails_helper'

describe Category do

    it 'can be constructed' do
        expect(Category.new(name: 'Category 1')).to be_valid
    end

    it 'is invalid without a name' do
        expect(Category.new(name: '   ')).not_to be_valid
        expect(Category.new(name: nil)).not_to be_valid
    end

    it 'is invalid with a two character name' do
        expect(Category.new(name: '22')).not_to be_valid
        expect(Category.new(name: '333')).to be_valid
    end

    it 'can\'t have duplicate sibling names' do
        c = Category.create(name: 'duplicate sibling')
        expect(Category.new(name: 'duplicate sibling')).not_to be_valid
        c.destroy
    end

    it 'must have a valid fields definition' do
        # this one is okay
        expect(Category.new(name: 'Category', fields: {
            'field_1' => {},
            'field_2' => {'required' => true},
            'field_3' => {'select' => ['A', 'B', 'C']},
            'field_4' => {'required' => true, 'select' => ['D', 'F']}
        })).to be_valid

        # this one is invalid due to blank sub field names
        expect(Category.new(name: 'Category', fields: {
            '' => {}
        })).not_to be_valid

        # this one is invalid due to bad sub field option
        expect(Category.new(name: 'Category', fields: {
            'field_1' => {'lol' => 'wut'}
        })).not_to be_valid

        # this one is invalid due to bad select option
        expect(Category.new(name: 'Category', fields: {
            'field_1' => {'select'=> []}
        })).not_to be_valid
    end

    it 'can form a tree' do
        p1 = Category.create(name: 'parent', fields: { 'field_1' => {} })
        c2 = Category.create(name: 'child_1', fields: { 'field_1' => {'required' => true} })
        c3 = Category.create(name: 'child_2', fields: { 'field_2' => {} })

        p1.children << c2
        p1.children << c3

        expect(p1.children).to eq([c2, c3])

        expect(p1.build_fields).to eq({ 'field_1' => {} })

        expect(c2.build_fields).to eq({ 'field_1' => {'required' => true} })

        expect(c3.build_fields).to eq({ 'field_1' => {}, 'field_2' => {} })

        c3.destroy
        c2.destroy
        p1.destroy

    end

end
