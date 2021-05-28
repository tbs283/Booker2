class UsersController < ApplicationController
  before_action :user_edit_check, only: [:edit]

  def index
    @books = Book.all
    @new_book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user= User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def user_edit_check
    @user = User.find(params[:id])
    @user_now = current_user
    if @user != current_user
      redirect_to user_path(@user_now)
    end
  end

end