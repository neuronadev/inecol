import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content

// Connects to data-controller="modificatorio"
export default class extends Controller {
  connect() {
  }

  async aplicarproceso(){
      var py = document.getElementById('btnmod')
      var idpy = py.dataset.idxpy;
      py.innerText = 'Procesando información, un momento...'
      py.disabled = true
      py.style.backgroundColor = 'gray'
      
        try{
              var data = await fetch('/modificatorios/aplicarmod',{
                                      method: 'POST',
                                      headers: {'Content-Type':'application/json', 'Accept':'application/json', 'X-CSRF-Token': token },
                                      body: JSON.stringify( {idpy:idpy} )
                                    })
                                    .then(response=>response.json())
                                    .then( data=>{ 
                                                     if (data.mensaje == "success"){
                                                           var div_conten = document.getElementById("cont_data")
                                                           var row_conten = document.getElementById("rw_success")
                                                           var td_conten = document.getElementById("cont_success")
                                                           row_conten.style.display = "table-row"
                                                           td_conten.innerHTML =  `<span>Proyecto en proceso de modificación. Fecha de inicio: ${data.fecha} </span>`
                                                           py.innerText = 'Proceso realizado correctamente.'
                                                           py.style.backgroundColor = 'blue'
                                                     }
                                                } )
        } catch(e){ alert(e) }
    }

}
