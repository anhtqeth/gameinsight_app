class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    render html: "Welcome to GameInsight"
  end
end
