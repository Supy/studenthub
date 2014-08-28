require 'spec_helper'
require 'google_books_loader'

RSpec.describe GoogleBooksLoader do

    describe '#get_for_isbn' do
        context 'with valid ISBN' do
            it 'returns the corresponding book' do
                returned_book = GoogleBooksLoader.get_for_isbn('0393974219')
                expect(returned_book.has_key?('volumeInfo')).to be true
            end
        end

        context 'with invalid ISBN' do
            it 'returns nil' do
                returned_book = GoogleBooksLoader.get_for_isbn('1111')
                expect(returned_book).to be_nil
            end
        end
    end

    describe '#has_required_elements?' do
        context 'with data returned from Google Books API' do
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

            let(:required_elements) {
                {
                    'volumeInfo_title' => [String],
                    'volumeInfo_authors' => [String, Array],
                    'volumeInfo_industryIdentifiers' => [Array]
                }
            }

            context 'when all required elements are present' do
                it 'returns true' do
                    expect(GoogleBooksLoader.has_required_elements?(valid_google_books_data, required_elements)).to be true
                end
            end

            context 'when a required element is not of the correct type' do
                it 'returns false' do
                    required_elements['volumeInfo_title'] = [Array]
                    expect(GoogleBooksLoader.has_required_elements?(valid_google_books_data, required_elements)).to be false
                end
            end

            context 'when a required element is empty' do
                it 'returns false' do
                    valid_google_books_data['volumeInfo']['title'] = ''
                    expect(GoogleBooksLoader.has_required_elements?(valid_google_books_data, required_elements)).to be false
                end
            end
        end
    end
end