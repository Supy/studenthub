require 'rails_helper'

# TODO: add proper specs.
RSpec.describe 'Textbooks', :type => :request do
    describe 'GET /textbooks' do
        it 'works!' do
            get textbooks_path
            expect(response.status).to be(200)
        end
    end

    describe 'GET /textbooks/:id' do
        it 'works!' do
            textbook = FactoryGirl.create(:textbook)
            get textbook_path(textbook)
            expect(response.status).to be(200)
        end
    end

    describe 'GET /textbooks/:id/edit' do
        it 'works!' do
            textbook = FactoryGirl.create(:textbook)
            get edit_textbook_path(textbook)
            expect(response.status).to be(200)
        end
    end
end
