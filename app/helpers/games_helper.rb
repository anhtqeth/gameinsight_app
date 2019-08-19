module GamesHelper
  #GamesHelper - Helper class to render view for GamesController
  #Date Added - 19 - August - 2019
  #Authors - Anh Truong
  
  def data_verify(data)
    data.nil? ? false : true
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
        content << content_tag(:div,media(news),class: "media") << content_tag(:hr)
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
      safe_join([news_img,media_body])
    else
      puts "IMG is not there!"
    end
  end
  
  #Not used yet
  def carousel_for(model)
    images = []
    model.each do |img|
      images << img.url
    end
    Carousel.new(self, images).html
  end

  class Carousel
    def initialize(view, images)
      @view, @images = view, images
      @uid = SecureRandom.hex(6)
    end

    def html
      content = view.safe_join([indicators, slides, controls])
      view.content_tag(:div, content, class: 'carousel slide')
    end

    private
    attr_accessor :view, :images
    #what is delegate?
    delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view
    
    def indicators
      items = images.count.times.map { |index| indicator_tag(index) }
      #need to see what this does...
      content_tag(:ol, safe_join(items), class: 'carousel-indicators')
    end
    
    def indicator_tag(index)
      options = {
        class: (index.zero? ? 'active' : ''),
        data: { 
          target: @uid, 
          slide_to: index 
        }
      }

      content_tag(:li, '', options)
    end

    def slides
      items = images.map.with_index { |image, index| slide_tag(image, index.zero?) }
      content_tag(:div, safe_join(items), class: 'carousel-inner')
    end
    
    def slide_tag(image, is_active)
      options = {
        class: (is_active ? 'carousel-item active' : 'carousel-item'),
      }

      content_tag(:div, image_tag(image), options)
    end

    def controls
      safe_join([control_tag('prev'), control_tag('next')])
    end

    def control_tag(direction)
      options = {
        class: "carousel-control-#{direction} ",
        data: { slide: direction == 'prev' ? 'prev' : 'next' }
      }

      icon = content_tag(:i, nil, class: "carousel-control-#{direction}-icon")
      control = link_to(icon, "#{@uid}", options)
    end
  end
  
  
end
