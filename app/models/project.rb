class Project < ApplicationRecord

  belongs_to :user
  has_one :development_project
  has_one :market_research
  has_many :analytics_reports
  
  validates :name, presence: true
  validates :status, presence: true
  
  #enum status: { draft: 0, active: 1, completed: 2, archived: 3 }
  
  scope :active_projects, -> { where(status: :active) }
  scope :featured, -> { where(featured: true).order(created_at: :desc) }
  scope :success_stories, -> { where(success_story: true).order(created_at: :desc) }
  scope :successful_exits, -> { where(status: 'exited') }
end
