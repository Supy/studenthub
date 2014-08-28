class TextbooksController < ApplicationController
    before_action :set_textbook, only: [:show, :edit, :update, :destroy]

    def index
        @textbooks = Textbook.all
    end

    def show
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
        if @textbook.update(textbook_params)
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
