class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  
  validates :action, presence: true
  
  scope :recent, -> { order(created_at: :desc).limit(10) }
end
