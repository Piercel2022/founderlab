class MarketResearch < ApplicationRecord

  belongs_to :project
  validates :market_size, numericality: { greater_than: 0 }
  validates :competitors, presence: true
  validates :target_audience, presence: true
  
  serialize :opportunities, JSON
  serialize :pain_points, JSON
end
