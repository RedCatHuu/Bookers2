class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
  end

  def index
    @book = Book.new
    @user = current_user
  end
end
