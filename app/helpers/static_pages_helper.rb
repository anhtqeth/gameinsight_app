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
  
  
end
