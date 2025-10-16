class Api::V1::ProjectsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :set_project, only: %i[show update destroy]

  def index
    @projects = Project.all
    render json: @projects.map { |project| project_with_documents_urls(project) }
  end

  def show
    render json: project_with_documents_urls(@project)
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: project_with_documents_urls(@project), status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: project_with_documents_urls(@project)
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(
      :title,
      :department,
      :description,
      :objective,
      :project_manager,
      :location,
      :start_date,
      :end_date,
      :status,
      :priority,
      :budget,
      documents: []
    )
  end

  def project_with_documents_urls(project)
    result = {
      id: project.id,
      title: project.title,
      department: project.department,
      description: project.description,
      objective: project.objective,
      project_manager: project.project_manager,
      location: project.location,
      start_date: project.start_date,
      end_date: project.end_date,
      status: project.status,
      priority: project.priority,
      budget: project.budget,
      created_at: project.created_at,
      updated_at: project.updated_at
    }

    if project.documents.attached?
      result[:documents] = project.documents.map do |document|
        {
          id: document.id,
          filename: document.filename.to_s,
          url: Rails.application.routes.url_helpers.rails_blob_url(document, host: request.base_url),
          content_type: document.content_type,
          byte_size: document.byte_size
        }
      end
    else
      result[:documents] = []
    end

    result
  end
end
