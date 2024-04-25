import { Controller } from "@hotwired/stimulus"

var token = document.querySelector('meta[name="csrf-token"]').content

// Connects to data-controller="modificatorio"
export default class extends Controller {
  connect() {
  }

  async aplicarproceso(){
      var py = document.getElementById('btnmod')
      var idpy = py.dataset.idxpy;

        try{
              var data = await fetch('/modificatorios/aplicarmod',{
                                      method: 'POST',
                                      headers: {'Content-Type':'application/json', 'Accept':'application/json', 'X-CSRF-Token': token },
                                      body: JSON.stringify( {idpy:idpy} )
                                    })
                                    .then(response=>response.text())
                                    .then( data=>{ 
                                                     console.log(data)
                                                } )
        } catch(e){ alert(e) }
    }

}
