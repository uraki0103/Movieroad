import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tag-picker"
export default class extends Controller {
  static targets = ["input"]

  select(event) {
    this.inputTarget.value = event.params.name
    this.inputTarget.focus()
  }
}
