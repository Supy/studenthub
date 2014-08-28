require 'rails_helper'

describe LocationsController, type: :controller do

    describe 'GET drilldown' do
        let!(:parent_1) { FactoryGirl.create(:location) }
        let!(:parent_2) { FactoryGirl.create(:location) }
        let!(:parent_3) { FactoryGirl.create(:location) }
        let!(:child_1) { FactoryGirl.create(:location, parent: parent_1) }
        let!(:child_2) { FactoryGirl.create(:location, parent: parent_1) }
        let!(:child_3) { FactoryGirl.create(:location, parent: parent_2) }
        let!(:grandchild_1) { FactoryGirl.create(:location, parent: child_1) }
        let!(:grandchild_2) { FactoryGirl.create(:location, parent: child_1) }
        let!(:grandchild_3) { FactoryGirl.create(:location, parent: child_1) }
        let!(:grandchild_4) { FactoryGirl.create(:location, parent: child_2) }

        context 'with no root id given' do
            it 'returns root parents' do
                get :drilldown
                expect(response).to be_success
                expect(response).to render_template 'drilldown'
                expect(assigns(:locations)).to match_array([parent_1, parent_2, parent_3])
            end
        end

        context 'with valid root id' do
            it 'returns children' do
                get :drilldown, id: parent_1.id
                expect(response).to be_success
                expect(response).to render_template 'drilldown'
                expect(assigns(:locations)).to match_array([child_1, child_2])
            end
        end

        context 'with leaf root id' do
            it 'returns no children' do
                get :drilldown, id: grandchild_4.id
                expect(response).to be_success
                expect(response).to render_template 'drilldown'
                expect(assigns(:locations)).to match_array([])
            end
        end

        context 'with unknown root id' do
            it 'returns root parents' do
                get :drilldown, id: grandchild_4.id + 100
                expect(response).to be_success
                expect(response).to render_template 'drilldown'
                expect(assigns(:locations)).to match_array([parent_1, parent_2, parent_3])
            end
        end
    end

end
