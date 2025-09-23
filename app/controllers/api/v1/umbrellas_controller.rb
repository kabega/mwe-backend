class Api::V1::UmbrellasController < ApplicationController
  before_action :set_umbrella, only: %i[show update destroy]

  def index
    @umbrellas = Umbrella.all
    render json: @umbrellas
  end

  def show
    render json: @umbrella
  end

  def create
    @umbrella = Umbrella.new(umbrella_params)
    if @umbrella.save
      render json: @umbrella, status: :created
    else
      render json: @umbrella.errors, status: :unprocessable_entity
    end
  end

  def update
    if @umbrella.update(umbrella_params)
      render json: @umbrella
    else
      render json: @umbrella.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @umbrella.destroy
    head :no_content
  end

  private

  def set_umbrella
    @umbrella = Umbrella.find(params[:id])
  end

  def umbrella_params
    params.require(:umbrella).permit(:name, :description)
  end
end
