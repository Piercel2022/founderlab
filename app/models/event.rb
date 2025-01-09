class Event < ApplicationRecord

  validates :title, presence: true
  validates :date, presence: true
  validates :capacity, numericality: { greater_than: 0 }
  
  #enum category: { workshop: 0, networking: 1, pitch: 2, conference: 3 }
  

  scope :available, -> { where('capacity > 0') }
  scope :upcoming, -> { where('date > ?', Time.current).order(date: :asc) }
end
