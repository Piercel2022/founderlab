class Investment < ApplicationRecord
  belongs_to :startup

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :investment_date, presence: true
  validates :investment_type, presence: true
  validates :investor_name, presence: true
  validates :investment_round, presence: true
  validates :equity_percentage, 
            numericality: { 
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 100
            },
            allow_nil: true

  # Enums
  #enum investment_type: {
  #  seed: 'seed',
  #  angel: 'angel',
  #  series_a: 'series_a',
  #  series_b: 'series_b',
  #  series_c: 'series_c',
  #  private_equity: 'private_equity'
  #}

  #enum status: {
  #  pending: 'pending',
  #  completed: 'completed',
  #  cancelled: 'cancelled'
  #}

  # Scopes
  scope :completed, -> { where(status: 'completed') }
  scope :by_type, ->(type) { where(investment_type: type) }
  scope :recent, -> { order(investment_date: :desc) }

  scope :created_this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }

  def self.total_amount
    sum(:amount) # An 'amount' column in the investments table
  end

  def self.average_amount
    average(:amount)
  end

end
