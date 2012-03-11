class ApplicationController < ActionController::Base
  LANGUAGES = [
    {locale: 'en', language: 'English'},
    {locale: 'sv-SE', language: 'Swedish'}
  ]
  
  protect_from_forgery
  
  before_filter :detect_and_set_locale

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
  
  def detect_and_set_locale
    I18n.locale = detect_locale
  end
  
  def detect_locale
    available = LANGUAGES.map { |l| l[:locale] }
    if current_user && available.include?(current_user.locale)
      locale = current_user.locale
    else
      if params[:lang] && available.include?(params[:lang])
        locale = params[:lang]
      else
        locale = request.preferred_language_from(available)
      end
    end
    locale
  end
end
