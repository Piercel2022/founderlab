class Startup < ApplicationRecord

  has_many :investments, dependent: :destroy
    # Validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :founded_date, presence: true
  validates :industry, presence: true
  validates :stage, presence: true
  validates :status, presence: true
  
  # Enums
  #enum stage: {
  #  idea: 'idea',
  # mvp: 'mvp',
  #  early_stage: 'early_stage',
  #  growth: 'growth',
  #  scale: 'scale'
  #}

  #enum status: {
  # active: 'active',
  #  inactive: 'inactive',
  #  acquired: 'acquired',
  #  closed: 'closed'
  #}

  # Callbacks
  before_create :generate_slug

  # Scopes
  scope :active, -> { where(status: 'active') }
  scope :by_industry, ->(industry) { where(industry: industry) }
  scope :by_stage, ->(stage) { where(stage: stage) }

  scope :successful_exits, -> { where(status: ['acquired', 'ipo']) }
  
  private

  def generate_slug
    self.slug = name.parameterize
  end

  def team_size
    team_members.count # Assuming team_members is a related model
  end
end
