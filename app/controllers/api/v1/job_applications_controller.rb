class Api::V1::JobApplicationsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
        @joblisting = JobListing.find(params[:job_listing_id])
        @job_application = @joblisting.job_applications.new(job_application_params)
        @job_application.user = current_user
      
        if @job_application.save
          render json: JobApplicationSerializer.new(@job_application).serializable_hash,
                 status: :created
        else
          render json: { errors: @job_application.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    private
    
    def job_application_params
        params.require(:job_application).permit(:resume, :cover_letter)
    end
end