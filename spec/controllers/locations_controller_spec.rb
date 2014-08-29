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
                expect(assigns(:result)[:root]).to be_nil
                expect(assigns(:result)[:children]).to match_array([parent_1, parent_2, parent_3].map(&:simple))
            end
        end

        context 'with valid root id' do
            it 'returns children' do
                get :drilldown, id: parent_1.id
                expect(response).to be_success
                expect(assigns(:result)[:root]).to eq(parent_1.simple)
                expect(assigns(:result)[:children]).to match_array([child_1, child_2].map(&:simple))
            end
        end

        context 'with leaf root id' do
            it 'returns no children' do
                get :drilldown, id: grandchild_4.id
                expect(response).to be_success
                expect(assigns(:result)[:root]).to eq(grandchild_4.simple)
                expect(assigns(:result)[:children]).to match_array([])
            end
        end

        context 'with unknown root id' do
            it 'returns root parents' do
                get :drilldown, id: grandchild_4.id + 100
                expect(response).to be_success
                expect(assigns(:result)[:root]).to be_nil
                expect(assigns(:result)[:children]).to match_array([parent_1, parent_2, parent_3].map(&:simple))
            end
        end
    end

end
