class DashboardChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    stream_from "dashboard_updates"
  end

  def receive(data)
    case data['action']
    when 'refresh_widget'
      refresh_widget(data['widget_id'])
    when 'update_layout'
      update_layout(data['layout'])
    end
  end
  

  private

  def refresh_widget(widget_id)
    widget = current_user.dashboard_widgets.find(widget_id)
    html = DashboardWidgetRenderer.new(widget).render
    broadcast_to(current_user, { widget_id: widget_id, html: html })
  end
end