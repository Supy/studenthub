require 'rails_helper'

describe AccommodationsController, type: :controller do

    describe 'GET index' do
        let!(:list) do
            [
                FactoryGirl.create(:accommodation, :for_sale),
                FactoryGirl.create(:accommodation, :for_rent)
            ]
        end

        it 'returns http success' do
            get :index
            expect(response).to be_success
            expect(response).to render_template 'index'
            expect(list).to eq(assigns(:accommodations))
        end
    end

    describe 'POST create' do
        let(:good_attrs) do
            tmp = FactoryGirl.build(:accommodation, :for_share).attributes
            tmp['accommodation_type'] = :for_sharing
            tmp['dwelling_type'] = :apartment
            tmp['share_type'] = :room_available
            tmp['advertiser_type'] = :current_resident
            tmp
        end

        it 'redirects to show upon successful create' do
            expect do
                post :create, accommodation: good_attrs
            end.to change(Accommodation, :count).by(1)
            expect(response).to be_redirect
            expect(response).to redirect_to accommodation_path(Accommodation.last)
        end

        it 'renders new upon bad create' do
            bad_attrs = good_attrs
            bad_attrs['price'] = -100
            expect do
                post :create, accommodation: bad_attrs
            end.not_to change(Accommodation, :count)
            expect(response).to be_success
            expect(response).to render_template 'new'
        end

        it 'renders new when bad type' do
            bad_attrs = good_attrs
            bad_attrs['accommodation_type'] = 'unknown'
            expect do
                post :create, accommodation: bad_attrs
            end.not_to change(Accommodation, :count)
            expect(response).to be_redirect
            expect(response).to redirect_to new_accommodation_path
        end
    end

    describe 'GET new' do
        it 'returns http success if type is specified' do
            get :new, type: 'for_sale'
            expect(response).to be_success
            expect(response).to render_template 'new'
            expect(assigns(:accommodation).id).to be_nil
            expect(assigns(:accommodation).accommodation_type).to eq('for_sale')
        end

        it 'renders type select if no type provided' do
            get :new
            expect(response).to be_success
            expect(response).to render_template 'new_without_type'
            expect(assigns(:accommodation).id).to be_nil
        end
    end

    describe 'GET edit' do
        let(:test_accommodation) { FactoryGirl.create :accommodation, :for_sale }

        it 'returns http success' do
            get :edit, id: test_accommodation.id
            expect(response).to be_success
            expect(response).to render_template 'edit'
            expect(test_accommodation).to eq(assigns(:accommodation))
        end
    end

    describe 'GET show' do
        let(:test_accommodation) { FactoryGirl.create :accommodation, :for_sale }

        it 'returns http success' do
            get :show, id: test_accommodation.id
            expect(response).to be_success
            expect(response).to render_template 'show'
            expect(test_accommodation).to eq(assigns(:accommodation))
        end
    end

    describe 'PATCH update' do
        let(:test_accommodation) { FactoryGirl.create :accommodation, :for_sale }

        it 'redirects to show upon successful patch' do
            patch :update, id: test_accommodation.id, accommodation: { 'price' => 45212.12 }
            expect(response).to be_redirect
            expect(response).to redirect_to test_accommodation
        end

        it 'redirects to edit upon bad patch' do
            patch :update, id: test_accommodation.id, accommodation: { 'price' => -1 }
            expect(response).to be_success
            expect(response).to render_template 'edit'
        end
    end

    describe 'PUT update' do
        let!(:test_accommodation) { FactoryGirl.create :accommodation, :for_sale }
        let(:good_attrs) do
            tmp = FactoryGirl.build(:accommodation, :for_share).attributes
            tmp['accommodation_type'] = :for_sharing
            tmp['dwelling_type'] = :apartment
            tmp['share_type'] = :room_available
            tmp['advertiser_type'] = :current_resident
            tmp['advertiser_type'] = :owner
            tmp['location'] = FactoryGirl.create(:location).id
            tmp['available_from'] = Date.new(2015,1,1)
            tmp
        end

        it 'redirects to show upon successful patch' do
            put :update, id: test_accommodation.id, accommodation: good_attrs
            expect(response).to be_redirect
            expect(response).to redirect_to test_accommodation
        end
    end

    describe 'DELETE destroy' do
        let(:test_accommodation) { FactoryGirl.create :accommodation, :for_sale }

        it 'correctly destroys the instance' do
            delete :destroy, id: test_accommodation.id
            expect(response).to be_redirect
            expect(response).to redirect_to accommodations_path
            expect(Accommodation.exists? test_accommodation.id).to eq(false)
        end
    end

end
