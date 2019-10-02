require 'contentful'
require 'rich_text_renderer'
module ContentModule


  CLIENT = Contentful::Client.new(
    space: 'wxo420nuykt4',
    access_token: 'ezEN0gg4g1L0tJCjTC4odpBhu73bNh8efDvSgLFY2ms',
    #api_url: 'preview.contentful.com'
  )

  #GAME_GENRE_ID = '72az5II9KZoQ9o0oo8Dywi'
  #POST_ID = '10PCttqTZMbCMna6rBGsvb'
  
  def entryRequest(id)
    entry_id = nil
    #puts for testing
    # puts 'TITLE'
    # puts CLIENT.entry(id).title
    # puts 'SUMMARY'
    # puts CLIENT.entry(id).summary
    # puts 'FEATURE_IMG'
    # puts CLIENT.entry(id).feature_image.url
    # puts 'CONTENT'
    CLIENT.entry id
  end
  
  def entriesRequest(type)
     case type 
      when 'post'
        CLIENT.entries(content_type: 'post')
      when 'genres'
        CLIENT.entries(content_type: 'gameGenre')
      else
        puts "(#{type}) is not a valid entry"
    end
  end
  
  
  def renderRichText(entry)
    renderer = RichTextRenderer::Renderer.new
    renderer.render(entry)
  end
  
  def renderSnippet
    
  end
  
end