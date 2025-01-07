class Forum < ApplicationRecord

  has_many :posts

  validates :title, presence: true
  validates :category, presence: true
  
  enum status: { active: 0, archived: 1 }
  enum category: { general: 0, technical: 1, funding: 2, growth: 3 }
end
