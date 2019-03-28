class EventsController < ApplicationController
  before_action :set_project

  def index
    @event = Event.new
    @events = @project.events
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
