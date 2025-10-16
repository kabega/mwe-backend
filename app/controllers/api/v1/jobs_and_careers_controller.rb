class Api::V1::JobsAndCareersController < ApplicationController
  before_action :set_job, only: %i[show update destroy]

  def index
    @jobs = JobsAndCareer.all

    # Optional filtering
    @jobs = @jobs.where(status: params[:status]) if params[:status].present?
    @jobs = @jobs.by_department(params[:department]) if params[:department].present?
    @jobs = @jobs.where(job_type: params[:job_type]) if params[:job_type].present?

    render json: @jobs.map { |job| job_with_formatted_data(job) }
  end

  def show
    render json: job_with_formatted_data(@job)
  end

  def create
    @job = JobsAndCareer.new(job_params)
    if @job.save
      render json: job_with_formatted_data(@job), status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render json: job_with_formatted_data(@job)
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    head :no_content
  end

  # Custom action to get published and active jobs only
  def active
    @jobs = JobsAndCareer.active
    render json: @jobs.map { |job| job_with_formatted_data(job) }
  end

  private

  def set_job
    @job = JobsAndCareer.find(params[:id])
  end

  def job_params
    params.require(:jobs_and_career).permit(
      :job_title,
      :department,
      :job_description,
      :job_type,
      :level,
      :status,
      :location,
      :salary_range,
      :requirements,
      :responsibilities,
      :application_deadline,
      :contact_email
    )
  end

  def job_with_formatted_data(job)
    {
      id: job.id,
      job_title: job.job_title,
      department: job.department,
      job_description: job.job_description,
      job_type: job.job_type,
      level: job.level,
      status: job.status,
      location: job.location,
      salary_range: job.salary_range,
      requirements: job.requirements_list,
      responsibilities: job.responsibilities_list,
      application_deadline: job.application_deadline,
      contact_email: job.contact_email,
      created_at: job.created_at,
      updated_at: job.updated_at
    }
  end
end
