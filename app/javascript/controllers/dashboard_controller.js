import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["widget", "metric", "chart"]

  connect() {
    this.establishConnection()
    this.initializeWidgets()
  }

  establishConnection() {
    this.channel = consumer.subscriptions.create("DashboardChannel", {
      received: this.handleUpdate.bind(this)
    })
  }

  handleUpdate(data) {
    if (data.widget_id) {
      this.updateWidget(data)
    } else if (data.metric_id) {
      this.updateMetric(data)
    }
  }

  updateWidget(data) {
    const widget = this.widgetTargets.find(w => w.dataset.id === data.widget_id)
    if (widget) {
      widget.innerHTML = data.html
      this.initializeWidget(widget)
    }
  }

  initializeWidgets() {
    this.widgetTargets.forEach(widget => this.initializeWidget(widget))
  }
}