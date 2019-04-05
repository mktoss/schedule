class TodosController < ApplicationController
  before_action :set_project
  before_action :project_member?
  before_action :set_search, only: [:executed, :edit]

  def executed
    @events = @project.events.get_executed
  end

  def edit
    @events = @project.events.get_todo
  end

  def update
    todos_params.map do |id, todo_params|
      event = Event.find(id)
      event.update_attributes(todo_params)
    end
    redirect_to edit_project_todos_path(@project)
  end

  private

  def todos_params
    params.permit(events: [:todo])[:events].to_h.to_a
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_member?
    redirect_to root_path unless @project.users.include?(current_user)
  end

  def set_search
    @q = @project.events.includes(:user).with_keywords(params.dig(:q, :keywords)).ransack(params[:q])
  end
end
