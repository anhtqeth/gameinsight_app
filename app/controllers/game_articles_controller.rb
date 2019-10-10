# frozen_string_literal: true

class GameArticlesController < ApplicationController
  def destroy
    GameArticle.find(params[:id]).destroy
    flash.now[:success] = 'Game Article Deleted!'
    redirect_back(fallback_location: root_path)
  end

  def edit
    @screenshots = GameArticle.find(params[:id])
  end

  def update
    @game_article = GameArticle.find(params[:id])
    if @game_article.update_attributes(article_params)
      flash.now[:success] = 'Game Article Updated'
      redirect_back(fallback_location: root_path)
    else
      render 'edit'
    end
  end

  def create
    modified_param = article_params
    modified_param['publish_at'] = Time.parse(article_params['publish_at']).to_time.to_i
    puts modified_param['publish_at']
    @game_article = GameArticle.new(modified_param)
    if @game_article.save
      flash.now[:success] = 'Article added!'
      redirect_back(fallback_location: root_path)
    else
      puts @game_article.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def article_params
    params.require(:game_article).permit(:title, :url, :img, :external_id, :summary, :author, :news_source, :publish_at, :game_article_collection_id)
  end
end
