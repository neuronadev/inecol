import { Controller } from "@hotwired/stimulus"
var token = document.querySelector('meta[name="csrf-token"]').content

export default class extends Controller {
  connect() { console.log("okoko")  }

  async generar(event){
    let r = confirm("Con esta acción estará firmando electrónicamente, ¿Desea continuar?");
    if (r){
      try {
            var data = await fetch('/firmas/generar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'Accept':'application/json', 'X-CSRF-Token':token },
                body: JSON.stringify({ proyecto_id:event.params.proyecto })
            })
            .then(response => response.json())
            .then(data => {
                  console.log(data)
                  let el = document.getElementById("target_firma")
                  el.innerHTML =  `<div class="flex-col">
                                        <div><strong>${data.nombre}</strong></div>
                                        <div><strong>Firma Electrónica</strong></div>
                                        <div class="ml-50"><p>${data.s}</p></div>
                                    </div>`  
            })
      } catch (e) { alert(e) } 
    }  
  }

}
