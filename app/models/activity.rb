class Activity < ApplicationRecord
   # Relationships
   belongs_to :user
   belongs_to :trackable, polymorphic: true, optional: true
   has_many :comments, as: :commentable, dependent: :destroy
   has_many :likes, dependent: :destroy
 
   # Validations
   validates :activity_type, presence: true
   validates :content, presence: true, if: :requires_content?
 
   # Enums
   enum activity_type: {
     comment: 'comment',
     project_update: 'project_update',
     milestone: 'milestone'
   }
 
   # Scopes
   scope :recent, -> { order(created_at: :desc) }
   scope :by_type, ->(type) { where(activity_type: type) }
   scope :by_user, ->(user) { where(user: user) }
 
   # Methods
   def requires_content?
     ['comment', 'project_update'].include?(activity_type)
   end
end
