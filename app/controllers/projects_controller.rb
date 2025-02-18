class ProjectsController < ApplicationController
  
  before_action :set_project, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
    render json: @projects, include: [:development_project, :market_research, :analytics_reports]
  end

  def show
    render json: @project, include: [:development_project, :market_research, :analytics_reports]
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
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
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :status, :target_market, :revenue_model)
  end
end
