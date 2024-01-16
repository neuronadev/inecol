import { Controller } from "@hotwired/stimulus"
let token = document.querySelector('meta[name="csrf-token"]').content
// Connects to data-controller="email"
export default class extends Controller {
  connect() {}
  
  async enviar(event){
      let el = document.getElementById("cr_email")
      try {
          var data = await fetch('/dictamenes/notificar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                body: JSON.stringify({ cuentas: el.value, dictamen: event.params.iddict })
          })
            .then(response => response.text())
            .then(data => {
                      alert("El dictamen ha sido enviado.")
            })
      }catch (e) { alert(e) }

  }
     
}