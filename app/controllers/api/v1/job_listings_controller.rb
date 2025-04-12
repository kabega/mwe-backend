class Api::V1::JobListingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    @job_listings = JobListing.all.includes(:user)
    if @job_listings
      render json: JobListingSerializer.new(@job_listings, {
                                              include: [:user]
                                            }).serializable_hash.to_json
    else
      render json: { message: 'No job listings found' }, status: :not_found
    end
  end

  def create
    @job_listing = JobListing.new(job_listing_params)
    @job_listing.user = current_user
    if @job_listing.save
      render json: JobListingSerializer.new(@job_listing).serializable_hash[:data][:attributes]
    else
      render json: @job_listing.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :status, :location, :salary, :salary_currency,
                                        :deadline, :qualifications, :experience, :job_type)
  end
end
