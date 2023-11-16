class BooksController < ApplicationController
  def new
    @book = Book.new
  end 
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      
      @user = current_user
      @books = Book.all
      render :index
      @book = Book.new
    end
  end 
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = current_user
    @book = Book.new
    @book_show = Book.find(params[:id])
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path
  end 
  
  def destroy
    book_show = Book.find(params[:id])
    book_show.destroy
    redirect_to books_path
  end 
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end 
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end 
  end
  
end
