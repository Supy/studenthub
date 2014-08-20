require 'rails_helper'

describe AccomodationController, :type => :controller do

    describe 'GET index' do
        let!(:list) do
            [
                FactoryGirl.create(:accomodation, :for_sale),
                FactoryGirl.create(:accomodation, :for_rent)
            ]
        end

        it 'returns http success' do
            get :index
            expect(response).to be_success
            expect(response).to render_template 'index'
            expect(list).to eq(assigns(:accomodation))
        end
    end

    describe 'POST create' do
        let(:good_attrs) do
            tmp = FactoryGirl.build(:accomodation, :for_share).attributes
            tmp['accomodation_type'] = :for_sharing
            tmp['dwelling_type'] = :apartment
            tmp['share_type'] = :room_available
            tmp['advertiser_type'] = :current_resident
            tmp
        end

        it 'redirects to show upon successful create' do
            expect do
                post :create, accomodation: good_attrs
            end.to change(Accomodation, :count).by(1)
            expect(response).to be_redirect
            expect(response).to redirect_to accomodation_path(Accomodation.last)
        end

        it 'renders new upon bad create' do
            bad_attrs = good_attrs
            bad_attrs['price'] = -100
            expect do
                post :create, accomodation: bad_attrs
            end.not_to change(Accomodation, :count)
            expect(response).to be_success
            expect(response).to render_template 'new'
        end
    end

    describe 'GET new' do
        it 'returns http success' do
            get :new
            expect(response).to be_success
            expect(response).to render_template 'new'
            expect(assigns(:accomodation).id).to be_nil
        end
    end

    describe 'GET edit' do
        let(:test_accomodation) { FactoryGirl.create :accomodation, :for_sale }

        it 'returns http success' do
            get :edit, id: test_accomodation.id
            expect(response).to be_success
            expect(response).to render_template 'edit'
            expect(test_accomodation).to eq(assigns(:accomodation))
        end
    end

    describe 'GET show' do
        let(:test_accomodation) { FactoryGirl.create :accomodation, :for_sale }

        it 'returns http success' do
            get :show, id: test_accomodation.id
            expect(response).to be_success
            expect(response).to render_template 'show'
            expect(test_accomodation).to eq(assigns(:accomodation))
        end
    end

    describe 'PATCH update' do
        let(:test_accomodation) { FactoryGirl.create :accomodation, :for_sale }

        it 'redirects to show upon successful patch' do
            patch :update, id: test_accomodation.id, accomodation: { 'price' => 45212.12 }
            expect(response).to be_redirect
            expect(response).to redirect_to test_accomodation
        end

        it 'redirects to edit upon bad patch' do
            patch :update, id: test_accomodation.id, accomodation: { 'price' => -1 }
            expect(response).to be_success
            expect(response).to render_template 'edit'
        end
    end

    describe 'PUT update' do
        let!(:test_accomodation) { FactoryGirl.create :accomodation, :for_sale }
        let(:good_attrs) do
            tmp = FactoryGirl.build(:accomodation, :for_share).attributes
            tmp['accomodation_type'] = :for_sharing
            tmp['dwelling_type'] = :apartment
            tmp['share_type'] = :room_available
            tmp['advertiser_type'] = :current_resident
            tmp['title'] = 'Some Different Digs Title'
            tmp['description'] = 'A more awesome description than what it was. This is better!'
            tmp['bedrooms'] = 4
            tmp['bathrooms'] = 5
            tmp['advertiser_type'] = :owner
            tmp['location'] = FactoryGirl.create(:city_location).id
            tmp['available_from'] = Date.new(2015,1,1)
            tmp
        end

        it 'redirects to show upon successful patch' do
            put :update, id: test_accomodation.id, accomodation: good_attrs
            expect(response).to be_redirect
            expect(response).to redirect_to test_accomodation
        end
    end

    describe 'DELETE destroy' do
        let(:test_accomodation) { FactoryGirl.create :accomodation, :for_sale }

        it 'correctly destroys the instance' do
            delete :destroy, id: test_accomodation.id
            expect(response).to be_redirect
            expect(response).to redirect_to accomodation_index_path
            expect(Accomodation.exists? test_accomodation.id).to eq(false)
        end
    end

end
