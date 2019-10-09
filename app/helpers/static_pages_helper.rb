module StaticPagesHelper
include ApplicationHelper

  
  def date_format(date)
    date.strftime("%d-%B-%Y")
  end
  #TODO - Refine this code
  def platform_selection(data)
    if data_verify(data)
      platform_list = Platform.where("name IN (?)",data).pluck(:name)
      html = []
      platform_list.each do |platform|
      html << content_tag(:a, link_to(platform, root_path(platform_name: platform), remote: true,class: "dropdown-item"))
      end
      safe_join(html)
    else
      'Cannot processed with nil result'
    end
  end
  
  #<div class="shadow p-3 mb-5 bg-white rounded">Regular shadow</div>
  #Used to render rssfeed for an article list
  def rssFeedrenderer(rss_data)
    if data_verify(data)
      rss_data.each do |arc|
        html = []
        
        content_tag(:div,)
        
        
      end
      
    else
      
    end
    
  end
  
  
end
