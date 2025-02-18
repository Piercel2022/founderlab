import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["lightIcon", "darkIcon"]

  connect() {
    this.updateIcons()
  }

  toggle() {
    const html = document.documentElement
    const currentTheme = html.getAttribute("data-theme")
    const newTheme = currentTheme === "light" ? "dark" : "light"
    
    html.setAttribute("data-theme", newTheme)
    this.updateIcons()
    this.saveThemePreference(newTheme)
  }

  updateIcons() {
    const currentTheme = document.documentElement.getAttribute("data-theme")
    this.lightIconTarget.classList.toggle("hidden", currentTheme === "light")
    this.darkIconTarget.classList.toggle("hidden", currentTheme === "dark")
  }

  async saveThemePreference(theme) {
    try {
      await fetch("/api/preferences/theme", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({ theme })
      })
    } catch (error) {
      console.error("Failed to save theme preference:", error)
    }
  }
}