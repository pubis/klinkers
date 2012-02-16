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
end