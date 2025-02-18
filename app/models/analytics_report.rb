class AnalyticsReport < ApplicationRecord

  belongs_to :project
  validates :metrics, presence: true
  validates :date, presence: true
  validates :report_type, presence: true
  
  serialize :metrics, JSON
  
  enum report_type: { monthly: 0, quarterly: 1, annual: 2 }
end
