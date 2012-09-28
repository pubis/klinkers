module LocaleControl
  def self.included(controller)
    controller.class_eval do
      before_filter :set_locale

      def default_url_options(options = {})
        if params[:locale]
          { locale: I18n.locale }.merge(options)
        else
          options
        end
      end

      def set_locale
        LocaleSetter.set_by(user: current_user,
                            params: params,
                            http: request.env['HTTP_ACCEPT_LANGUAGE'],
                            default: I18n.default_locale)
      end
    end
  end
end