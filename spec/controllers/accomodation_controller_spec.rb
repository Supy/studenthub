require 'rails_helper'

describe AccomodationController, :type => :controller do

    describe 'GET index' do
        it 'returns http success' do
            get :index
            expect(response).to be_success
            expect(response).to render_template('index')
        end
    end

    describe 'POST create' do
        it 'returns http success' do
            post :create
            expect(response).to be_success
            expect(response).to render_template('show')
        end
    end

    describe 'GET new' do
        it 'returns http success' do
            get :new
            expect(response).to be_success
            expect(response).to render_template('new')
        end
    end

    describe 'GET edit' do
        it 'returns http success' do
            get :edit, id: 1
            expect(response).to be_success
            expect(response).to render_template('edit')
        end
    end

    describe 'GET show' do
        it 'returns http success' do
            get :show, id: 1
            expect(response).to be_success
            expect(response).to render_template('show')
        end
    end

    describe 'PATCH update' do
        it 'returns http success' do
            patch :update, id: 1
            expect(response).to be_success
            expect(response).to render_template('show')
        end
    end

    describe 'PUT update' do
        it 'returns http success' do
            put :update, id: 1
            expect(response).to be_success
            expect(response).to render_template('show')
        end
    end

    describe 'DELETE destroy' do
        it 'returns http success' do
            delete :destroy, id: 1
            expect(response).to be_success
            expect(response).to render_template('index')
        end
    end

end
