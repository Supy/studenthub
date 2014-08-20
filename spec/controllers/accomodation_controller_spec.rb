require 'rails_helper'

describe AccomodationController, :type => :controller do

    describe 'GET index' do
        it 'returns http success' do
            get :index
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

end
