class Project < ApplicationRecord

  belongs_to :user
  has_one :development_project
  has_one :market_research
  has_many :analytics_reports
  has_many :activities, as: :trackable

  
  validates :name, presence: true
  validates :status, presence: true
  
  #enum status: { draft: 0, active: 1, completed: 2, archived: 3 }
  
  scope :active_projects, -> { where(status: :active) }
  scope :featured, -> { where(featured: true).order(created_at: :desc) }
  scope :success_stories, -> { where(success_story: true).order(created_at: :desc) }
  scope :successful_exits, -> { where(status: 'exited') }

  scope :active, -> { where(status: 'active') }
  scope :featured, -> { where(featured: true) }

  
  after_create :log_creation
  after_update :log_update
  after_destroy :log_deletion
  
  private
  
  def log_creation
    Activities::Creator.call(
      user: self.user,
      trackable: self,
      action: 'created',
      details: "Created project: #{name}"
    )
  end
  
  def log_update
    Activities::Creator.call(
      user: self.user,
      trackable: self,
      action: 'updated',
      details: "Updated project: #{name}"
    )
  end
  
  def log_deletion
    Activities::Creator.call(
      user: self.user,
      trackable: self,
      action: 'deleted',
      details: "Deleted project: #{name}"
    )
  end
end
