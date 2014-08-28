require 'rails_helper'

RSpec.describe Book, :type => :model do
    it 'can be constructed' do
        expect(build(:book)).to be_valid
        expect(build(:book, author: nil, description: nil, thumbnail_url: nil)).to be_valid
    end

    it 'is invalid if title is blank' do
        expect(build(:book, title: '')).to_not be_valid
    end

    describe '#from_google_books' do
        context 'with Google Books loaded data' do
            let(:valid_google_books_data) {
                {
                    'volumeInfo' => {
                        'title' => 'Games of Strategy',
                        'authors' => [
                            'Avinash K. Dixit',
                            'Susan Skeath'
                        ],
                        'industryIdentifiers' => [
                            {
                                'type' => 'ISBN_10',
                                'identifier' => '0393974219'
                            },
                            {
                                'type' => 'ISBN_13',
                                'identifier' => '9780393974218'
                            }
                        ],
                        'imageLinks' => {
                            'smallThumbnail' => 'http://bks1.books.google.co.za/books?id=u36MQgAACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api',
                            'thumbnail' => 'http://bks1.books.google.co.za/books?id=u36MQgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'
                        }
                    }
                }
            }

            context 'when all required keys are present' do
                let(:book) { Book.from_google_books(valid_google_books_data) }

                it 'should populate a valid Book model' do
                    # Inspect all attributes
                    expect(book.title).to eq('Games of Strategy')
                    expect(book.author).to eq('Avinash K. Dixit, Susan Skeath')
                    expect(book.isbns.collect(&:isbn)).to eq(%w(0393974219 9780393974218))
                    expect(book).to be_valid
                end

                it 'should automatically save ISBN numbers' do
                    expect{ book.save }.to change(Isbn, :count).by(2)
                end
            end

            context 'when missing a required key' do
                it 'should return nil Book object' do
                    valid_google_books_data['volumeInfo'].delete('title')

                    book = Book.from_google_books(valid_google_books_data)
                    expect(book).to be_nil
                end
            end

            context 'when thumbnail element is available' do
                it 'should populate thumbnail_url attribute' do
                    book = Book.from_google_books(valid_google_books_data)

                    expect(book.thumbnail_url).to eq('http://bks1.books.google.co.za/books?id=u36MQgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api')
                    expect(book).to be_valid
                end
            end

            context 'when thumbnail element is not available' do
                it 'should have nil thumbnail_url attribute' do
                    valid_google_books_data['volumeInfo'].delete('imageLinks')
                    book = Book.from_google_books(valid_google_books_data)

                    expect(book.thumbnail_url).to be_nil
                    expect(book).to be_valid
                end
            end
        end
    end
end
