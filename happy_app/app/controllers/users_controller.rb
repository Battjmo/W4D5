class UsersController < ApplicationController
  def index
    # debugger
    @user = User.all
    render :index
  end
  
  def new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login!(@user)
    else
      flash[:errors] = ["Couldn't sign up!"]
      redirect_to new_user_url
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
    render :show
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end