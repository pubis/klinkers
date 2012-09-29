module LocaleSetter

  LOOKUP_CHAIN = [:params, :user, :session, :http, :default]

  def self.set_by(inputs)
    locale = nil
    LOOKUP_CHAIN.each do |lookup|
      if inputs[lookup]
        locale = send("by_#{lookup}", inputs[lookup])
        break if locale
      end
    end
    I18n.locale = locale
  end

  def self.by_default(default = I18n.default_locale)
    default
  end

  def self.by_params(params)
    locale = params[:locale]
    locale if locale_available?(locale)
  end

  def self.by_session(session)
    session[:locale]
  end

  def self.by_user(user)
    user.locale
  end

  def self.by_http(accepts)
    (accept_list(accepts) & I18n.available_locales).first
  end

  def self.locale_available?(locale)
    I18n.available_locales.map(&:to_s).include?(locale)
  end

  private

  def self.accept_list(accepts)
    accepts.downcase.scan(/([\w-]{2,})/).map { |l| l.first.to_sym }
  end
end