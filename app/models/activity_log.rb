class ActivityLog < ApplicationRecord
  belongs_to :trackable
  belongs_to :user
end
