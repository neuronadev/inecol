import { Controller } from "@hotwired/stimulus"
let token = document.querySelector('meta[name="csrf-token"]').content
export default class extends Controller {
     connect() {}
     async enviar() {
        try {
          var data = await fetch('/correos/enviarmail', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                body: JSON.stringify({ idnac: 'AAAAA' })
          })
            .then(response => response.text())
            .then(data => {
                      console.log(data)
            })
        }catch (e) { alert(e) }

     }
}