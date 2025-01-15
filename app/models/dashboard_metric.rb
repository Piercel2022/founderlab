class DashboardMetric < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :category, presence: true
  
  scope :by_category, ->(category) { where(category: category) }
end
