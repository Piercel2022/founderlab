class Activity < ApplicationRecord
 
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  
  validates :action, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
  scope :last_week, -> { where('created_at >= ?', 1.week.ago) }
  
  ACTIONS = %w[created updated deleted commented shared]
end
