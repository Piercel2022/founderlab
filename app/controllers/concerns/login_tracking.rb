module LoginTracking
    extend ActiveSupport::Concern
  
    included do
      after_action :track_user_login, if: :user_signed_in?
    end
  
    private
  
    def track_user_login
      current_user.track_login(request)
    end
end