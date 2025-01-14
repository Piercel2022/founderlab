# app/helpers/dashboard_helper.rb
module DashboardHelper
    def activity_icon(action_type)
      icon_class = case action_type
      when 'project_created'
        'icon-plus-circle'
      when 'project_updated'
        'icon-edit'
      when 'comment_added'
        'icon-message-circle'
      when 'task_completed'
        'icon-check-circle'
      when 'member_added'
        'icon-user-plus'
      when 'investment_received'
        'icon-dollar-sign'
      else
        'icon-activity'
      end
  
      content_tag(:i, nil, class: icon_class)
    end
  
    def activity_title(activity)
      case activity.action_type
      when 'project_created'
        "#{activity.user.name} created project #{activity.trackable.name}"
      when 'project_updated'
        "#{activity.user.name} updated project #{activity.trackable.name}"
      when 'comment_added'
        "#{activity.user.name} commented on #{activity.trackable.commentable_type.downcase} #{activity.trackable.commentable.name}"
      when 'task_completed'
        "#{activity.user.name} completed task #{activity.trackable.name}"
      when 'member_added'
        "#{activity.user.name} added #{activity.trackable.name} to the team"
      when 'investment_received'
        "#{activity.user.name} received investment of #{number_to_currency(activity.trackable.amount)}"
      else
        activity.description
      end
    end
  
    def project_status_badge(status)
      class_name = case status
      when 'active'
        'badge--success'
      when 'pending'
        'badge--warning'
      when 'completed'
        'badge--info'
      when 'on_hold'
        'badge--secondary'
      else
        'badge--default'
      end
  
      content_tag(:span, status.titleize, class: "badge #{class_name}")
    end
end