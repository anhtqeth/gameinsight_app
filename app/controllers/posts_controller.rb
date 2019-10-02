class PostsController < ApplicationController
  #Guide content is created by headless CMS Contenful
  #Admin/ Editor can only update surrounding metadata
  include ContentModule
  def index
    @posts = Post.all.order(:name).paginate(:page =>params[:page], :per_page => 5)
  end
  
  def show
    api_data = entryRequest('10PCttqTZMbCMna6rBGsvb')
    @post = Post.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
  
  end
  
  
  
  
  
  
end
