class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :subscriptions
  has_many :meetings
  has_many :posts
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, inclusion: { in: %w[founder mentor investor admin] }
  
  enum status: { active: 0, inactive: 1, suspended: 2 }
  
end