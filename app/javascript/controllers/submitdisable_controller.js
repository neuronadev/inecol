import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submitdisable"
export default class extends Controller {
  static values = { with: String }
  connect() {
  }

   handle(event) {
      const button = event.currentTarget
      const disableWith = this.withValue

      if (button.dataset.disabled) {
            event.preventDefault()
      } else {
        button.dataset.disabled = true
        button.innerHTML = disableWith
      }
   }
}
