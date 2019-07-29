require 'contentful'
require 'rich_text_renderer'

module ContentModule

CLIENT = Contentful::Client.new(
  space: 'wxo420nuykt4',
  access_token: 'ezEN0gg4g1L0tJCjTC4odpBhu73bNh8efDvSgLFY2ms',
  #api_url: 'preview.contentful.com'
)

GAME_GENRE_ID = '72az5II9KZoQ9o0oo8Dywi'
  
  def entryRequest
    puts CLIENT.entries
    puts CLIENT.entry(GAME_GENRE_ID).description
    CLIENT.entry(GAME_GENRE_ID).description
  end
  
  def renderRichText
    renderer = RichTextRenderer::Renderer.new
    renderer.render(entryRequest)
  end
end