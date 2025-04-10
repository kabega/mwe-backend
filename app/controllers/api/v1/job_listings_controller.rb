class Api::V1::JobListingsController < ApplicationController
    def index
        @job_listings = JobListing.all
        render json: @job_listings
    end
end
