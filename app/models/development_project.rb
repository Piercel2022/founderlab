class DevelopmentProject < ApplicationRecord

  belongs_to :project
  validates :phase, presence: true
  validates :timeline, presence: true
  validates :budget, numericality: { greater_than: 0 }
  
  serialize :milestones, JSON
  
  enum phase: { planning: 0, development: 1, testing: 2, launch: 3 }
end
