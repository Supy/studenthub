class TextbooksController < ApplicationController
    before_action :set_textbook, only: [:show, :edit, :update, :destroy]

    def index
        @textbooks = Textbook.includes(:book)
    end

    def show
        @book = @textbook.book
    end

    def new
        unless params[:book_id].blank? or (@book = Book.where(id: params[:book_id]).first).nil?
            @textbook = Textbook.new(book: @book)
            render action: 'new_with_book_id'
        else
            render action: 'new_without_book_id'
        end
    end

    def edit
        @book = @textbook.book
    end

    def create
        # Ensure associated book exists
        if Book.exists?(textbook_params[:book_id])
            @textbook = Textbook.new(textbook_params)

            if @textbook.save
                redirect_to @textbook, notice: 'Textbook was successfully created.'
            else
                render action: 'new_with_book_id'
            end
        else
            redirect_to new_textbook_path
        end
    end

    def update
        # Don't allow the book to be changed.
        new_params = textbook_params
        new_params.delete(:book_id)

        if @textbook.update(new_params)
            redirect_to @textbook, notice: 'Textbook was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @textbook.destroy
        redirect_to textbooks_url, notice: 'Textbook was successfully destroyed.'
    end

    private

        def set_textbook
            @textbook = Textbook.find(params[:id])
        end

        def textbook_params
            params.require(:textbook).permit(:book_id, :edition, :price, :condition, :comments)
        end
end
