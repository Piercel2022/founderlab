# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  include ExportableDashboard
  include RoleBasedDashboard
  include ActionCable::Channel::Broadcasting
  
  before_action :authenticate_user!
  before_action :set_dashboard_data
  before_action :authorize_dashboard_access
  
  layout 'dashboard'

  def index
    @widgets = current_user.dashboard_widgets.ordered
    @metrics = load_role_based_metrics
    @recent_activities = fetch_activities
    
    respond_to do |format|
      format.html
      format.json { render json: dashboard_data_json }
      format.csv { send_data dashboard_export, filename: "dashboard-#{Date.current}.csv" }
      format.pdf { render_dashboard_pdf }
    end
  end

  def show
    @widget = current_user.dashboard_widgets.find(params[:id])
    render partial: "widgets/#{@widget.widget_type}", locals: { widget: @widget }
  end

  def analytics
    @start_date = params[:start_date]&.to_date || 30.days.ago
    @end_date = params[:end_date]&.to_date || Date.current
    
    @metrics = AdvancedAnalyticsService.new(analytics_params).perform
    @trends = TrendAnalysisService.new(current_user).analyze
    
    @analytics_data = {
      users: fetch_user_analytics,
      projects: fetch_project_analytics,
      investments: fetch_investment_analytics
    }

    respond_to do |format|
      format.html
      format.json { render json: @analytics_data.merge(@metrics) }
    end
  end

  def settings
    @widgets = current_user.dashboard_widgets
    @available_widgets = Widget.available_for_role(current_user.role)
    @current_layout = current_user.dashboard_layout
  end

  def update_settings
    if current_user.update(dashboard_settings_params)
      broadcast_layout_update
      redirect_to dashboard_path, notice: 'Dashboard settings updated successfully'
    else
      render :settings
    end
  end

  def update_widget_positions
    params[:positions].each do |position|
      widget = current_user.dashboard_widgets.find(position[:id])
      widget.update(position: position[:position])
    end
    broadcast_layout_update
    head :ok
  end

  private

  def set_dashboard_data
    @total_projects = current_user.projects.count
    @total_investments = current_user.investments.sum(:amount)
    @pending_tasks = current_user.tasks.pending.count
    @upcoming_events = current_user.events.upcoming.limit(5)
  end

  def fetch_activities
    ActivityLog.includes(:user, :trackable)
               .order(created_at: :desc)
               .limit(10)
  end

  def fetch_user_analytics
    User.group_by_day(:created_at, range: @start_date..@end_date)
        .count
  end

  def fetch_project_analytics
    current_user.projects
               .group_by_day(:created_at, range: @start_date..@end_date)
               .count
  end

  def fetch_investment_analytics
    current_user.investments
               .group_by_day(:created_at, range: @start_date..@end_date)
               .sum(:amount)
  end

  def analytics_params
    params.permit(
      :start_date, :end_date, :granularity,
      metrics: [], comparisons: [], segments: []
    )
  end

  def dashboard_settings_params
    params.require(:user).permit(
      :preferred_theme,
      :dashboard_layout,
      widget_settings: {},
      layout: {
        widgets: [:id, :position, :size, :settings],
        preferences: {}
      }
    )
  end

  def broadcast_layout_update
    broadcast_to("dashboard_#{current_user.id}", { action: 'layout_updated', layout: current_user.dashboard_layout })
  end
end