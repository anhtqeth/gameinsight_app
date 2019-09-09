class UsersController < ApplicationController
  #TODO - Utilize byebug later on
  #TODO - Apply the user_params here on other model that allow updates on site
  
  def show
    @user = User.find(params[:id])
    #debugger #For byebug debugging
  end
  
  def new
    @user = User.newe
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in(user)
      flash.now[:success] = "Welcome to Game Database!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:nickname,
                                   :password_confirmation)
    end
  
end
