class Api::V1::NewsController < ApplicationController
  include Rails.application.routes.url_helpers

  def index
    @news = News.all
    render json: @news.map { |news| news_with_photo_url(news) }
  end

  def show
    @news = News.find(params[:id])
    render json: news_with_photo_url(@news)
  end

  def create
    @news = News.new(news_params)
    if @news.save
      render json: news_with_photo_url(@news), status: :created
    else
      render json: @news.errors, status: :unprocessable_entity
    end
  end

  def update
    @news = News.find(params[:id])
    if @news.update(news_params)
      render json: news_with_photo_url(@news)
    else
      render json: @news.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
    head :no_content
  end

  private

  def news_params
    params.require(:news).permit(:title, :user_id, :photo, :description, :news_type)
  end

  def news_with_photo_url(news)
    result = {
      id: news.id,
      title: news.title,
      description: news.description,
      news_type: news.news_type,
      user_id: news.user_id,
      created_at: news.created_at,
      updated_at: news.updated_at
    }

    result[:photo_url] = if news.photo.attached?
                           Rails.application.routes.url_helpers.rails_blob_url(news.photo, host: request.base_url)
                         else
                           nil
                         end

    result
  end
end
