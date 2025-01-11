class ActivitySerializer < ActiveModel::Serializer
    attributes :id, :action, :details, :occurred_at, :created_at
    
    belongs_to :user
    belongs_to :trackable, polymorphic: true
    
    def occurred_at
      object.occurred_at.strftime('%Y-%m-%d %H:%M:%S')
    end
end