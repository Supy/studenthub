require 'rails_helper'

describe LocationsHelper do

    describe 'build_location_levels_for_location' do
        let!(:parent_1) { FactoryGirl.create(:location) }
        let!(:parent_2) { FactoryGirl.create(:location) }
        let!(:child_1) { FactoryGirl.create(:location, parent: parent_1) }
        let!(:child_2) { FactoryGirl.create(:location, parent: parent_1) }
        let!(:child_3) { FactoryGirl.create(:location, parent: parent_2) }
        let!(:grandchild_1) { FactoryGirl.create(:location, parent: child_1) }
        let!(:grandchild_2) { FactoryGirl.create(:location, parent: child_1) }
        let!(:grandchild_3) { FactoryGirl.create(:location, parent: child_2) }

        context 'when location is nil' do
            it 'returns roots' do
                r = build_location_levels_for_location(nil)
                ritems = r.map { |i| i[:items].to_a }
                rselects = r.map { |i| i[:selected] }
                ritems.zip([[parent_1, parent_2]]).each do |i1, i2|
                    expect(i1).to match_array(i2)
                end
                expect(rselects).to eq([nil])
            end
        end

        context 'when location is node' do
            it 'returns expected tree' do
                r = build_location_levels_for_location(child_1)
                e = [[parent_1, parent_2], [child_1, child_2], [grandchild_1, grandchild_2]]
                ritems = r.map { |i| i[:items].to_a }
                rselects = r.map { |i| i[:selected] }
                ritems.zip(e).each do |i1, i2|
                    expect(i1).to match_array(i2)
                end
                expect(rselects).to eq([parent_1.id, child_1.id, nil])
            end

            it 'returns expected tree' do
                r = build_location_levels_for_location(child_2)
                e = [[parent_1, parent_2], [child_1, child_2], [grandchild_3]]
                ritems = r.map { |i| i[:items].to_a }
                rselects = r.map { |i| i[:selected] }
                ritems.zip(e).each do |i1, i2|
                    expect(i1).to match_array(i2)
                end
                expect(rselects).to eq([parent_1.id, child_2.id, nil])
            end
        end

        context 'when location is leaf' do
            it 'returns expected tree' do
                r = build_location_levels_for_location(grandchild_1)
                e = [[parent_1, parent_2], [child_1, child_2], [grandchild_1, grandchild_2]]
                ritems = r.map { |i| i[:items].to_a }
                rselects = r.map { |i| i[:selected] }
                ritems.zip(e).each do |i1, i2|
                    expect(i1).to match_array(i2)
                end
                expect(rselects).to eq([parent_1.id, child_1.id, grandchild_1.id])
            end
        end


    end

end
