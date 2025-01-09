class HomeController < ApplicationController
  def index
    @featured_projects = Project.featured.limit(3)
    @upcoming_events = Event.upcoming.limit(4)
    @latest_resources = Resource.latest.limit(6)
    @success_stories = Project.success_stories.limit(2)
    @active_mentors = Mentor.active.limit(4)
    
    # Statistics for dashboard
    @total_founders = User.founders.count
    @total_projects = Project.active.count
    @total_investments = Investment.total_amount
    @successful_exits = Project.successful_exits.count
  end
end
