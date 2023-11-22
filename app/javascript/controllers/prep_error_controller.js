import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="prep-error"
export default class extends Controller {
  connect() {
       alert("La suma total de los capitulos debe ser igual al total para gastos.")
  }
}
