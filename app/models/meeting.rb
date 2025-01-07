class Meeting < ApplicationRecord

  belongs_to :mentor
  belongs_to :user
  validates :date, presence: true
  validates :meeting_type, presence: true
  
  enum status: { scheduled: 0, completed: 1, cancelled: 2 }
  enum meeting_type: { one_on_one: 0, group: 1, workshop: 2 }
  
  scope :upcoming, -> { where('date > ?', Time.current) }
end
