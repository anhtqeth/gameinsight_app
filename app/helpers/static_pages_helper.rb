# frozen_string_literal: true

module StaticPagesHelper
  include ApplicationHelper

  def date_format(date)
    date.strftime('%d-%B-%Y')
  end

  # TODO: - Refine this code
  def platform_selection(data)
    if data_verify(data)
      platform_list = Platform.where('name IN (?)', data).pluck(:name)
      html = []
      platform_list.each do |platform|
        html << content_tag(:a, link_to(platform, root_path(platform_name: platform), remote: true, class: 'dropdown-item'))
      end
      safe_join(html)
    else
      'Cannot processed with nil result'
    end
  end

  # <div class="shadow p-3 mb-5 bg-white rounded">Regular shadow</div>
  # Used to render rssfeed for an article list
  def rssFeedrenderer(rss_data)
    if data_verify(rss_data)
      html = []
      rss_data.each do |arc|
       # html << content_tag(:div, cardRenderer(arc), class: 'col-md-4') #card 
        html << content_tag(:div, mediaRenderer(arc), class: 'media shadow p-3 mb-3') #media
      end
      content_tag(:div, content_tag(:div, safe_join(html), class: 'row'), class: 'container')
    else
      'Loading'
    end
  end

  def cardRenderer(data)
    card_body = []
    unless data[:img].nil?
      card_body << image_tag(data[:img], class: 'card-img-top')
    end
    card_body << content_tag(:hr)
    card_body << content_tag(:h5, data[:title], class: 'card-title')
    card_body << content_tag(:p, truncate(data[:summary], length: 200), class: 'card-text')
    card_body << content_tag(:hr)
    card_body << link_to('View More', data[:url], target: '_blank', rel: 'nofollow')
    card_body << content_tag(:p, content_tag(:small, 'Last updated ' + time_ago_in_words(data[:publish_at]), class: 'text-muted'), class: 'card-text')
    content_tag(:div, content_tag(:div, safe_join(card_body), class: 'card-body'), class: 'card shadow p-3 mb-3')
  end
  
#   <div class="media">
#   <img class="align-self-center mr-3" src="..." alt="Generic placeholder image">
#   <div class="media-body">
#     <h5 class="mt-0">Center-aligned media</h5>
#     <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.</p>
#     <p class="mb-0">Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
#   </div>
# </div>

  def mediaRenderer(data)
    media = []
    body = []
    unless data[:img].nil?
      media << image_tag(data[:img], class: 'align-self-center mr-3',id: 'news-image')
    end
    body << content_tag(:h5,data[:title],class:'mt-0')
    body << content_tag(:p, truncate(data[:summary], length: 300))
    body << link_to('View More', data[:url], target: '_blank', rel: 'nofollow')
    body << content_tag(:hr)
    body << content_tag(:p, content_tag(:small, 'Last updated ' + time_ago_in_words(data[:publish_at]) + ' ago'))
    media << content_tag(:div,safe_join(body),class:'media-body')
    safe_join(media)
  end
end
