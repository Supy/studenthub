require 'rails_helper'

RSpec.describe TextbooksController, :type => :controller do

    let(:valid_session) { {} }

    describe 'GET index' do
        it 'assigns all textbooks as @textbooks' do
            textbook = FactoryGirl.create(:textbook)
            get :index, {}, valid_session
            expect(assigns(:textbooks)).to eq([textbook])
        end

        it 'renders the "index" template' do
            get :index, {}, valid_session
            expect(response).to render_template 'index'
        end
    end

    describe 'GET show' do
        let(:textbook) { FactoryGirl.create(:textbook) }

        it 'assigns the requested textbook as @textbook' do
            get :show, { id: textbook.to_param }, valid_session
            expect(assigns(:textbook)).to eq(textbook)
        end

        it 'renders the "show" template' do
            get :show, { id: textbook.to_param }, valid_session
            expect(response).to render_template 'show'
        end
    end

    describe 'GET new' do
        context 'when book ID is not supplied' do
            it 'renders the "new_without_book_id" template' do
                get :new, {}, valid_session
                expect(response).to render_template 'new_without_book_id'
            end
        end

        context 'when book ID is supplied' do
            let(:book){ FactoryGirl.create(:book) }

            it 'assigns a new textbook as @textbook' do
                get :new, { book_id: book.id }, valid_session
                expect(assigns(:textbook)).to be_a_new(Textbook)
            end

            it 'renders the "new_with_book_id" template' do
                get :new, { book_id: book.id }, valid_session
                expect(response).to render_template 'new_with_book_id'
            end
        end
    end

    describe 'GET edit' do
        let(:textbook){ FactoryGirl.create(:textbook) }

        it 'assigns the requested textbook as @textbook' do
            get :edit, { id: textbook.to_param }, valid_session
            expect(assigns(:textbook)).to eq(textbook)
        end

        it 'renders the "edit" template' do
            get :edit, { id: textbook.to_param }, valid_session
            expect(response).to render_template 'edit'
        end
    end

    describe 'POST create' do
        context 'with invalid book ID' do
            let(:textbook_attributes){
                attributes = FactoryGirl.build(:textbook, book_id: 200).attributes
                attributes[:condition] = :ok
                attributes
            }

            it 'does not create a new Textbook' do
                expect {
                    post :create, { textbook: textbook_attributes }, valid_session
                }.to_not change(Textbook, :count)
            end

            it 'redirects back to #new' do
                post :create, { textbook: textbook_attributes }, valid_session
                expect(response).to redirect_to(new_textbook_path)
            end
        end

        context 'with valid params' do
            let(:valid_attributes) {
                attributes = FactoryGirl.build(:textbook).attributes
                attributes[:condition] = :ok
                attributes
            }

            it 'creates a new Textbook' do
                expect {
                    post :create, { textbook: valid_attributes }, valid_session
                }.to change(Textbook, :count).by(1)
            end

            it 'assigns a newly created textbook as @textbook' do
                post :create, { textbook: valid_attributes }, valid_session
                expect(assigns(:textbook)).to be_a(Textbook)
                expect(assigns(:textbook)).to be_persisted
            end

            it 'redirects to the created textbook' do
                post :create, { textbook: valid_attributes }, valid_session
                expect(response).to redirect_to(Textbook.last)
            end
        end

        context 'with invalid params' do
            let(:invalid_attributes) {
                attributes = FactoryGirl.build(:textbook, price: nil).attributes
                attributes[:condition] = :ok
                attributes
            }

            it 'assigns a newly created but unsaved textbook as @textbook' do
                post :create, { textbook: invalid_attributes }, valid_session
                expect(assigns(:textbook)).to be_a_new(Textbook)
                expect(assigns(:textbook)).to_not be_persisted
            end

            it 're-renders the "new" template' do
                post :create, { textbook: invalid_attributes }, valid_session
                expect(response).to render_template 'new_with_book_id'
            end
        end
    end

    describe 'PUT update' do
        let(:textbook){ FactoryGirl.create(:textbook) }

        context 'with valid params' do
            let(:new_attributes) { { price: 500 } }
            let(:valid_attributes) { FactoryGirl.attributes_for(:textbook) }

            it 'updates the requested textbook' do
                put :update, { id: textbook.to_param, textbook: new_attributes }, valid_session
                textbook.reload
                expect(textbook.price).to eq(500)
            end

            it 'assigns the requested textbook as @textbook' do
                put :update, { id: textbook.to_param, textbook: valid_attributes }, valid_session
                expect(assigns(:textbook)).to eq(textbook)
            end

            it 'redirects to the textbook' do
                put :update, { id: textbook.to_param, textbook: valid_attributes }, valid_session
                expect(response).to redirect_to(textbook)
            end
        end

        context 'with invalid params' do
            let(:invalid_attributes) { FactoryGirl.attributes_for(:textbook, price: nil) }

            it 'assigns the textbook as @textbook' do
                put :update, { id: textbook.to_param, textbook: invalid_attributes }, valid_session
                expect(assigns(:textbook)).to eq(textbook)
            end

            it 're-renders the "edit" template' do
                put :update, { id: textbook.to_param, textbook: invalid_attributes }, valid_session
                expect(response).to render_template 'edit'
            end
        end
    end

    describe 'DELETE destroy' do
        before(:each) { @textbook = FactoryGirl.create(:textbook) }

        it 'destroys the requested textbook' do
            expect {
                delete :destroy, { id: @textbook.to_param }, valid_session
            }.to change(Textbook, :count).by(-1)
        end

        it 'redirects to the textbooks list' do
            delete :destroy, { id: @textbook.to_param }, valid_session
            expect(response).to redirect_to(textbooks_url)
        end
    end

end
