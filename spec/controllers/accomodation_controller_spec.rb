require 'rails_helper'

describe AccomodationController, :type => :controller do

    describe 'GET index' do
        it 'returns http success' do
            get :index
            expect(response).to be_success
        end
    end

    describe 'POST index' do
        it 'returns http success' do
            post :index
            expect(response).to be_success
        end
    end

    describe 'GET new' do
        it 'returns http success' do
            get :new
            expect(response).to be_success
        end
    end

    describe 'GET edit' do
        it 'returns http success' do
            get :edit, id: 1
            expect(response).to be_success
        end
    end

    describe 'GET show' do
        it 'returns http success' do
            get :show, id: 1
            expect(response).to be_success
        end
    end

    describe 'PATCH update' do
        it 'returns http success' do
            patch :update, id: 1
            expect(response).to be_success
        end
    end

    describe 'PUT update' do
        it 'returns http success' do
            put :update, id: 1
            expect(response).to be_success
        end
    end

    describe 'DELETE destroy' do
        it 'returns http success' do
            delete :destroy, id: 1
            expect(response).to be_success
        end
    end

end
