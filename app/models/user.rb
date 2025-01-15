class User < ApplicationRecord

  #include ActiveStorage::Variation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :subscriptions
  has_many :meetings
  has_many :posts
  has_many :dashboard_metrics
  has_many :dashboard_widgets
  has_many :activity_logs
  has_many :login_histories
  
  has_one_attached :avatar
  #validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
  #validates :email, presence: true, uniqueness: true
  #validates :name, presence: true
  #validates :role, inclusion: { in: %w[founder mentor investor admin] }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  
  scope :founders, -> { where(role: 'founder') }
  scope :investors, -> { where(role: 'investor') }
  scope :active, -> { where(status: 'active') }
  scope :created_this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }
  
  store_accessor :preferences, :preferred_theme, :dashboard_layout
  #enum status: { active: 0, inactive: 1, suspended: 2 }

  def password_required?
    new_record? || password.present?
  end
  
end