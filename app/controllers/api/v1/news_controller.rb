class Api::V1::NewsController < ApplicationController
  def index
    @news = News.all
    render json: @news
  end

  def show
    @news = News.find(params[:id])
    render json: @news
  end

  def create
    @news = News.new(news_params)
    if @news.save
      render json: @news, status: :created
    else
      render json: @news.errors, status: :unprocessable_entity
    end
  end

  def update
    @news = News.find(params[:id])
    if @news.update(news_params)
      render json: @news
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
    params.require(:news).permit(:title, :content, :user_id)
  end
end
