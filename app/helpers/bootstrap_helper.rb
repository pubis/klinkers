module BootstrapHelper
  def icon_tag icon, opts = {}
    defaults = {
      white: false,
      large: false,
      suffix: '',
      prefix: ''
    }
    defaults.merge(opts)
    class_string = "icon-#{icon.to_s}"
    class_string = "#{class_string} icon-white" if defaults[:white]
    class_string = "#{class_string} icon-large" if defaults[:large]
    content_tag(:i, '', class: class_string)
  end
  
  def caret_tag
    content_tag(:b, '', class: 'caret')
  end
end