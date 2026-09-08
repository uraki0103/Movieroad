import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image", "counter"]
  static values = { urls: Array, index: Number }

  open(event) {
    this.indexValue = event.params.index
    this.showCurrent()
    this.modalTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
  }

  next() {
    this.indexValue = (this.indexValue + 1) % this.urlsValue.length
    this.showCurrent()
  }

  prev() {
    this.indexValue = (this.indexValue - 1 + this.urlsValue.length) % this.urlsValue.length
    this.showCurrent()
  }

  showCurrent() {
    this.imageTarget.src = this.urlsValue[this.indexValue]
    this.counterTarget.textContent = `${this.indexValue + 1} / ${this.urlsValue.length}`
  }

  closeOnBackground(event) {
    if (event.target === this.modalTarget) this.close()
  }
}