import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trixfile"
export default class extends Controller {
  connect() {
       this.element.querySelectorAll('a').forEach(function (link) {
                      link.target = "_blank"
        })
  }
}
