class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show ,:edit]
  before_action :ensure_correct_user, only: [:edit, :update]

  def create
      @user = current_user
      @books = Book.all
      @newbook = Book.new(book_params)
      @newbook.user_id = current_user.id
    if @newbook.save
      redirect_to book_path(@newbook.id)
      flash[:notice]= 'You have creatad book successfully.'
    else
      render :index
    end
  end


  def index
      @books = Book.all
      @user = current_user
      @newbook = Book.new
  end

  def show
      @books = Book.all
      @newbook = Book.new
      @book = Book.find(params[:id])
      @user = @book.user
  end

  def edit
      @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path
      flash[:notice]= 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def ensure_correct_user
      @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def destroy
      @book = Book.find(params[:id])
      @book.destroy
      flash[:notice]= 'Book was successfully destroyed.'
      redirect_to books_path
  end
  private

  def book_params
      params.require(:book).permit(:title, :body)
  end
end
