import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["chips", "input"]

  addFromInput() {
    const name = this.inputTarget.value.trim()
    if (name === "") return
    this.addChip(name)
    this.inputTarget.value = ""
  }

  addExisting(event) {
    this.addChip(event.params.name)
  }

  addChip(name) {
    const existingNames = Array.from(this.chipsTarget.querySelectorAll("input[type=hidden]")).map(i => i.value)
    if (existingNames.includes(name)) return

    const chip = document.createElement("span")
    chip.className = "inline-flex items-center gap-1 bg-amber-50 text-amber-900 text-xs px-3 py-1 rounded-full"

    const hidden = document.createElement("input")
    hidden.type = "hidden"
    hidden.name = "record[companion_names][]"
    hidden.value = name

    const removeBtn = document.createElement("button")
    removeBtn.type = "button"
    removeBtn.textContent = "×"
    removeBtn.className = "ml-1 text-amber-700 hover:text-amber-900"
    removeBtn.setAttribute("data-action", "companion-picker#remove")

    chip.append(document.createTextNode(name), hidden, removeBtn)
    this.chipsTarget.appendChild(chip)
  }

  remove(event) {
    event.target.closest("span").remove()
  }
}