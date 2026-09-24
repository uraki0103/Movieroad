// app/javascript/controllers/tag_tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["theaterPanel", "companionPanel", "theaterTabButton", "companionTabButton"]

  show(event) {
    const target = event.params.target

    this.theaterPanelTarget.classList.toggle("hidden", target !== "theater")
    this.companionPanelTarget.classList.toggle("hidden", target !== "companion")

    this.theaterTabButtonTarget.classList.toggle("bg-amber-900", target === "theater")
    this.theaterTabButtonTarget.classList.toggle("text-white", target === "theater")
    this.theaterTabButtonTarget.classList.toggle("bg-stone-100", target !== "theater")
    this.theaterTabButtonTarget.classList.toggle("text-stone-600", target !== "theater")

    this.companionTabButtonTarget.classList.toggle("bg-amber-900", target === "companion")
    this.companionTabButtonTarget.classList.toggle("text-white", target === "companion")
    this.companionTabButtonTarget.classList.toggle("bg-stone-100", target !== "companion")
    this.companionTabButtonTarget.classList.toggle("text-stone-600", target !== "companion")
  }
}