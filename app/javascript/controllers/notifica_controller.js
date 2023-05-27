import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content
// Connects to data-controller="notifica"
export default class extends Controller {
  connect() {
  }

  enlaceAtendido(event){
       this.enlaceUpdateAtendido(event.params.idenlace).then(result => {
                var el = event.target.closest('[role="alert"]')
                el.remove()
            })
  }

  enlaceEnterado(event){
    this.enlaceUpdateEnterado(event.params.idenlace).then(result => {
             var el = event.target.closest('[role="alert"]')
             el.remove()
         })
}

  async enlaceUpdateAtendido(id_enlace){
        try{
             var data = await fetch('/enlaces/atendido', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
                  body: JSON.stringify({ enlace_id: id_enlace })
             })
             .then(response => response.json())
             return data

        }catch(e){alert(e)}
  }

  async enlaceUpdateEnterado(id_enlace){
    try{
         var data = await fetch('/enlaces/enterado', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': token },
              body: JSON.stringify({ enlace_id: id_enlace })
         })
         .then(response => response.json())
         return data

    }catch(e){alert(e)}
}

}
