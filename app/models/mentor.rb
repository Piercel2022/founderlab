class Mentor < ApplicationRecord

  belongs_to :user
  has_many :meetings
  
  validates :expertise, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  
  serialize :expertise, Array

  scope :active, -> { where(status: 'active').order(rating: :desc) }
end
