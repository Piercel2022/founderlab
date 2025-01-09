class Resource < ApplicationRecord
    
  validates :title, presence: true
  validates :category, presence: true
  validates :file_url, presence: true
  
  enum access_level: { free: 0, premium: 1, enterprise: 2 }
  enum category: { document: 0, video: 1, template: 2, tool: 3 }
  
  scope :latest, -> { order(created_at: :desc) }
end
