class BooksController < ApplicationController
  before_action :book_edit_check, only: [:edit]

  def index
    @books = Book.all
    @new_book = Book.new
    @user = current_user
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user= @book.user
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@new_book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def book_edit_check
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

end
