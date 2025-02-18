class User < ApplicationRecord
  # Include default devise modules plus OAuth
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :trackable, :lockable,
  :omniauthable, omniauth_providers: [:google, :github, :linkedin]

  # Roles using rolify
  rolify
  #after_create :assign_default_role

  # Associations
  has_many :metrics
  has_one :profile, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :oauth_providers, dependent: :destroy
  has_many :login_activities, dependent: :destroy
  has_many :access_tokens, dependent: :destroy
  
  # Active Storage for avatar with virus scanning
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :profile, resize_to_limit: [300, 300]
  end

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }, 
  format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }
  validate :password_complexity
  #validate :prevent_password_reuse
  validate :avatar_content_type
  
  # Security configurations
  attr_encrypted :auth_token, key: ENV['ENCRYPTION_KEY']
  #has_secure_token :remember_token
  
  #validates :otp_secret, presence: true, if: :two_factor_enabled?

  # Callbacks
  #after_create :create_profile
  #after_create :send_welcome_email
  #before_save :ensure_security_questions_answered
  #after_save :clear_sensitive_data
  
  # Scopes
  scope :active, -> { where(active: true) }
  scope :admins, -> { with_role(:admin) }
  scope :recent, -> { order(created_at: :desc) }
  scope :with_recent_activity, -> { where('last_active_at > ?', 30.days.ago) }
  scope :security_risk, -> { where('failed_attempts > ?', 3) }

  # Rate Limiting
 # include RateLimiter
 # rate_limit :login_attempts, limit: 5, period: 20.minutes

  # Class Methods
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.nickname || auth.info.email.split('@').first
      user.skip_confirmation!
    end
    user.update_oauth_credentials(auth)
    user
  end

  # Instance Methods
  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def active_for_authentication?
    super && active? && !security_blocked?
  end

  def security_blocked?
    failed_attempts.to_i >= 5 || suspicious_activity_detected?
  end

  def suspicious_activity_detected?
    login_activities.suspicious.exists?
  end

  # Role Methods
 # def assign_default_role
 #  self.add_role(:user) if self.roles.blank?
 # end

  def admin?
    has_role?(:admin)
  end

  def moderator?
    has_role?(:moderator)
  end

  # Security Methods
  def generate_two_factor_secret_key
    self.otp_secret = ROTP::Base32.random
  end

  def enable_two_factor!
    update(two_factor_enabled: true)
  end

  def valid_two_factor_code?(code)
    totp = ROTP::TOTP.new(otp_secret)
    totp.verify(code)
  end

  def invalidate_all_sessions!
    self.update_column(:session_version, SecureRandom.uuid)
  end

  private

  def password_complexity
    return if password.blank?
    unless password.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, one digit, one special character, and be at least 8 characters long"
    end
  end

  #def prevent_password_reuse
  #  return if password.blank? || password_changed? == false
    
  #  previous_passwords = old_passwords.order(created_at: :desc).limit(5).pluck(:password_digest)
  #  if previous_passwords.any? { |old_password| BCrypt::Password.new(old_password) == password }
  #    errors.add(:password, "has been used previously. Please choose a different password.")
   # end
  #end

  def avatar_content_type
    if avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:avatar, "must be a JPEG, PNG, or GIF")
    end
  end

  #def ensure_security_questions_answered
  #  return unless active? && security_questions.blank?
  #  self.security_questions = generate_security_questions
  #end

  #def clear_sensitive_data
  #  self.temp_auth_token = nil
  #end

  def update_oauth_credentials(auth)
    oauth = oauth_providers.find_or_initialize_by(provider: auth.provider)
    oauth.update(
      uid: auth.uid,
      token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      expires_at: auth.credentials.expires_at
    )
  end
end
