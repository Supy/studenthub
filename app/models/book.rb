require 'google_books_loader'

class Book < ActiveRecord::Base
    has_many :isbns, dependent: :delete_all, inverse_of: :book

    accepts_nested_attributes_for :isbns

    validates :title, presence: true

    def self.from_google_books(gb_data)
        required_elements = {
            'volumeInfo_title' => [String],
            'volumeInfo_industryIdentifiers' => [Array]
        }

        if GoogleBooksLoader.has_required_elements?(gb_data, required_elements)
            book_attributes = { isbns_attributes: [] }
            book_attributes[:title] = gb_data['volumeInfo']['title']
            book_attributes[:isbns_attributes] = gb_data['volumeInfo']['industryIdentifiers'].collect{ |id| { isbn: id['identifier'] } }

            if gb_data['volumeInfo'].has_key?('authors')
                book_attributes[:author] = ([] << gb_data['volumeInfo']['authors']).flatten.join(', ')
            end

            if gb_data['volumeInfo'].has_key?('imageLinks')
                book_attributes[:thumbnail_url] = gb_data['volumeInfo']['imageLinks']['thumbnail'] || nil
            end

            Book.new(book_attributes)
        else
            nil
        end
    end
end
