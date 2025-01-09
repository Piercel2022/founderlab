class SuccessStory < ApplicationRecord
    
    validates :title, presence: true
    validates :founder_name, presence: true
    validates :company_name, presence: true
    validates :summary, presence: true
    
    # Optional: Add scope for ordering
    scope :recent, -> { order(created_at: :desc) }
    
    # Optional: Add custom validation for funding_raised format
    validates :funding_raised, format: { 
      with: /\A\$[0-9,]+[KMB]?\z/,
      message: "must be in format $XXX,XXX or $XXXK/M/B",
      allow_blank: true
    }  
end
