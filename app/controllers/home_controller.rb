class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    redirect_to dashboard_url(id: current_user.id) if user_signed_in?
  
   @featured_projects = Project.featured.limit(3)
   @upcoming_events = Event.upcoming.limit(4)
   @latest_resources = Resource.latest.limit(6)
   @success_stories = Project.success_stories.limit(2)
   @active_mentors = Mentor.active.limit(4)
    
    # Statistics for dashboard
   @total_founders = User.founders.count
   @active_founders = User.founders.active.count
   @founders_this_month = User.founders.created_this_month.count
    
    # Project statistics
   @total_projects = Project.count
   @active_projects = Project.active.count
   @featured_projects = Project.featured.limit(6)
   @recent_projects = Project.order(created_at: :desc).limit(5)
    
    # Investment statistics
    @total_investments = Investment.total_amount
    @total_investors = User.investors.count
    @average_investment = Investment.average_amount
    @investments_this_month = Investment.created_this_month.sum(:amount)
    
    # Success metrics
    @successful_exits = Startup.successful_exits.count
    @total_jobs_created = Startup.all.sum(&:team_size)

    # Industry breakdown
    @industry_breakdown = Startup.group(:industry).count
    
    # Geographic distribution
    @geographic_distribution = Startup.group(:location).count.sort_by { |_, v| -v }.first(10)
    
    # Latest activity
  # @recent_activities = Activity.includes(:user, :trackable).order(created_at: :desc).limit(10)
   @successful_exits = Project.successful_exits.count
  end
end
