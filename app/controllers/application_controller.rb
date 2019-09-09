class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include SessionsHelper #Include session helper to faciliate user login
  
  def default_url_options
    { locale: I18n.locale }
  end
    
  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
    
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  
  # def home
  #   render html: "Welcome to GameInsight"
  # end
end
