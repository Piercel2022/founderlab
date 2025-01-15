class DashboardWidget < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :widget_type, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
  
  store_accessor :settings, :refresh_rate, :display_type, :data_source
end
