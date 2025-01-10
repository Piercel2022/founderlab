class User < ApplicationRecord

  #include ActiveStorage::Variation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :subscriptions
  has_many :meetings
  has_many :posts
  has_one_attached :avatar
  #validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, inclusion: { in: %w[founder mentor investor admin] }
  
  scope :founders, -> { where(role: 'founder') }
  scope :investors, -> { where(role: 'investor') }
  scope :active, -> { where(status: 'active') }
  scope :created_this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }
  
  #enum status: { active: 0, inactive: 1, suspended: 2 }
  
end