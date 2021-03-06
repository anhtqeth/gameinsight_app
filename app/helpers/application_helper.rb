# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Ethu Inc Game Database '
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
  
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  # Used to check data before render stuff to view.
  # All helpers need to check this
  def data_verify(data)
    data.nil? ? false : true
  end

  def date_format(date)
    date.strftime('%d-%B-%Y')
  end
  
  def breadcrumb_trail
    if current_page?(root_path)
    
    else
      html = []
      html << breadcrumb(root_path)
      path = request.original_fullpath.split('/')
      path[1..-1].each do |url|
         html << breadcrumb(url)
      end
      safe_join(html)
    end
    debugger
  end
  
  def breadcrumb(url)
   
  end
end
