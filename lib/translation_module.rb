# frozen_string_literal: true

module TranslationModule
  # TranslationModule - Used to automatically translate app data to other language
  # Author - Anh Truong
  # Date Added - 04 - Sep - 2019
  # Will use Google/AWS Translation API services for translation
  # FUTURE UPDATE
  # Translation data can be edited by user. Other users can rate the translation quality.
  # Translation data is picked base on quality review.
  
  #Init translation client for AWS
  CLIENT = Aws::Translate::Client.new(
    access_key_id: 'AKIA43LK2ICEXSYIW3NR',
    secret_access_key: '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'
  )
  
  def transText(text,src_lang,targ_lang)
    resp = CLIENT.translate_text({
    text: text, # required
    source_language_code: src_lang,
    target_language_code: targ_lang,
    })
    resp[:translated_text]
  end
  
  def transPage(url,src_lang,targ_lang)
    # Translation of a page?
  end
  
  def gameDetailTrans(game,src_lang,targ_lang)
    
    
  
  end
  
end
