import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [ "burger", "menu" ]
  connect() {
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }
}
