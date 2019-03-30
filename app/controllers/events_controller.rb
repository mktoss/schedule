class EventsController < ApplicationController
  before_action :set_project
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @event = Event.new
    @events = @project.events
  end

  def show
    @events = @project.events
    render :index
  end

  def create
    @event = @project.events.new(event_params)
    if @event.save
      redirect_to project_events_path(@project)
    else
      @events = @project.events
      render :index
    end
  end

  def update
    if @event.update(event_params)
      redirect_to project_events_path(@project)
    else
      set_event
      @events = @project.events
      render :index
    end
  end

  def destroy
    @event.destroy
    redirect_to project_events_path(@project)
  end

  private

  def event_params
    params.require(:event).permit(:title, :all_day, :start, :end, :address, :color, :memo).merge(user_id: current_user.id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
