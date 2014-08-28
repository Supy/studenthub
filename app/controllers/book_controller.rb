class BookController < ApplicationController
    def load
        if params[:isbn].empty? or !IsbnValidators.valid_isbn?(params[:isbn])
            return redirect_to(new_textbook_path, notice: 'Invalid ISBN.')
        end

        isbn = IsbnValidators.clean_isbn(params[:isbn])

        matching_isbn = Isbn.where(isbn: isbn).first

        # Book is already in our database.
        if matching_isbn
            redirect_to(new_textbook_path(book_id: matching_isbn.book_id))
        else
            logger.info "Fetching book data from Google Books for ISBN #{isbn}."
            book_data = GoogleBooksLoader.get_for_isbn(isbn)

            # False means there was an error with Google Books API
            if book_data == false
                logger.warn "Could not fetch book data from Google Books for ISBN #{isbn}."
                redirect_to(root_path, notice: 'Could not load book data. Please try again later.')
            elsif book_data.nil?
                logger.info "No book data found for ISBN #{isbn}."
                redirect_to(new_textbook_path, notice: "We could not find a book for the ISBN #{isbn}.")
            else
                book = Book.from_google_books(book_data)
                if book and book.save
                    redirect_to(new_textbook_path(book_id: book.id))
                else
                    redirect_to(new_textbook_path, notice: "We could not find a book for the ISBN #{isbn}.")
                end
            end
        end
    end
end
