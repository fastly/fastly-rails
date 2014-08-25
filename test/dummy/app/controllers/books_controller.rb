class BooksController < ApplicationController

  before_filter :set_cache_control_headers, only: [:index, :show]
  before_filter :find_book, :only => [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def index_with_session
    cookies[:id] = "testly"
    @books = Book.all
  end

  def show
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
    if rails_4?
      method = :update
    else
      method = :update_attributes
    end
    if @book.send(method, books_params)
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
    if rails_4?
      params.require(:book).permit!
    else
      params[:book]
    end
  end

  def find_book
    @book = Book.find(params[:id])
  end

end
