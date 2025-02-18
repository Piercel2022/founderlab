module Activities
    class Creator
      def self.call(user:, trackable:, action:, details: nil)
        Activity.create!(
          user: user,
          trackable: trackable,
          action: action,
          details: details,
          occurred_at: Time.current
        )
      rescue => e
        Rails.logger.error "Failed to create activity: #{e.message}"
        false
      end
    end
end
  