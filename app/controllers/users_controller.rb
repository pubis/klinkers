class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def overview
    unless current_user
      redirect_to login_path
    end
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to login_path, :notice => "New user created! Please login!"
    else
      render "new"
    end
  end
end