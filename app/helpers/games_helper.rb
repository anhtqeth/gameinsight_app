module GamesHelper
  #GamesHelper - Helper class to render view for GamesController
  #Date Added - 19 - August - 2019
  #Authors - Anh Truong
  
  def data_verify(data)
    data.nil? ? false : true
  end
  
  #Handle formatting for field that require specific date format
  #Example: game release date
  #Para: date to be format
  def date_format(date)
    date.strftime("%d-%B-%Y")
  end
  
  
  def getMediaUrl(model,data_type)
    media = []
    model.each do |game|
      case data_type
      when 'vid'
        next if game.videos.empty?
        media << game.game_videos.first.url
      when 'img'
        next if game.screenshots.empty?
        media << game.screenshots.first.url
      else
        puts 'Please set correct data type'
      end
    end
    media
  end
  
  #Newsfeed render for a specific game
  #Input is newsfeed from controller
  #If data is nil, render a simple content tag.
  #If data is present, proceed to render bootstrap media type list
  def game_newsfeed(newsfeed)
    if data_verify(newsfeed)
      content = []
      newsfeed.each do |news|
        #Put news data to media to render for each element
        content << content_tag(:div,media(news),class: "media")
      end
      #Rendering html
      safe_join(content)
    else
      content_tag(:p, "We found no news source related to this game yet. 
      Do you have ones? Consider contributing it!")
    end
  end
  
  #Render media type for news
  #News with empty img will be skipped
  #For wrapper div, like media-body, the conent need to be safe_join first, and put inside the content_tag
  def media(news)
    unless news[:img].nil?
      news_img = image_tag(news[:img], class: "mr-3",id: "news-image")
      news_title = content_tag(:h5, news[:title], class:"mt-0")
      create_time = DateTime.strptime(news[:publish_at].to_s,'%s')
      news_summary = content_tag(:p, truncate(news[:summary],length:200), class: "card-text")
      news_published_time = content_tag(:p, "Last updated " << time_ago_in_words(create_time) << " ago", class: "card-text")
      
      #Wrap media-body
      media_body = content_tag(:div,safe_join([news_title, news_summary, news_published_time]),class: "media-body")
      #Return the media element
      safe_join([news_img,media_body,content_tag(:hr)])
    else
      puts "IMG is not there!"
    end
  end
  
  
  #Used to render bootstrap carousel
  #This include a small div overlay on top of the image
  #and show text on the image
  def carousel_render(data,type)
    if data_verify(data)
      Carousel.new(self,getMediaUrl(data,type)).html
    else
      content_tag(:p, "We found no news source related to this game yet. 
      Do you have ones? Consider contributing it!")
    end
  end
  
  #Carousel class for handling Carousel
  #There will be a check for media type (img/videos) 
  #The input is an array of url
  class Carousel
    # def initialize(view, images)
    #   @view, @images = view, images
    #   @uid = SecureRandom.hex(6)
    # end
    
    #TODO - The id is hard-coded! This still cannot be used widely!
    def initialize(view,media)
      @view, @media_data, @size = view,media,media.size
    end
    
    def html
      carousel = safe_join([carousel_indicator(@size),carousel_inner(@media_data)])
      content_tag(:div,carousel,id: "carouselIndicators",class: "carousel slide","data-ride": "carousel")
    end
    
    private
    attr_accessor :view, :media
    #what is delegate?
    delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view
    
    def carousel_indicator(size)
      content_tag(:ol,data_slide(size),class: "carousel-indicators")
    end
    
    #This is the indicator of the current slide
    #Need
    def data_slide(size)
      content = []
      #TODO - Change the data-target (and id of the carousel wrapper)
      i = 1
      content << content_tag(:li,"","data-target": "#carouselIndicators","data-slide-to": 0, class: "active")
      size.times.each do |li|
        content << content_tag(:li,"","data-target": "#carouselIndicators","data-slide-to": i)
        i+=1
      end
      safe_join(content)
    end
    
    def carousel_inner(media_data)
      content = safe_join([carousel_item(media_data),carousel_control])
      content_tag(:div,content,class: "carousel-inner")
    end
    
    #Render carousel-item div. 
    #Input is an array of media_url
    def carousel_item(media_data)
      items = []
      #Render the first img (active) media
      first_media = image_tag(media_data.first, class: "d-block w-100", id: "hot-games")
      items << content_tag(:div, first_media, class: "carousel-item active")
      
      media_data[1..-1].each do |media_url|
        next if media_url.nil?
        remaining_media = image_tag(media_url, class: "d-block w-100",  id: "hot-games")
        items << content_tag(:div, remaining_media, class: "carousel-item")
      end
      safe_join(items)
    end
    
    def carousel_control
      control = []
      control << content_tag(:a,direction("prev"),href: "#carouselIndicators",class: "carousel-control-prev","role": "button", "data-slide": "prev")
      control << content_tag(:a,direction("next"),href: "#carouselIndicators",class: "carousel-control-next","role": "button", "data-slide": "next")
      safe_join(control)
    end
    
    def direction(data)
      content = []
      content << content_tag(:span,"",class: "carousel-control-#{data}-icon","aria-hidden": "true")
      content << content_tag(:span,data, class: "sr-only")
      safe_join(content)
    end
    
  end
end
