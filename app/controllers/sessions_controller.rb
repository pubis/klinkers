class SessionsController < ApplicationController
  def new
    redirect_to overview_path if current_user
  end
  
  def create
    user = User.find_by_email(params[:username_or_email]) || User.find_by_username(params[:username_or_email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to overview_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid username/email or password"
      render "new"
    end
  end    

  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => "Logged out!"
  end
end