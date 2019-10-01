class PostsController < ApplicationController
  #Guide content is created by headless CMS Contenful
  #Admin/ Editor can only update surrounding metadata
  
  def index
    
  end
  
  def show
    @post = Post.find(params[:id])
    
    
  end
  
  def update
    
  end
  
  def destroy
  
  end
  
  
  
  
  
  
end
