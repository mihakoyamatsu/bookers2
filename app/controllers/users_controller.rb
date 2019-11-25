class UsersController < ApplicationController
 before_action :authenticate_user!, only: [:show, :index, :edit]
 before_action :ensure_correct_user, only: [:edit, :update]


  def index
      @newbook= Book.new
      @user = current_user
      @users = User.all
  end
  def show
      @user = User.find(params[:id])
      @newbook = Book.new
      #@books = @user.books
  end

  def edit
      @user =User.find(params[:id])
  end

  def update
  	  @user = User.find(params[:id])
  	if @user.update(user_params)
  	  redirect_to user_path
  	  flash[:notice]= 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def ensure_correct_user
      @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end


  private
  def  user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end