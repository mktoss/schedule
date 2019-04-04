class EventsController < ApplicationController
  before_action :set_project
  before_action :project_member?
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :set_search, only: [:search, :index, :show]

  def search
    @events_count = @q.result.count
    @events = @q.result.page(params[:page]).per(15)
  end

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
      respond_to do |format|
        format.html { redirect_to project_events_path(@project) }
        format.json
      end
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
    params.require(:event).permit(:title, :all_day, :start, :end_time, :address, :bar_color, :memo).merge(user_id: current_user.id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def project_member?
    unless @project.users.include?(current_user)
      redirect_to root_path
    end
  end

  def set_search
    @q = @project.events.includes(:user).with_keywords(params.dig(:q, :keywords)).ransack(params[:q])
  end
end
