module ApplicationHelper
  # 
  def full_title(page_title = '')
    base_title = "Ethu Inc GameInsight "
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  #Used to check data before render stuff to view. 
  #All helpers need to check this
  def data_verify(data)
    data.nil? ? false : true
  end
  
  
end