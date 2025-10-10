class Api::V1::EventsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :set_event, only: %i[show update destroy]

  def index
    @events = Event.all
    render json: @events.map { |event| event_with_photo_url(event) }
  end

  def show
    render json: event_with_photo_url(@event)
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: event_with_photo_url(@event), status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: event_with_photo_url(@event)
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :event_type, :description, :venue, :organizer, :status, :event_material,
                                  :starts_at, :ends_at, :photo)
  end

  def event_with_photo_url(event)
    result = {
      id: event.id,
      title: event.title,
      event_type: event.event_type,
      description: event.description,
      venue: event.venue,
      organizer: event.organizer,
      status: event.status,
      event_material: event.event_material,
      starts_at: event.starts_at,
      ends_at: event.ends_at,
      created_at: event.created_at,
      updated_at: event.updated_at
    }

    result[:photo_url] = if event.photo.attached?
                           Rails.application.routes.url_helpers.rails_blob_url(event.photo, host: request.base_url)
                         else
                           nil
                         end

    result
  end
end
