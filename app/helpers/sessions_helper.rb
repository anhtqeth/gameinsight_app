module SessionsHelper
  #TODO - Admin verification should be clarified here

  def log_in(user)
    session[:user_id] = user.id #This session is built in function of rails
  end
  
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
  
  
  def log_out
    session.delete(:user_id) #delete sesssion
    @current_user = nil #release current user
  end
  
end
