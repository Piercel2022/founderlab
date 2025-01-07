class Subscription < ApplicationRecord
  
  belongs_to :user
  
  validates :plan_type, presence: true
  validates :start_date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  
  enum status: { active: 0, cancelled: 1, expired: 2 }
  
  scope :active, -> { where(status: :active) }
end
