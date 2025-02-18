class Post < ApplicationRecord

  belongs_to :forum
  belongs_to :user
  
  validates :content, presence: true
  
  # enum status: { active: 0, flagged: 1, removed: 2 }
  
  scope :active_posts, -> { where(status: :active) }
end
