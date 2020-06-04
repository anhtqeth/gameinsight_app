# frozen_string_literal: true

require 'contentful'
require 'rich_text_renderer'
module ContentModule
  CLIENT = Contentful::Client.new(
    space: 'Your Space ID',
    access_token: 'Your Access Token'
    # api_url: 'preview.contentful.com'
  )

  # GAME_GENRE_ID = ''
  # POST_ID = ''

  def entryRequest(id)
    CLIENT.entry id
  end

  def entriesRequest(type)
    case type
    when 'post'
      CLIENT.entries(content_type: 'post')
    when 'genres'
      CLIENT.entries(content_type: 'gameGenre')
    when 'platform'
      CLIENT.entries(content_type: 'gamePlatform')
    else
      puts "(#{type}) is not a valid entry"
    end
  end

  def renderRichText(richText)
    renderer = RichTextRenderer::Renderer.new
    renderer.render(richText)
  end

  def renderSnippet; end
end
