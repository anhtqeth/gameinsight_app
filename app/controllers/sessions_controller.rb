class SessionsController < ApplicationController
  #TODO - Change Flash mssage to translation string
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    # Find user by email (account name) and authenticate
    if user && user.authenticate(params[:session][:password])
      log_in(user) #Call the helper
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password'
      render 'new'
    end
   
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
