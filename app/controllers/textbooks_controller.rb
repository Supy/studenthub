class TextbooksController < ApplicationController
  before_action :set_textbook, only: [:show, :edit, :update, :destroy]

  def index
    @textbooks = Textbook.all
  end

  def show
  end

  def new
    @textbook = Textbook.new
  end

  def edit
  end

  def create
    @textbook = Textbook.new(textbook_params)

    if @textbook.save
      redirect_to @textbook, notice: 'Textbook was successfully created.'
    else
      render :new
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
