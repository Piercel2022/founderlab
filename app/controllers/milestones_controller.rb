class MilestonesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_milestone, only: [:show, :update, :destroy]
  before_action :set_project
  
  # GET /projects/:project_id/milestones
  def index
    @milestones = @project.milestones.order(due_date: :asc)
    
    render json: @milestones, include: [:tasks], status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # GET /projects/:project_id/milestones/:id
  def show
    authorize @milestone
    render json: @milestone, include: [:tasks], status: :ok
  rescue Pundit::NotAuthorizedError
    render json: { error: 'Not authorized' }, status: :forbidden
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # POST /projects/:project_id/milestones
  def create
    @milestone = @project.milestones.build(milestone_params)
    authorize @milestone

    if @milestone.save
      # Notify team members about new milestone
      NotificationService.new_milestone(@milestone)
      
      render json: @milestone, status: :created
    else
      render json: { errors: @milestone.errors.full_messages }, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError
    render json: { error: 'Not authorized' }, status: :forbidden
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /projects/:project_id/milestones/:id
  def update
    authorize @milestone

    if @milestone.update(milestone_params)
      # Check if status changed to completed
      if milestone_params[:status] == 'completed' && @milestone.status_previously_changed?
        handle_milestone_completion
      end

      render json: @milestone, status: :ok
    else
      render json: { errors: @milestone.errors.full_messages }, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError
    render json: { error: 'Not authorized' }, status: :forbidden
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # DELETE /projects/:project_id/milestones/:id
  def destroy
    authorize @milestone

    if @milestone.destroy
      # Notify team about milestone deletion
      NotificationService.milestone_deleted(@milestone, @project)
      
      head :no_content
    else
      render json: { error: 'Unable to delete milestone' }, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError
    render json: { error: 'Not authorized' }, status: :forbidden
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_milestone
    @milestone = Milestone.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Milestone not found' }, status: :not_found
  end

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Project not found' }, status: :not_found
  end

  def milestone_params
    params.require(:milestone).permit(
      :title,
      :description,
      :due_date,
      :status,
      :priority,
      :completion_percentage,
      :budget,
      :dependencies,
      task_ids: []
    )
  end

  def handle_milestone_completion
    # Update project progress
    ProjectProgressService.update_progress(@project)
    
    # Notify team members
    NotificationService.milestone_completed(@milestone)
    
    # Generate milestone completion report
    report = ReportGenerationService.milestone_completion_report(@milestone)
    
    # Archive completed tasks
    TaskArchivalService.archive_completed_tasks(@milestone)
    
    # Update project timeline if needed
    ProjectTimelineService.adjust_timeline(@project)
  end

  # Custom error handling
  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
