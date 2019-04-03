class UsersController < ApplicationController
  def index
    @project = Project.find_by_id(params[:project_id])
    if @project
      @users = User.remove_member(@project.users.ids).search_user(params[:keyword])
    else
      @users = User.remove_current_user(current_user.id).search_user(params[:keyword])
    end
    respond_to do |format|
      format.json
    end
  end
end
