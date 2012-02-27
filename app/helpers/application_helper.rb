module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert alert-success"
    when :error  then "alert alert-error"
    when :alert  then "alert"
    end
  end

  # Based on https://gist.github.com/1205828, in turn based on https://gist.github.com/1182136
  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr; Previous'.html_safe, :next_label => 'Next &rarr;'.html_safe)
  end
  
  def budget_category_bar value, total, income = false
    p = value / total * 100
    color = "progress-success"
    if income
      color = "progress-warning" if p <= 50
      color = "progress-danger" if p <= 25
    else
      color = "progress-warning" if p >= 75
      color = "progress-danger" if p > 100
    end
    progress_bar p, color
  end
  
  def success_bar value, total, warn = false, income = false
    p = value / total * 100
    color = "progress-success"
    if warn
      if income
        color = "progress-danger" if p <= warn
      else
        color = "progress-danger" if p >= warn
      end
    end
        
    progress_bar p, color
  end

  def info_bar value, total, warn = false
    p = value / total * 100
    color = "progress-info"
    if warn
      color = "progress-danger" if p >= warn
    end
    
    progress_bar p, color
  end
  
  def progress_bar progress, color_class
    content_tag :div, :class => "progress progress-striped #{color_class}" do
      bar progress
    end
  end
  
  def bar progress
    content_tag(:div, '', :class => "bar", :style => "width: #{progress}%;")
  end
    
end
