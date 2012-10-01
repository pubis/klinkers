class ApplicationController < ActionController::Base
  include Tounge::LocaleControl

  LANGUAGES = [
    {locale: 'en', language: 'English'},
    {locale: 'sv-se', language: 'Swedish'}
  ]
  
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_path, :alert => exception.message
    else
      redirect_to login_path, :alert => exception.message
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
