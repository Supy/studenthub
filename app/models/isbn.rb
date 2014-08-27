require 'isbn_validators'

class Isbn < ActiveRecord::Base
    belongs_to :book

    validate :correct_format_of_isbn
    validates :book, presence: true

    private

        def correct_format_of_isbn
            unless IsbnValidators.valid_isbn?(isbn)
                errors.add(:isbn, 'is not valid.')
            end
        end
end
