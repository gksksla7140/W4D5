class SessionsController < ApplicationController

  def new
    @user = User.new
  end


  def create
    credentials = [user_params[:username], user_params[:password]]
    @user = User.find_by_credentials(*credentials)
    if @user
      login!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = ['Invalid credentials']
      render :new 
    end
  end


  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
