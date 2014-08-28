require 'rails_helper'

RSpec.describe BookController, :type => :controller do

    let(:valid_session){ {} }

    describe 'POST load' do

        context 'with blank ISBN' do
            it 'redirects back to Textbook#new' do
                post :load, { isbn: '' }, valid_session
                expect(response).to redirect_to(new_textbook_path)
            end
        end

        context 'with invalid ISBN' do
            it 'redirects back to Textbooks#new' do
                post :load, { isbn: '1200354' }, valid_session
                expect(response).to redirect_to(new_textbook_path)
            end
        end

        context 'with valid ISBN' do
            context 'of existing book' do
                it 'does not create a new Book' do
                    example_book = FactoryGirl.create(:book_with_isbn)
                    expect {
                        post :load, { isbn: example_book.isbns.first.isbn }, valid_session
                    }.to_not change(Book, :count)
                end

                it 'redirects user to Textbook#new with book ID populated' do
                    example_book = FactoryGirl.create(:book_with_isbn)
                    post :load, { isbn: example_book.isbns.first.isbn }, valid_session
                    expect(response).to redirect_to(new_textbook_path(book_id: example_book.id))
                end
            end

            context 'of new book' do
                let(:example_isbn) { '9780393974218' }

                it 'redirects user to Textbook#new with book ID populated' do
                    post :load, { isbn: example_isbn }, valid_session
                    expect(response).to redirect_to(new_textbook_path(book_id: Book.last.id))
                end

                it 'saves the new book to the database' do
                    expect {
                        post :load, { isbn: example_isbn }, valid_session
                    }.to change(Book, :count).by(1)
                    expect(Book.last.title).to eq('Games of Strategy')
                end
            end
        end
    end

end
