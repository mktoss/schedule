class UsersController < ApplicationController
  def index
    @project = Project.find_by_id(params[:project_id])
    if @project
      @users = User.remove_member(@project.users.ids).get_user(params[:keyword])
    else
      @users = User.remove_current_user(current_user.id).get_user(params[:keyword])
    end
    respond_to do |format|
      format.json
    end
  end
end
