class Api::V1::BidsController < ApplicationController
  before_action :set_bid, only: %i[show update destroy]

  def index
    @bids = Bid.all
    render json: @bids
  end

  def show
    render json: @bid
  end

  def create
    @bid = Bid.new(bid_params)
    if @bid.save
      render json: @bid, status: :created
    else
      render json: @bid.errors, status: :unprocessable_entity
    end
  end

  def update
    if @bid.update(bid_params)
      render json: @bid
    else
      render json: @bid.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bid.destroy
    head :no_content
  end

  private

  def set_bid
    @bid = Bid.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(:title, :bid_type)
  end
end
