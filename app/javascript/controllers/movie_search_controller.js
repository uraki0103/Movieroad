import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "titleInput", "hiddenTmdbId", "hiddenReleaseYear", "hiddenPosterUrl"]

  open() {
    this.modalTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
  }

  closeOnBackground(event) {
    if (event.target === this.modalTarget) this.close()
  }

  select(event) {
    this.titleInputTarget.value = event.params.title
    this.hiddenTmdbIdTarget.value = event.params.tmdbId
    this.hiddenReleaseYearTarget.value = event.params.releaseYear
    this.hiddenPosterUrlTarget.value = event.params.posterUrl
    this.close()
  }

  clearTmdbId() {
    this.hiddenTmdbIdTarget.value = ""
    this.hiddenReleaseYearTarget.value = ""
    this.hiddenPosterUrlTarget.value = ""
  }
}