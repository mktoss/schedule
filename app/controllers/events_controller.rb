class EventsController < ApplicationController
  before_action :set_project
  before_action :project_member?
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :set_search, only: [:search, :index, :show]
  before_action :update_visit_time

  def search
    search_result = @q.result
    if params[:q][:bar_color]
      search_result = search_result.where(bar_color: params[:q][:bar_color])
    end
    if params[:q][:user_id]
      search_result = search_result.where(user_id: params[:q][:user_id])
    end
    @events_count = search_result.count
    @events = search_result.page(params[:page]).per(15)
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
    @event = @project.events.new(event_params_for_create)
    if @event.save
      redirect_to project_events_path(@project)
    else
      set_search
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
      set_search
      @events = @project.events
      render :index
    end
  end

  def destroy
    @event.destroy
    redirect_to project_events_path(@project)
  end

  private

  def event_params_for_create
    params.require(:event).permit(:title, :all_day, :start, :end_time, :address, :bar_color, :memo).merge(user_id: current_user.id)
  end

  def event_params
    params.require(:event).permit(:title, :all_day, :start, :end_time, :address, :bar_color, :memo)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def project_member?
    redirect_to root_path unless @project.users.include?(current_user)
  end

  def set_search
    @q = @project.events.includes(:user).with_keywords(params.dig(:q, :keywords)).ransack(params[:q])
  end

  def update_visit_time
    current_project = ProjectUser.get_current_user(current_user.id).get_current_project(params[:project_id])
    current_project.update(visit_time: Time.now)
  end
end
