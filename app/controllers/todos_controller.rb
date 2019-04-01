class TodosController < ApplicationController
  before_action :set_project

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
end
