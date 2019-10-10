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
        html << content_tag(:div, cardRenderer(arc), class: 'col-md-4')
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
end
