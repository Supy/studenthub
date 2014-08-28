class BookController < ApplicationController
    def load
        if params[:isbn].empty? or !IsbnValidators.valid_isbn?(params[:isbn])
            return redirect_to(new_textbook_path, notice: 'Invalid ISBN.')
        end

        matching_isbn = Isbn.where(isbn: params[:isbn]).first

        # Book is already in our database.
        if matching_isbn
            redirect_to(new_textbook_path(book_id: matching_isbn.book_id))
        else
            book = Book.from_google_books(GoogleBooksLoader.get_for_isbn(params[:isbn]))

            # False means there was an error with Google Books API
            if !book
                logger.warn "Could not fetch book data from Google Books for ISBN #{params[:isbn]}."
                redirect_to(root_path, notice: 'Could not load book data. Please try again later.')
            elsif book.nil?
                redirect_to(new_textbook_path, notice: "We could not find a book for the ISBN #{params[:isbn]}.")
            else
                book.save
                redirect_to(new_textbook_path(book_id: book.id))
            end
        end
    end
end
