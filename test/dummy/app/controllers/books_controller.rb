class BooksController < ApplicationController
  before_action :set_cache_control_headers, only: [:index, :show]
  before_action :find_book, :only => [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    set_surrogate_key_header 'books', @books.map(&:record_key)
  end

  def show
    set_surrogate_key_header @book.record_key
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(books_params)
    if @book.save
      redirect_to books_path
    else
      flash[:notice] = "failed to create book"
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(books_params)
      redirect_to book_path(@book)
    else
      flash[:notice] = "failed to update book"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      redirect_to books_path
    else
      flash[:notice] = "failed to destroy book"
      redirect_to book_path(@book)
    end
  end

  private

  def books_params
    params.require(:book).permit!
  end

  def find_book
    @book = Book.find(params[:id])
  end

end
