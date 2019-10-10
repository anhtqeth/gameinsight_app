# frozen_string_literal: true

module SessionsHelper
  # TODO: - Admin verification should be clarified here

  def log_in(user)
    session[:user_id] = user.id # This session is built in function of rails
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id) # delete sesssion
    @current_user = nil # release current user
  end

  def admin?
    # TODO: - Check if current user is admin
    current_user.admin?
  end
end
